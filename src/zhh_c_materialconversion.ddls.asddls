@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Conversion for Units'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_MaterialConversion as select from ZHH_I_Material
{
  key MaterialNumber,
  MaterialName,
  @Semantics.quantity.unitOfMeasure: 'stockunit'
  Stock,
  StockUnit,
  @Semantics.quantity.unitOfMeasure: 'TargetUnit'
  unit_conversion(
    quantity=>Stock,
    source_unit=>StockUnit,
    target_unit=>cast('ST' as abap.unit(3)),
    error_handling=>'SET_TO_NULL'
  ) as UnitinPieces,
  cast('ST' as abap.unit(3)) as TargetUnit
}
