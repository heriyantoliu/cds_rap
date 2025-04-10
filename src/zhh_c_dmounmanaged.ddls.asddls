@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Unmanaged Consumption'

@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.query.implementedBy: 'ABAP:ZCL_HH_DEMO_UNMANAGED_QUERY'

@UI.headerInfo: { typeName: 'Unmanaged', typeNamePlural: 'Unmanaged', title.value: 'Description' }

define root view entity ZHH_C_DMOUnmanaged
  provider contract transactional_query
  as projection on ZHH_R_DMOUnmanaged

{
      @UI.facet: [ { id: 'FacetData', label: 'Data', type: #FIELDGROUP_REFERENCE, targetQualifier: 'DATA' } ]
      @UI.fieldGroup: [ { position: 10, label: 'Key' } ]
      @UI.lineItem: [ { position: 10, label: 'Key' } ]
  key TableKey,

      @UI.selectionField: [{  position: 10 }]
      @UI.lineItem: [{ position: 20, label: 'Text' }]
      @UI.fieldGroup: [{ position: 10, label: 'Text', qualifier: 'DATA' }]
      Description,

      @UI.selectionField: [{  position: 20 }]
      @UI.lineItem: [{ position: 30, label: 'Created at' }]
      @UI.fieldGroup: [{ position: 20, label: 'Created at', qualifier: 'DATA' }]
      CreationDate
}
