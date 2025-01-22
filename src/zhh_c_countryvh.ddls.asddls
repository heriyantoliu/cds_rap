@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help for Country'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
define view entity Zhh_C_Countryvh
  as select from I_Country
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #HIGH
  @ObjectModel.text.element: ['Description']
  key Country,
  
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #LOW
  _Text[1: Language = $session.system_language ].CountryName as Description
}
