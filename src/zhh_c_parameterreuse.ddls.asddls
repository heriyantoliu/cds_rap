@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reuse with Parameter'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_ParameterReuse
  with parameters
    P_Date : abap.dats
  as select from ZHH_C_Parameter( P_Date: $parameters.P_Date, P_Type: 'A', P_Field: 'From Outer' )
{
  key DocumentNumber,
      DocumentDate,
      Status,
      ImportedField
}
