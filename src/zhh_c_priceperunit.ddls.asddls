@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exit in CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity Zhh_C_PricePerUnit
  as select from ZHH_I_Position
{
  key DocumentNumber,
  key PositionNumber,
      _Material.MaterialName,
      @Semantics.quantity.unitOfMeasure: 'PositionUnit'
      PositionQuantity,
      PositionUnit,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      PositionPrice,
      PositionCurrency,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_HH_DEMO_CDS_EXIT'
      cast(0 as abap.curr(15,2)) as PricePerUnit
}
