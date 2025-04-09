CLASS zcl_hh_demo_crap_eml DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    METHODS read_data
      IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

    METHODS insert_data
      IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

    METHODS delete_data
      IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.


CLASS zcl_hh_demo_crap_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    read_data( out ).
    insert_data( out ).
    delete_data( out ).
  ENDMETHOD.

  METHOD delete_data.
    DATA lt_filter TYPE TABLE OF ZHH_R_RAPCInvoice WITH EMPTY KEY.

    lt_filter = VALUE #( ( document = '40000000' ) ).

    MODIFY ENTITIES OF ZHH_R_RAPCInvoice
           ENTITY invoice
           DELETE FROM CORRESPONDING #( lt_filter )
           FAILED DATA(ls_failed).

    COMMIT ENTITIES.

    IF ls_failed-invoice IS NOT INITIAL.
      io_out->write( `Failed!` ).
    ELSE.
      io_out->write( `Deletion OK` ).
    ENDIF.
  ENDMETHOD.

  METHOD insert_data.
    DATA lt_new_invoice  TYPE TABLE FOR CREATE ZHH_R_RAPCInvoice.
    DATA lt_new_position TYPE TABLE FOR CREATE ZHH_R_RAPCInvoice\_Position.

    lt_new_invoice = VALUE #( ( %cid     = 'B1'
                                document = '40000000'
                                Partner  = '1000000004'
                                %control = VALUE #( Document = if_abap_behv=>mk-on
                                                    Partner  = if_abap_behv=>mk-on ) ) ).

    lt_new_position = VALUE #( ( %cid_ref = 'B1'
                                 %target  = VALUE #(
                                     ( %cid           = 'P1'
                                       PositionNumber = 1
                                       Material       = 'R0001'
                                       %control       = VALUE #( PositionNumber = if_abap_behv=>mk-on
                                                                 Material       = if_abap_behv=>mk-on ) )
                                     ( %cid           = 'P2'
                                       PositionNumber = 2
                                       Price          = '2.20'
                                       Currency       = 'EUR'
                                       %control       = VALUE #( PositionNumber = if_abap_behv=>mk-on
                                                                 Price          = if_abap_behv=>mk-on
                                                                 Currency       = if_abap_behv=>mk-on ) ) ) ) ).

    MODIFY ENTITIES OF ZHH_R_RAPCInvoice
           ENTITY invoice
           CREATE FROM lt_new_invoice
           ENTITY invoice
           CREATE BY \_position FROM lt_new_position
           FAILED DATA(ls_failed).

    COMMIT ENTITIES.

    IF ls_failed-invoice IS NOT INITIAL.
      io_out->write( `Failed!` ).
    ELSE.
      io_out->write( `Creation OK` ).
    ENDIF.
  ENDMETHOD.

  METHOD read_data.
    DATA lt_filter TYPE TABLE OF ZHH_R_RAPCInvoice WITH EMPTY KEY.

    lt_filter = VALUE #( ( Document = '30000000' )
                         ( Document = '30000005' ) ).

    READ ENTITIES OF ZHH_R_RAPCInvoice ENTITY invoice
         ALL FIELDS WITH CORRESPONDING #( lt_filter )
         RESULT DATA(lt_invoice)
         ENTITY invoice BY \_Position
         FIELDS ( document PositionNumber Material )
         WITH CORRESPONDING #( lt_filter )
         RESULT DATA(lt_position)
         FAILED FINAL(ls_failed).

    IF ls_failed-invoice IS NOT INITIAL.
      io_out->write( `Failed!` ).
    ENDIF.

    io_out->write( `Invoices:` ).
    io_out->write( lt_invoice ).
    io_out->write( `Positions:` ).
    io_out->write( lt_position ).
  ENDMETHOD.
ENDCLASS.
