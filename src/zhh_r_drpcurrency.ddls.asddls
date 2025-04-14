@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Currency Overview'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZHH_R_DRPCurrency as select from I_Currency
  composition of many ZHH_I_DRPCurrencyCountry as _Country
  association of one to one ZHH_B_DRPAdditionalCurrency as _Data on _Data.Currency = $projection.Currency  
{
  key Currency,
  Decimals,
  CurrencyISOCode,
  AlternativeCurrencyKey,
  _Text[ Language = $session.system_language].CurrencyName,
  _Text[ Language = $session.system_language].CurrencyShortName,
  _Data.CurrencyComment,
  _Data.Documentation,
  _Data.PictureURL,  
  _Data.LastEditor,
  _Data.LastChanged,
  _Data.LocalLastChanged,
  _Country  
}
