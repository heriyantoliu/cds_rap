CLASS lhc_Currency DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Currency RESULT result.

ENDCLASS.


CLASS lhc_Currency IMPLEMENTATION.
  METHOD get_instance_authorizations.
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
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.
ENDCLASS.
