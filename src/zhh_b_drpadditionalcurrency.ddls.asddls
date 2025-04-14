@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Additional Informations'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZHH_B_DRPAdditionalCurrency
  as select from zhh_drp_addcurr
{
  key currency           as Currency,
      ccomment           as CurrencyComment,
      documentation      as Documentation,
      picture_url        as PictureURL,
      last_editor        as LastEditor,
      last_changed       as LastChanged,
      local_last_changed as LocalLastChanged
}
