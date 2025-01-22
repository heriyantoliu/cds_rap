CLASS lhc_Partner DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Partner RESULT result.
    METHODS validateisfilled FOR VALIDATE ON SAVE
      IMPORTING keys FOR partner~validateisfilled.
    METHODS validatecoredata FOR VALIDATE ON SAVE
      IMPORTING keys FOR partner~validatecoredata.
    METHODS fillcurrency FOR DETERMINE ON MODIFY
      IMPORTING keys FOR partner~fillcurrency.
    METHODS clearallemptystreets FOR MODIFY
      IMPORTING keys FOR ACTION partner~clearallemptystreets.

    METHODS fillemptystreets FOR MODIFY
      IMPORTING keys FOR ACTION partner~fillemptystreets RESULT result.
    METHODS copyline FOR MODIFY
      IMPORTING keys FOR ACTION partner~copyline.

ENDCLASS.


CLASS lhc_Partner IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateIsFilled.
    LOOP AT keys INTO DATA(ls_key) WHERE PartnerNumber IS INITIAL.
      INSERT VALUE #( PartnerNumber = ls_key-PartnerNumber )
             INTO TABLE failed-partner.

      INSERT VALUE #( PartnerNumber = ls_key-PartnerNumber
                      %msg          = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                             text     = 'Partner Number is mandatory' ) )
             INTO TABLE reported-partner.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateCoreData.
    READ ENTITIES OF zhh_i_rappartner IN LOCAL MODE
         ENTITY partner
         FIELDS ( country PaymentCurrency )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_partner_data)
         FAILED DATA(ls_failed)
         REPORTED DATA(ls_reported).

    LOOP AT lt_partner_data INTO DATA(ls_partner).
      SELECT SINGLE FROM i_country
        FIELDS country
        WHERE country = @ls_partner-country
        INTO @DATA(ld_partner_country).

      IF sy-subrc IS NOT INITIAL.
        INSERT VALUE #( PartnerNumber = ls_partner-PartnerNumber )
               INTO TABLE failed-partner.
        INSERT VALUE #( PartnerNumber    = ls_partner-PartnerNumber
                        %msg             = new_message_with_text( text = 'Country not found in I_Country' )
                        %element-country = if_abap_behv=>mk-on )
               INTO TABLE reported-partner.
      ENDIF.

*      SELECT SINGLE FROM i_currency
*        FIELDS currency
*        WHERE currency = @ls_partner-paymentcurrency
*        INTO @DATA(ld_found_currency).
*
*      IF sy-subrc IS NOT INITIAL.
*        INSERT VALUE #( PartnerNumber = ls_partner-PartnerNumber )
*               INTO TABLE failed-partner.
*        INSERT VALUE #( PartnerNumber            = ls_partner-PartnerNumber
*                        %msg                     = new_message_with_text( text = 'Currency not found in I_Currency' )
*                        %element-paymentcurrency = if_abap_behv=>mk-on )
*               INTO TABLE reported-partner.
*      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD fillCurrency.
    READ ENTITIES OF zhh_i_rappartner IN LOCAL MODE
      ENTITY partner
      FIELDS ( paymentcurrency )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_partner_data).

    LOOP AT lt_partner_data INTO DATA(ls_partner)
      WHERE paymentcurrency IS INITIAL.
      MODIFY ENTITIES OF zhh_i_rappartner IN LOCAL MODE
        ENTITY partner
        UPDATE FIELDS ( paymentcurrency )
        WITH VALUE #(
          ( %tky                     = ls_partner-%tky
            paymentcurrency          = 'EUR'
            %control-PaymentCurrency = if_abap_behv=>mk-on )
      ).
    ENDLOOP.
  ENDMETHOD.

  METHOD clearAllEmptyStreets.
    SELECT FROM zhh_partner
      FIELDS partner, street
      WHERE street = 'EMPTY'
      INTO TABLE @DATA(lt_partner_data).

    LOOP AT lt_partner_data INTO DATA(ls_partner).
      MODIFY ENTITIES OF zhh_i_rappartner IN LOCAL MODE
        ENTITY partner
        UPDATE FIELDS ( street )
        WITH VALUE #(
          ( PartnerNumber   = ls_partner-partner
            street          = ''
            %control-Street = if_abap_behv=>mk-on )
      ).

    ENDLOOP.

    INSERT VALUE #(
      %msg = new_message_with_text( text     = |{ lines( lt_partner_data ) } records changed|
                                    severity = if_abap_behv_message=>severity-success )
    ) INTO TABLE reported-partner.
  ENDMETHOD.

  METHOD fillEmptyStreets.
    READ ENTITIES OF zhh_i_rappartner IN LOCAL MODE
      ENTITY partner
      FIELDS ( street )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_partner_data).

    LOOP AT lt_partner_data INTO DATA(ls_partner).
      MODIFY ENTITIES OF zhh_i_rappartner IN LOCAL MODE
        ENTITY partner
        UPDATE FIELDS ( street )
        WITH VALUE #(
          ( %tky            = ls_partner-%tky
            street          = 'EMPTY'
            %control-street = if_abap_behv=>mk-on )
      ).

      INSERT VALUE #(
        %tky   = ls_partner-%tky
        %param = ls_partner
      ) INTO TABLE result.
    ENDLOOP.
  ENDMETHOD.

  METHOD copyLine.
    DATA: lt_creation TYPE TABLE FOR CREATE zhh_i_rappartner.

    READ ENTITIES OF zhh_i_rappartner IN LOCAL MODE
      ENTITY partner
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_partner_data).

    SELECT FROM zhh_partner
      FIELDS MAX( partner )
      INTO @DATA(ld_number).

    LOOP AT lt_partner_data INTO DATA(ls_partner).
      ld_number += 1.
      ls_partner-PartnerNumber = ld_number.
      ls_partner-partnername &&= | Copy|.

      INSERT VALUE #(
        %cid = keys[ sy-tabix ]-%cid
      ) INTO TABLE lt_creation REFERENCE INTO DATA(lr_create).

      lr_create->* = CORRESPONDING #( base ( lr_create->* ) ls_partner  ).
      lr_create->%control-PartnerNumber = if_abap_behv=>mk-on.
      lr_create->%control-PartnerName = if_abap_behv=>mk-on.
      lr_create->%control-street = if_abap_behv=>mk-on.
      lr_create->%control-city = if_abap_behv=>mk-on.
      lr_create->%control-country = if_abap_behv=>mk-on.
      lr_create->%control-PaymentCurrency = if_abap_behv=>mk-on.
    ENDLOOP.

    MODIFY ENTITIES OF zhh_i_rappartner IN LOCAL MODE
      ENTITY partner
      CREATE FROM lt_creation
      FAILED DATA(ls_failed)
      MAPPED DATA(ls_mapped)
      REPORTED DATA(ls_reported).

    mapped-partner = ls_mapped-partner.
  ENDMETHOD.

ENDCLASS.
