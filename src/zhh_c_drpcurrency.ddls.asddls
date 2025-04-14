@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Consumption for Currency'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true
@ObjectModel.semanticKey: [ 'Currency' ]

define root view entity ZHH_C_DRPCurrency
  provider contract transactional_query
  as projection on ZHH_R_DRPCurrency

{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 1.0
      @Search.ranking: #HIGH
  key Currency,

      Decimals,
      CurrencyISOCode,
      AlternativeCurrencyKey,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #MEDIUM
      CurrencyName,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #MEDIUM
      CurrencyShortName,

      CurrencyComment,
      Documentation,
      PictureURL,

      @Semantics.largeObject: { mimeType: 'ExcelMimeType',
                                fileName: 'ExcelFilename',
                                contentDispositionPreference: #INLINE,
                                acceptableMimeTypes: [ 'application/vnd.ms-excel',
                                                       'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ] }
      ExcelAttachment,

      @Semantics.mimeType: true
      ExcelMimeType,

      ExcelFilename,

      @Semantics.largeObject: { mimeType: 'PictureMimeType',
                                fileName: 'PictureFilename',
                                contentDispositionPreference: #INLINE,
                                acceptableMimeTypes: [ 'image/*' ] }
      PictureAttachment,

      @Semantics.mimeType: true
      PictureMimeType,

      PictureFilename,
      LastEditor,

      _Country : redirected to composition child ZHH_C_DRPCurrencyCountry
}
