CLASS zcl_hh_demo_action_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hh_demo_action_eml IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    modify entities of zhh_i_rappartner
      entity partner
      execute fillEmptyStreets
      from value #( ( partnernumber = '1000000007' ) )
      result data(lt_new_partner)
      mapped data(ls_mapped)
      failed data(ls_failed)
      reported data(ls_reported).

    commit entities.

    if line_exists( lt_new_partner[ 1 ] ).
      out->write( lt_new_partner[ 1 ]-PartnerNumber ).
      out->write( lt_new_partner[ 1 ]-%param ).
    else.
      out->write( 'Not Worked' ).
    endif.
  ENDMETHOD.
ENDCLASS.
