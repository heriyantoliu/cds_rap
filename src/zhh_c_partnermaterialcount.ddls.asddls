@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Count for Partner and Material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_PartnerMaterialCount
  as select from ZHH_I_Position
{
  key _Invoice.PartnerNumber,
  key MaterialNumber,
      count( * ) as NumberOfDocuments
}
group by
  _Invoice.PartnerNumber,
  MaterialNumber
