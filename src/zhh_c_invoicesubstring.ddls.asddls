@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Substing of Month'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_INVOICESubstring as select from ZHH_I_Invoice
{
  key DocumentNumber,
  DocumentDate,
  substring( DocumentDate, 5, 2 ) as MonthInDocumentDate, 
  PartnerNumber
 
}
