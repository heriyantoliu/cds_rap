@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAP Consumption for partner'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity Zhh_C_RAPPartner
  provider contract transactional_query
  as projection on ZHH_I_RAPPartner
{  
      key PartnerNumber,
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'Zhh_I_RAPCustomEntityCNames', element: 'CompanyName'} }]      
      PartnerName,
      Street,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZHH_I_RAPCityVH', element: 'City' } }]
      City,
      Country,
      PaymentCurrency,
      LastChangedAt,
      LastChangedBy,
      CreatedAt,
      CreatedBy,
      LocalLastChangedAt
}
