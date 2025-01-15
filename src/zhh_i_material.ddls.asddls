@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface of Material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_I_Material
  as select from zhh_material
  association [1..1] to I_Currency      as _Currency on $projection.Currency = _Currency.Currency
  association [1..1] to I_UnitOfMeasure as _Unit     on $projection.StockUnit = _Unit.UnitOfMeasure
{
  key material       as MaterialNumber,
      name           as MaterialName,
      description    as MaterialDescription,
      @Semantics.quantity.unitOfMeasure: 'StockUnit'
      stock          as Stock,
      stock_unit     as StockUnit,
      @Semantics.amount.currencyCode: 'Currency'
      price_per_unit as PricePerUnit,
      currency       as Currency,

      _Currency,
      _Unit
}
