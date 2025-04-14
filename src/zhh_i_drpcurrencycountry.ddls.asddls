@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Country Assignment'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_I_DRPCurrencyCountry as select from ZHH_B_DRPCurrencyCountry
association to parent ZHH_R_DRPCurrency as _Currency on _Currency.Currency = $projection.Currency
association of one to one I_Country as _Country on _Country.Country = $projection.Country
{
  key Currency,
  key Country,
  _Country._Text[ Language = $session.system_language].CountryName,
  CountryRanking,
  _Currency
}
