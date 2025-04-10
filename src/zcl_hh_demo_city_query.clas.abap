CLASS zcl_hh_demo_city_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hh_demo_city_query IMPLEMENTATION.

  METHOD if_rap_query_provider~select.
    data: lt_values type table of ZHH_I_RAPCityVH.

    lt_values = VALUE #( ( City = 'Walldorf' CityShort = 'DE' )
                          ( City = 'Redmond' CityShort = 'US' )
                          ( City = 'Menlo Park' CityShort = 'US' )
                          ( City = 'Hangzhou' CityShort = 'CN' )
                          ( City = 'Munich' CityShort = 'DE' )
                          ( City = 'Vevey' CityShort = 'CH' )
                          ( City = 'Sankt Petersburg' CityShort = 'RU' )
                          ( City = 'Seattle' CityShort = 'US' )
                          ( City = 'Wolfsburg' CityShort = 'DE' )
                          ( City = 'Cologne' CityShort = 'DE' ) ).

    data(ld_all_entries) = lines( lt_values ).

    new zcl_hh_demo_adjust_data( )->adjust_via_request(
      EXPORTING
        io_request = io_request
      CHANGING
        ct_data    = lt_values
    ).

    if io_request->is_data_requested( ).
      io_response->set_data( lt_values ).
    endif.

    if io_request->is_total_numb_of_rec_requested( ).
      io_response->set_total_number_of_records( conv #( ld_all_entries ) ).
    endif.
  ENDMETHOD.
ENDCLASS.
