@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface of Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_I_Partner
  as select from zhh_partner
  association [1..1] to I_Country  as _Country  on $projection.Country = _Country.Country
  association [1..1] to I_Currency as _Currency on $projection.PaymentCurrency = _Currency.Currency
{
  key partner          as PartnerNumber,
      name             as PartnerName,
      street           as Street,
      city             as City,
      country          as Country,
      payment_currency as PaymentCurrency,      

      _Country,
      _Currency
}
