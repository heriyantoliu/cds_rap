CLASS zcl_hh_demo_simple_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hh_demo_simple_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_selection TYPE TABLE FOR READ IMPORT zhh_i_rappartner,
          lt_creation  TYPE TABLE FOR CREATE zhh_i_rappartner,
          lt_update    TYPE TABLE FOR UPDATE zhh_i_rappartner.


    lt_selection = VALUE #(
      ( PartnerNumber = '1000000001' )
      ( PartnerNumber = '1000000003' )
    ).

    READ ENTITIES OF zhh_i_rappartner ENTITY Partner
      ALL FIELDS WITH lt_selection
      RESULT DATA(lt_partner_long)
      FAILED DATA(ls_failed)
      REPORTED DATA(ls_reported).

    out->write( lt_partner_long ).

    READ ENTITIES OF zhh_i_rappartner ENTITY partner
    FIELDS ( partnername street city )
    WITH VALUE #(
      ( PartnerNumber = '1000000001' )
      ( PartnerNumber = '1000000003' )
    )
    RESULT DATA(lt_partner_short)
    FAILED ls_failed
    REPORTED ls_reported.

    out->write( lt_partner_short ).

    lt_creation = VALUE #(
      ( %cid                   = 'DummyKey1'
        PartnerNumber          = '1000000007'
        PartnerName            = 'Amazon'
        Country                = 'US'
        %control-PartnerNumber = if_abap_behv=>mk-on
        %control-partnerName   = if_abap_behv=>mk-on
        %control-country       = if_abap_behv=>mk-on )
    ).

    MODIFY ENTITIES OF zhh_i_rappartner ENTITY partner
      CREATE FROM lt_creation
      FAILED ls_failed
      MAPPED DATA(ls_mapped)
      REPORTED ls_reported.

    TRY.
        out->write( ls_mapped-partner[ 1 ]-PartnerNumber ).
        COMMIT ENTITIES.
      CATCH cx_sy_itab_line_not_found.
        out->write( ls_failed-partner[ 1 ]-%cid ).
    ENDTRY.

    lt_update = VALUE #(
      ( PartnerNumber            = '1000000007'
        PartnerName              = 'Amazon Fake'
        City                     = 'Seattle'
        PaymentCurrency          = 'USD'
        %control-PaymentCurrency = if_abap_behv=>mk-on
        %control-City            = if_abap_behv=>mk-on )
    ).

    modify entities of zhh_i_rappartner entity partner
      update from lt_update
      failed ls_failed
      mapped ls_mapped
      reported ls_reported.

    if ls_failed-partner is initial.
      out->write( 'Updated' ).
      commit entities.
    endif.
  ENDMETHOD.
ENDCLASS.
