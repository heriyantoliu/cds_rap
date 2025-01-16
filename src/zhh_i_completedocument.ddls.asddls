@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Complete Document'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_I_CompleteDocument
  as select from ZHH_I_Position as Position
    inner join   ZHH_I_Invoice  as Head    on Head.DocumentNumber = Position.DocumentNumber
    inner join   ZHH_I_Partner  as Partner on Partner.PartnerNumber = Head.PartnerNumber
{
  key Position.DocumentNumber,
  key Position.PositionNumber,
      Head.PartnerNumber,
      Partner.PartnerName,
      Partner.City,
      Partner.Country,
      Position.MaterialNumber,
      @Semantics.quantity.unitOfMeasure: 'PositionUnit'
      Position.PositionQuantity,
      Position.PositionUnit,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      Position.PositionPrice,
      Position.PositionCurrency,
      Head.DocumentDate
}
