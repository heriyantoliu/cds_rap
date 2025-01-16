@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Union'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_Union
  as select from ZHH_C_PositionError
{
  key DocumentNumber,
  key PositionNumber,
      'Normal' as PositionType,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      PositionPrice,
      PositionCurrency
}
where
  ErrorInConversion = ''

union select from ZHH_C_PositionError
{
  key DocumentNumber,
  key PositionNumber,
      'Error'                       as PositionType,      
      cast(0.0 as abap.curr(15,2) ) as PositionPrice,
      PositionCurrency
}
where
  ErrorInConversion = 'X'
