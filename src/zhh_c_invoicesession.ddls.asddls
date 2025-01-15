@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Session'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_InvoiceSession
  as select from ZHH_I_Invoice
{
  key DocumentNumber,
      DocumentDate,
      $session.system_language as SystemLanguage
}
where
  DocumentDate < $session.system_date
