@EndUserText.label: 'Entity for Popup'
define abstract entity Zhh_I_PopupEntity
{
  @Consumption.valueHelpDefinition: [{ entity:{ name: 'ZHH_C_CountryVH', element: 'Country' } }]
  @EndUserText.label: 'Search Country'
  SearchCountry : land1;
  
  @EndUserText.label: 'New Date'
  NewDate       : abap.dats;
  
  @EndUserText.label: 'Message Type'
  MessageType   : abap.int4;
  
  @EndUserText.label: 'Update data'
  FlagUpdate    : abap.char(1);
  
  @EndUserText.label: 'Show Messages'
  FlagMessage   : abap_boolean;
}
