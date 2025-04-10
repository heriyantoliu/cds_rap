@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Unmanaged Root'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZHH_R_DMOUnmanaged as select from zhh_dmo_unmgnd
{
  key gen_key as TableKey,
  text as Description,
  cdate as CreationDate
}
