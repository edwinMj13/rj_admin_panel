class SummaryDataModel {
  final String totalOrder;
  final String pendingOrder;
  final String completedOrder;
  final String processingOrder;
  final String totalAmountReceived;
  final String totalOrderInJan;
  final String totalOrderInFeb;
  final String totalOrderInMar;
  final String totalOrderInApr;
  final String totalOrderInMay;
  final String totalOrderInJun;
  final String totalOrderInJul;
  final String totalOrderInAug;
  final String totalOrderInSep;
  final String totalOrderInOct;
  final String totalOrderInNov;
  final String totalOrderInDec;

  SummaryDataModel(
      {required this.totalOrder,
      required this.pendingOrder,
      required this.completedOrder,
      required this.processingOrder,
      required this.totalAmountReceived,
      required this.totalOrderInJan,
      required this.totalOrderInFeb,
      required this.totalOrderInMar,
      required this.totalOrderInApr,
      required this.totalOrderInMay,
      required this.totalOrderInJun,
      required this.totalOrderInJul,
      required this.totalOrderInAug,
      required this.totalOrderInSep,
      required this.totalOrderInOct,
      required this.totalOrderInNov,
      required this.totalOrderInDec});

  Map<String, dynamic> toMap(model) {
    return {
      "totalOrder": totalOrder,
      "pendingOrder": pendingOrder,
      "completedOrder": completedOrder,
      "processingOrder": processingOrder,
      "totalAmountReceived": totalAmountReceived,
      "totalOrderInJan": totalOrderInJan,
      "totalOrderInFeb": totalOrderInFeb,
      "totalOrderInMar": totalOrderInMar,
      "totalOrderInApr": totalOrderInApr,
      "totalOrderInMay": totalOrderInMay,
      "totalOrderInJun": totalOrderInJun,
      "totalOrderInJul": totalOrderInJul,
      "totalOrderInAug": totalOrderInAug,
      "totalOrderInSep": totalOrderInSep,
      "totalOrderInOct": totalOrderInOct,
      "totalOrderInNov": totalOrderInNov,
      "totalOrderInDec": totalOrderInDec,
    };
  }
}
