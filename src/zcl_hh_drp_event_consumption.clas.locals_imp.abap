*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_local_events DEFINITION INHERITING FROM cl_abap_behavior_event_handler.
  private section.
    types ts_parameter type structure for event ZHH_R_DRPCurrency\\Currency~AfterExcelLoad.

    methods after_excel_load for entity event it_parameters for Currency~AfterExcelLoad.
endclass.

CLASS lcl_local_events IMPLEMENTATION.

  METHOD after_excel_load.

    loop at it_parameters into data(ls_parameter).

    endloop.

  ENDMETHOD.

ENDCLASS.
