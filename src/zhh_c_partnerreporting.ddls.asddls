@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reporting for Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_PartnerReporting
  with parameters
    @Environment.systemField: #SYSTEM_DATE
    P_CalculationDate : abap.dats
  as select from ZHH_C_PartnerSum
{
  key PartnerNumber,
      PositionCurrency,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      PriceForPartnerMaterial,
      @Semantics.amount.currencyCode: 'CurrencyUSD'
      currency_conversion(
        amount => PriceForPartnerMaterial,
        source_currency => PositionCurrency,
        target_currency => cast( 'USD' as abap.cuky(5)),
        exchange_rate_date => $parameters.P_CalculationDate,
        exchange_rate_type => 'M',
        round => 'X',
        error_handling => 'SET_TO_NULL') as PriceInUSD,
      cast('USD' as abap.cuky(5))        as CurrencyUSD
}
