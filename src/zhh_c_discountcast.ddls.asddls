@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Discount Cast'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_DiscountCast
  as select from ZHH_I_Discount
{
  key PartnerNumber,
  key MaterialNumber,
      DiscountValue,
      concat( cast( DiscountValue as abap.char(15) ), ' %') as DiscountText
}
