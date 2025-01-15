@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface of Discount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_I_Discount
  as select from zhh_discount
  association [1..1] to ZHH_I_Partner  as _Partner  on $projection.PartnerNumber = _Partner.PartnerNumber
  association [1..1] to ZHH_I_Material as _Material on $projection.MaterialNumber = _Material.MaterialNumber
{
  key partner  as PartnerNumber,
  key material as MaterialNumber,
      discount as Discount,

      _Partner,
      _Material
}
