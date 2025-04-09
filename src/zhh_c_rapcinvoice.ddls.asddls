@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZHH_C_RAPCInvoice
  provider contract transactional_query
  as projection on ZHH_R_RAPCInvoice
{
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 1.0
  key     Document,
          DocDate,
          DocTime,
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          Partner,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_HH_DEMO_CRAP_VE_EXIT'
  virtual NumberOfPositions : abap.int4,
          /* Associations */
          _Position : redirected to composition child ZHH_C_RAPCPosition
}
