CLASS zcl_hh_demo_unit_rap DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    CLASS-DATA go_environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS class_setup RAISING cx_static_check.
    CLASS-METHODS class_teardown.

    METHODS create_new_entry    FOR TESTING.
    METHODS fill_empty_streets  FOR TESTING.
    METHODS clear_empty_streets FOR TESTING.
ENDCLASS.


CLASS zcl_hh_demo_unit_rap IMPLEMENTATION.
  METHOD clear_empty_streets.
    DATA lt_clear_streets TYPE TABLE FOR ACTION IMPORT zhh_i_rappartner~clearAllEmptyStreets.

    INSERT INITIAL LINE INTO TABLE lt_clear_streets.

    MODIFY ENTITIES OF zhh_i_rappartner
           ENTITY partner
           EXECUTE clearAllEmptyStreets FROM lt_clear_streets
           " TODO: variable is assigned but never used (ABAP cleaner)
           MAPPED DATA(ls_mapped)
           " TODO: variable is assigned but never used (ABAP cleaner)
           FAILED DATA(ls_failed)
           " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(ls_reported).

    COMMIT ENTITIES
           RESPONSE OF zhh_i_rappartner
           " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(ls_commit_reported)
           " TODO: variable is assigned but never used (ABAP cleaner)
           FAILED DATA(ls_commit_failed).

    SELECT FROM zhh_partner
      FIELDS partner
      WHERE street = 'EMPTY'
      " TODO: variable is assigned but never used (ABAP cleaner)
      INTO TABLE @DATA(lt_empty_street).

    cl_abap_unit_assert=>assert_subrc( exp = 4 ).
  ENDMETHOD.

  METHOD create_new_entry.
    DATA lt_new_partner TYPE TABLE FOR CREATE zhh_i_rappartner.

    lt_new_partner = VALUE #( ( %cid                     = 'DUMMY'
                                PartnerName              = 'Do it yourself'
                                Street                   = 'Waterloo street 13'
                                City                     = 'London'
                                Country                  = 'GB'
                                PaymentCurrency          = 'GBP'
                                %control-PartnerName     = if_abap_behv=>mk-on
                                %control-Street          = if_abap_behv=>mk-on
                                %control-City            = if_abap_behv=>mk-on
                                %control-Country         = if_abap_behv=>mk-on
                                %control-PaymentCurrency = if_abap_behv=>mk-on ) ).

    MODIFY ENTITIES OF zhh_i_rappartner
           ENTITY partner
           CREATE FROM lt_new_partner
           " TODO: variable is assigned but never used (ABAP cleaner)
           MAPPED DATA(ls_mapped).

    COMMIT ENTITIES
           RESPONSE OF zhh_i_rappartner
           REPORTED DATA(ls_commit_reported)
           FAILED DATA(ls_commit_failed).

    cl_abap_unit_assert=>assert_initial( ls_commit_reported-partner ).
    cl_abap_unit_assert=>assert_initial( ls_commit_failed-partner ).

    SELECT SINGLE FROM zhh_partner
      FIELDS partner, name
      WHERE name = 'Do it yourself'
      " TODO: variable is assigned but never used (ABAP cleaner)
      INTO @DATA(ls_partner_found).

    cl_abap_unit_assert=>assert_subrc( ).
  ENDMETHOD.

  METHOD fill_empty_streets.
    DATA lt_fill_streets TYPE TABLE FOR ACTION IMPORT zhh_i_rappartner~fillEmptyStreets.

    lt_fill_streets = VALUE #( ( PartnerNumber = '2000000001' ) ).

    MODIFY ENTITIES OF zhh_i_rappartner
           ENTITY partner
           EXECUTE fillEmptyStreets FROM lt_fill_streets
           " TODO: variable is assigned but never used (ABAP cleaner)
           MAPPED DATA(ls_mapped)
           " TODO: variable is assigned but never used (ABAP cleaner)
           FAILED DATA(ls_failed)
           " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(ls_reported).

    COMMIT ENTITIES
           RESPONSE OF zhh_i_rappartner
             " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(ls_commit_reported)
           " TODO: variable is assigned but never used (ABAP cleaner)
           FAILED DATA(ls_commit_failed).

    SELECT SINGLE FROM zhh_partner
      FIELDS partner, street
      WHERE partner = 2000000001
      INTO @DATA(ls_partner_found).

    cl_abap_unit_assert=>assert_subrc( ).
    cl_abap_unit_assert=>assert_equals( exp = 'EMPTY'
                                        act = ls_partner_found-street ).
  ENDMETHOD.

  METHOD class_setup.
    DATA lt_partner TYPE TABLE OF zhh_partner WITH EMPTY KEY.

    go_environment = cl_cds_test_environment=>create(
                         i_for_entity      = 'ZHH_I_RAPPARTNER'
                         i_dependency_list = VALUE #( ( name = 'ZHH_PARTNER' type = 'TABLE' ) ) ).

    lt_partner = VALUE #(
        ( partner = '2000000001' name = 'Las Vegas Corp' country = 'US'             payment_currency = 'USD' )
        ( partner = '2000000002' name = 'Gorillas'       street  = 'Main street 10' country          = 'DE' payment_currency = 'EUR' )
        ( partner = '2000000003' name = 'Tomato Inc'     street  = 'EMPTY'          country          = 'AU' payment_currency = 'AUD' ) ).

    go_environment->insert_test_data( lt_partner ).
    go_environment->enable_double_redirection( ).
  ENDMETHOD.

  METHOD class_teardown.
    go_environment->destroy( ).
  ENDMETHOD.
ENDCLASS.
