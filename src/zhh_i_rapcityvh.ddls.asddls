@EndUserText.label: 'City Value Help'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_HH_DEMO_CITY_QUERY'
define custom entity ZHH_I_RAPCityVH

{
      @EndUserText.label: 'City'
      @EndUserText.quickInfo: 'Name of the City'
  key City: abap.char(60);

      @EndUserText.label: 'City (Short)'
      @EndUserText.quickInfo: 'Short name of the City'
      CityShort: abap.char(10);
}
