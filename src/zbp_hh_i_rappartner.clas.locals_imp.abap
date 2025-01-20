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
    read entities of zhh_i_rappartner in local mode
      entity partner
      fields ( paymentcurrency )
      with CORRESPONDING #( keys )
      result data(lt_partner_data).

    loop at lt_partner_data into data(ls_partner)
      where paymentcurrency is initial.
      modify entities of zhh_i_rappartner in local mode
        entity partner
        update fields ( paymentcurrency )
        with value #(
          ( %tky = ls_partner-%tky
            paymentcurrency = 'EUR'
            %control-PaymentCurrency = if_abap_behv=>mk-on )
        ).
    endloop.
  ENDMETHOD.

ENDCLASS.
