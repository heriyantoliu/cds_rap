@EndUserText.label: 'Custom Entity for company names'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_HH_DEMO_CUST_CNAME_QUERY'
define custom entity ZHH_I_RAPCustomEntityCNames 
{
  key CompanyName        : abap.char( 60 );
      Branch             : abap.char( 50 );
      CompanyDescription : abap.char( 255 );  
}
