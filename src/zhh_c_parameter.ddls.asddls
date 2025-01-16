@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS With Parameter'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_C_Parameter
  with parameters
    @Environment.systemField: #SYSTEM_DATE
    P_Date  : abap.dats,
    P_Type  : abap.char(1),
    P_Field : abap.char(10)
  as select from ZHH_I_Invoice
{
  key DocumentNumber,
      DocumentDate,
      _Partner.PartnerName,
      _Partner.Country,
      case $parameters.P_Type
        when 'A' then 'New'
        when 'B' then 'Old'
        else 'Unknown'
      end                 as Status,
      $parameters.P_Field as ImportedField
}
where
  DocumentDate = $parameters.P_Date
