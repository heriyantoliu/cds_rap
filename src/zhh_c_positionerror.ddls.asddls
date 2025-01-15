@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Position with Error'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_PositionError
  as select from ZHH_I_Position
{
  key DocumentNumber,
  key PositioNumber,
      MaterialNumber,
      @Semantics.quantity.unitOfMeasure: 'PositionUnit'
      PositionQuantity,
      PositionUnit,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      PositionPrice,
      PositionCurrency,
      case PositionPrice
        when 37707 then 'X'
        else ' '
      end as ErrorInConversion
}
