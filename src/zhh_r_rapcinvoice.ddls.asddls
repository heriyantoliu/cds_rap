@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZHH_R_RAPCInvoice as select from zhh_invoice
  composition [0..*] of ZHH_I_RAPCPosition as _Position
{
  key document as Document,
  doc_date as DocDate,
  doc_time as DocTime,
  partner as Partner,
  _Position
}
