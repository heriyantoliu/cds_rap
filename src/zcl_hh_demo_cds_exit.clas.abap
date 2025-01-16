CLASS zcl_hh_demo_cds_exit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hh_demo_cds_exit IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    data: lt_view_data type table of Zhh_C_PricePerUnit with empty key.

    lt_view_data = CORRESPONDING #( it_original_data ).

    loop at lt_view_data REFERENCE INTO data(lr_view_data).
      lr_view_data->PricePerUnit = lr_view_data->PositionPrice / lr_view_data->PositionQuantity.
    endloop.

    ct_calculated_data = CORRESPONDING #( lt_view_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
