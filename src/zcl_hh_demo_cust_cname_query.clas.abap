CLASS zcl_hh_demo_cust_cname_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: tt_result TYPE STANDARD TABLE OF ZHH_I_RAPCustomEntityCNames WITH EMPTY KEY.
    METHODS: read_data_by_request
      IMPORTING
        io_request TYPE REF TO if_rap_query_request
      EXPORTING
        et_result  TYPE tt_result
        ed_count   TYPE int8.
ENDCLASS.



CLASS zcl_hh_demo_cust_cname_query IMPLEMENTATION.

  METHOD if_rap_query_provider~select.

    read_data_by_request(
      EXPORTING
        io_request = io_request
      IMPORTING
        et_result  = DATA(lt_result)
        ed_count   = DATA(ld_count)
    ).

    IF io_request->is_total_numb_of_rec_requested(  ).
      io_response->set_total_number_of_records( ld_count ).
    ENDIF.

    IF io_request->is_data_requested(  ).
      io_response->set_data( lt_result ).
    ENDIF.

  ENDMETHOD.

  METHOD read_data_by_request.
    DATA : lv_orderby TYPE string.
*    TRY.
*        DATA(lt_filter_condition) = io_request->get_filter( )->get_as_ranges( ).
*      CATCH cx_rap_query_filter_no_range.
*
*    ENDTRY.
*    DATA(lt_requested_elements) = io_request->get_requested_elements( ).
*    DATA(lt_sort_elements) = io_request->get_sort_elements( ).
*    DATA(ld_skip) = io_request->get_paging( )->get_offset( ).
*    DATA(ld_top) = io_request->get_paging( )->get_page_size( ).
*    DATA(ld_is_data_requested)  = io_request->is_data_requested( ).
*    DATA(ld_is_count_requested) = io_request->is_total_numb_of_rec_requested( ).

    DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
    IF lv_top < 0.
      lv_top = 1.
    ENDIF.

    DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).

    DATA(lt_sort)    = io_request->get_sort_elements( ).

    LOOP AT lt_sort INTO DATA(ls_sort).
      IF ls_sort-descending = abap_true.
        lv_orderby = |'{ lv_orderby } { ls_sort-element_name } DESCENDING '|.
      ELSE.
        lv_orderby = |'{ lv_orderby } { ls_sort-element_name } ASCENDING '|.
      ENDIF.
    ENDLOOP.
    IF lv_orderby IS INITIAL.
      lv_orderby = 'COMPANYNAME'.
    ENDIF.

    DATA(lv_conditions) =  io_request->get_filter( )->get_as_sql_string( ).

    SELECT * FROM zhh_i_dmo_cname
      WHERE (lv_conditions)
      ORDER BY (lv_orderby)
      INTO TABLE @et_result
      UP TO @lv_top ROWS OFFSET @lv_skip.

    ed_count = lines( et_result ).
  ENDMETHOD.

ENDCLASS.
