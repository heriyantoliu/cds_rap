@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_HH_DMO_GEN1
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_HH_DMO_GEN1
{
  key UuidKey,
  Description,
  Price,
  @Semantics.currencyCode: true
  Currency,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
