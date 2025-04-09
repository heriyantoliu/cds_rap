@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZHH_C_RAPCInvoice
  provider contract transactional_query 
  as projection on ZHH_R_RAPCInvoice
{
  key Document,
  DocDate,
  DocTime,
  Partner,
  /* Associations */
  _Position : redirected to composition child ZHH_C_RAPCPosition
}
