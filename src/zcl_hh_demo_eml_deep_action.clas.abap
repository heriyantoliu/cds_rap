CLASS zcl_hh_demo_eml_deep_action DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_hh_demo_eml_deep_action IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lt_document TYPE TABLE FOR ACTION IMPORT ZHH_R_RAPCInvoice~CreateInvoiceDocument.

    TRY.
        lt_document = VALUE #( ( %cid   = to_upper( cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ) )
                                 %param = VALUE #( document  = 'TEST'
                                                   Partner   = '1000000004'
                                                   _position = VALUE #(
                                                       Unit     = 'ST'
                                                       currency = 'EUR'
                                                       ( material = 'F0001' Quantity = '2' Price = '13.12' )
                                                       ( material = 'H0001' Quantity = '1' Price = '28.54' ) ) ) ) ).
      CATCH cx_uuid_error.
        " handle exception
    ENDTRY.

    MODIFY ENTITIES OF ZHH_R_RAPCInvoice
           ENTITY invoice
           EXECUTE CreateInvoiceDocument FROM lt_document
           " TODO: variable is assigned but never used (ABAP cleaner)
           FAILED DATA(ls_failed)
           " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(ls_reported_data).
  ENDMETHOD.
ENDCLASS.
