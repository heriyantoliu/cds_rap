@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Extension'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
@AbapCatalog.extensibility.extensible: true

define view entity ZHH_C_DiscountExtension as select from ZHH_I_Discount
{
  key PartnerNumber,
  key MaterialNumber,
  DiscountValue,
  _Material.MaterialName,
  _Material.MaterialDescription
}
