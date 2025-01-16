@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Statistic for high performer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_StatisticParMat
  as select from ZHH_C_PartnerMaterialSum   as Combine
    inner join   ZHH_C_PartnerMaterialCount as Numbers on  Combine.PartnerNumber  = Numbers.PartnerNumber
                                                       and Combine.MaterialNumber = Numbers.MaterialNumber
{
  key Combine.PartnerNumber,
  key Combine.MaterialNumber,
      Combine.PositionCurrency,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      Combine.PriceForPartnerMaterial,
      Numbers.NumberOfDocuments
}
where
      Numbers.NumberOfDocuments       >= 10
  and Combine.PriceForPartnerMaterial <= 100000
