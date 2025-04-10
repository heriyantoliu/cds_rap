@EndUserText.label: 'Create Invoice'
define root abstract entity ZHH_S_RAPCreateinvoice

{
  key DummyKey: abap.char(1);

      Document: abap.char(8);
      Partner: abap.char(10);
      _Position: composition [0..*] of Zhh_S_Rapcreateposition;
}
