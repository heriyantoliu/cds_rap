@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Country Assignment'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZHH_C_DRPCurrencyCountry as projection on ZHH_I_DRPCurrencyCountry
{
  key Currency,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CountryVH', element: 'Country' } }]
  key Country,
      CountryName,
      CountryRanking,
      _Currency : redirected to parent ZHH_C_DRPCurrency
}
