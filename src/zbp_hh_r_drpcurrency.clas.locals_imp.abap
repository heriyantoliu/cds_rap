CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.
    TYPES tt_keys TYPE TABLE FOR ACTION IMPORT ZHH_R_DRPCurrency\\Currency~LoadExcelContent.

    CLASS-DATA gt_event TYPE tt_keys.
ENDCLASS.


CLASS lhc_Currency DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    TYPES: BEGIN OF ts_excel,
             currency TYPE string,
             country  TYPE string,
             ranking  TYPE string,
             flag     TYPE string,
           END OF ts_excel.

    TYPES tt_excel TYPE TABLE OF ts_excel WITH EMPTY KEY.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Currency RESULT result.
    METHODS loadexcelcontent FOR MODIFY
      IMPORTING keys FOR ACTION currency~loadexcelcontent.

    METHODS convert_excel_file_to_table
      IMPORTING id_stream        TYPE xstring
      RETURNING VALUE(rt_result) TYPE tt_excel
      RAISING   zcx_hh_drp_excel_error.
ENDCLASS.


CLASS lhc_Currency IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD LoadExcelContent.
    DATA lt_currency_modify  TYPE TABLE FOR UPDATE ZHH_R_DRPCurrency\\Currency.
    DATA lt_countries_create TYPE TABLE FOR CREATE ZHH_R_DRPCurrency\_Country.
    DATA lt_countries_modify TYPE TABLE FOR UPDATE ZHH_R_DRPCurrency\\Country.

    READ ENTITIES OF ZHH_R_DRPCurrency IN LOCAL MODE
         ENTITY Currency FIELDS ( Currency ExcelAttachment )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_attachment)
         ENTITY currency BY \_Country ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(lt_countries).

    TRY.
        DATA(ls_key) = keys[ 1 ].
        DATA(ls_attachment) = lt_attachment[ 1 ].
      CATCH cx_sy_itab_line_not_found.
        INSERT new_message( id       = 'ZHH_DEMO_RAP_PATTERN'
                            number   = '003'
                            severity = if_abap_behv_message=>severity-error )
               INTO TABLE reported-%other.
        RETURN.
    ENDTRY.

    TRY.
        DATA(lt_excel) = convert_excel_file_to_table( ls_attachment-ExcelAttachment ).
      CATCH zcx_hh_drp_excel_error INTO DATA(lo_excel_error).
        INSERT lo_excel_error INTO TABLE reported-%other.
        RETURN.
    ENDTRY.

    INSERT new_message( id       = 'ZHH_DEMO_RAP_PATTERN'
                        number   = '005'
                        severity = if_abap_behv_message=>severity-success
                        v1       = lines( lt_excel ) )
           INTO TABLE reported-%other.

    IF ls_key-%param-TestRun = abap_true.
      INSERT new_message( id       = 'ZHH_DEMO_RAP_PATTERN'
                          number   = '004'
                          severity = if_abap_behv_message=>severity-warning )
             INTO TABLE reported-%other.
      RETURN.
    ENDIF.

    INSERT VALUE #( %tky                     = ls_attachment-%tky
                    excelattachment          = ''
                    excelmimetype            = ''
                    excelfilename            = ''
                    %control-excelattachment = if_abap_behv=>mk-on
                    %control-excelmimetype   = if_abap_behv=>mk-on
                    %control-excelfilename   = if_abap_behv=>mk-on )
           INTO TABLE lt_currency_modify.

    INSERT VALUE #( currency = ls_attachment-Currency )
           INTO TABLE lt_countries_create
           REFERENCE INTO DATA(lr_new).

    LOOP AT lt_excel INTO DATA(ls_excel)
         WHERE currency = ls_attachment-currency.
      TRY.
          DATA(ls_country) = lt_countries[ country = ls_excel-country ].

          INSERT VALUE #( currency                = ls_country-currency
                          country                 = ls_country-country
                          countryranking          = ls_excel-ranking
                          %control-countryranking = if_abap_behv=>mk-on )
                 INTO TABLE lt_countries_modify.
        CATCH cx_sy_itab_line_not_found.
          INSERT VALUE #( %cid                    = xco_cp=>uuid( )->value
                          currency                = ls_excel-currency
                          country                 = ls_excel-country
                          countryranking          = ls_excel-ranking
                          %control-currency       = if_abap_behv=>mk-on
                          %control-country        = if_abap_behv=>mk-on
                          %control-countryranking = if_abap_behv=>mk-on )
                 INTO TABLE lr_new->%target.
      ENDTRY.
    ENDLOOP.

    MODIFY ENTITIES OF ZHH_R_DRPCurrency IN LOCAL MODE
           ENTITY currency UPDATE FROM lt_currency_modify
           ENTITY country UPDATE FROM lt_countries_modify
           ENTITY currency CREATE BY \_Country FROM lt_countries_create.

    INSERT new_message( id       = 'ZHH_DEMO_RAP_PATTERN'
                        number   = '007'
                        severity = if_abap_behv_message=>severity-success
                        v1       = lines( lt_countries_create[ 1 ]-%target ) )
           INTO TABLE reported-%other.
    INSERT new_message( id       = 'ZHH_DEMO_RAP_PATTERN'
                        number   = '006'
                        severity = if_abap_behv_message=>severity-success
                        v1       = lines( lt_countries_modify ) )
           INTO TABLE reported-%other.

    INSERT ls_key INTO TABLE lcl_buffer=>gt_event.
  ENDMETHOD.

  METHOD convert_excel_file_to_table.
    IF id_stream IS INITIAL.
      RAISE EXCEPTION NEW zcx_hh_drp_excel_error( textid = VALUE #( msgid = 'ZHH_DEMO_RAP_PATTERN'
                                                                    msgno = '001' ) ).
    ENDIF.

    DATA(lo_sheet) = xco_cp_xlsx=>document->for_file_content( id_stream )->read_access( )->get_workbook( )->worksheet->at_position(
                                                                            1 ).

    IF NOT lo_sheet->exists( ).
      RAISE EXCEPTION NEW zcx_hh_drp_excel_error( textid = VALUE #( msgid = 'ZHH_DEMO_RAP_PATTERN'
                                                                    msgno = '002' ) ).
    ENDIF.

    DATA(lo_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to( )->from_column(
                           xco_cp_xlsx=>coordinate->for_alphabetic_value( 'A' ) )->from_row(
                               xco_cp_xlsx=>coordinate->for_numeric_value( 2 ) )->get_pattern( ).

    lo_sheet->select( lo_pattern )->row_stream( )->operation->write_to( REF #( rt_result ) )->set_value_transformation(
        xco_cp_xlsx_read_access=>value_transformation->string_value )->execute( ).
  ENDMETHOD.
ENDCLASS.


CLASS lsc_ZHH_R_DRPCURRENCY DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS save_modified    REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.


CLASS lsc_ZHH_R_DRPCURRENCY IMPLEMENTATION.
  METHOD save_modified.
    LOOP AT update-currency INTO DATA(ls_new_currency).
      ls_new_currency-LastEditor = cl_abap_context_info=>get_user_technical_name( ).

      INSERT zhh_drp_addcurr FROM @ls_new_currency MAPPING FROM ENTITY.
      IF sy-subrc IS NOT INITIAL.
        UPDATE zhh_drp_addcurr FROM @ls_new_currency INDICATORS SET STRUCTURE %control MAPPING FROM ENTITY.
      ENDIF.
    ENDLOOP.

    LOOP AT create-country INTO DATA(ls_new_country).
      INSERT zhh_drp_country FROM @ls_new_country MAPPING FROM ENTITY.
    ENDLOOP.

    LOOP AT update-country INTO DATA(ls_update_country).
      UPDATE zhh_drp_country FROM @ls_update_country INDICATORS SET STRUCTURE %control MAPPING FROM ENTITY.
    ENDLOOP.

    LOOP AT delete-country INTO DATA(ls_delete_country).
      DELETE zhh_drp_country FROM @( CORRESPONDING zhh_drp_country( ls_delete_country MAPPING FROM ENTITY ) ).
    ENDLOOP.

    LOOP AT lcl_buffer=>gt_event INTO DATA(ls_event).
      RAISE ENTITY EVENT ZHH_R_DRPCurrency~AfterExcelLoad
            FROM VALUE #( ( %key   = ls_event-%key
                            %param = VALUE #( EventComment = ls_event-%param-EventComment
                                              LastEditor   = cl_abap_context_info=>get_user_technical_name( ) ) ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.
ENDCLASS.
