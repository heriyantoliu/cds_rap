@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface of Invoice'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_I_Invoice as select from zhh_invoice
  association [0..*] to ZHH_I_Position as _Position on $projection.DocumentNumber = _Position.DocumentNumber
  association [1..1] to ZHH_I_Partner as _Partner on $projection.PartnerNumber = _Partner.PartnerNumber
{
  key document as DocumentNumber,
  doc_date as DocumentDate,
  doc_time as DocumentTime,
  partner as PartnerNumber,
  
  _Position,
  _Partner
}
