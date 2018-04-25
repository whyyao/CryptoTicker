//final String tableSavedCurrencies = "saved_currencies";
//final String columnId = "_id";
//final String columnCurrency= "currency_code";
//final String columnAmountOwned = "amount_owned";
//
//class SavedCurrency {
//  int id;
//  String currencyCode;
//  double amountOwned;
//
//  Map toMap() {
//    Map<String, dynamic> map = {columnCurrency: currencyCode, columnAmountOwned: amountOwned};
//    if (id != null) {
//      map[columnId] = id;
//    }
//    return map;
//  }
//
//  SavedCurrency.fromMap(Map map) {
//    id = map[columnId];
//    currencyCode = map[columnCurrency];
//    amountOwned = map[columnAmountOwned];
//  }
//}
