@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner Material Sum'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_PartnerMaterialSum
  as select from ZHH_I_Position
{
  key _Invoice.PartnerNumber,
  key MaterialNumber,
      PositionCurrency,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      sum( PositionPrice ) as PriceForPartnerMaterial
}
group by
  _Invoice.PartnerNumber,
  MaterialNumber,
  PositionCurrency
