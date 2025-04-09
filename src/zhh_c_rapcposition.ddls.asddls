@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Position'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZHH_C_RAPCPosition as projection on ZHH_I_RAPCPosition as Position
{
  key Document,
  key PositionNumber,
  Material,
  @Semantics.quantity.unitOfMeasure: 'Unit'
  Quantity,
  Unit,
  @Semantics.amount.currencyCode: 'Currency'
  Price,
  Currency,
  /* Associations */
  _Invoice : redirected to parent Zhh_C_RAPCInvoice
}
