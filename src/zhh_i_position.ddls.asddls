@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Position'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_I_Position as select from zhh_position
  association[1..1] to ZHH_I_Material as _Material on $projection.MaterialNumber = _Material.MaterialNumber
  association[1..1] to ZHH_I_Invoice as _Invoice on $projection.DocumentNumber = _Invoice.DocumentNumber
{
  key document as DocumentNumber,
  key pos_number as PositionNumber,
  material as MaterialNumber,
  @Semantics.quantity.unitOfMeasure: 'PositionUnit'
  quantity as PositionQuantity,
  _Material.StockUnit as PositionUnit,
  @Semantics.amount.currencyCode: 'PositionCurrency'
  price as PositionPrice,  
  currency as PositionCurrency,
  
  _Material,
  _Invoice
}
