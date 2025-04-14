@EndUserText.label: 'Excel Popup'
define abstract entity ZHH_S_DRPExcelPopup

{
  @EndUserText.label: 'Comment'
  EventComment: abap.char(60);
  @EndUserText.label: 'Test Run'
  TestRun: abap_boolean;
}
