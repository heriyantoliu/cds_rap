@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Position'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_I_RAPCPosition
  as select from zhh_position
  association to parent ZHH_R_RAPCInvoice as _Invoice on $projection.Document = _Invoice.Document
  association [1] to ZHH_I_RAPCMaterial as _Material on $projection.Material = _Material.Material
{
  key document            as Document,
  key pos_number          as PositionNumber,
      material            as Material,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      quantity            as Quantity,
      _Material.StockUnit as Unit,
      @Semantics.amount.currencyCode: 'Currency'
      price               as Price,
      currency            as Currency,
      _Invoice
}
