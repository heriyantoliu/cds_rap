@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAP Interface for Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZHH_I_RAPPartner
  as select from zhh_partner
{
  key partner          as PartnerNumber,
      name             as PartnerName,
      street           as Street,
      city             as City,
      country          as Country,
      payment_currency as PaymentCurrency,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at  as LastChangedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by  as LastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at       as CreatedAt,
      @Semantics.user.createdBy: true
      created_by       as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt

}
