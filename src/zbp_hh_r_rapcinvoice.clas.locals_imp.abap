CLASS lhc_Invoice DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Invoice RESULT result.
    METHODS createinvoicedocument FOR MODIFY
      IMPORTING keys FOR ACTION invoice~createinvoicedocument.

ENDCLASS.


CLASS lhc_Invoice IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD CreateInvoiceDocument.
    if 0 = 0.
    endif.
  ENDMETHOD.
ENDCLASS.
