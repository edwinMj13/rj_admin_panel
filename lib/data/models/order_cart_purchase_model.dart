class OrderCartPurchaseModel {
  final String itemName;
  final String itemCategory;
  final String? itemSubCategory;
  final String itemMainImage;
  final String itemDescription;
  final String itemBrand;
  final String? itemPrice;
  final String itemSellingPrize;
  final String itemFirebaseNodeId;
  final String itemProductId;
  final String itemCartedQuantity;
  final String itemCartedLastAmt;
  final String itemDiscountPercent;
  final String itemStatus;
  final String itemMrp;
  final String itemDiscountAmt;
  final List<dynamic> imagesList;

  OrderCartPurchaseModel(
      {required this.itemName,
      required this.itemCategory,
      required this.itemFirebaseNodeId,
      required this.itemProductId,
      required this.itemStatus,
      required this.imagesList,
      required this.itemMrp,
      this.itemSubCategory,
      required this.itemCartedQuantity,
      required this.itemCartedLastAmt,
      required this.itemDiscountAmt,
      required this.itemDiscountPercent,
      required this.itemDescription,
      required this.itemBrand,
      required this.itemMainImage,
      this.itemPrice,
      required this.itemSellingPrize});

  Map<String, dynamic> toMap() {
    return {
     "itemName":itemName,
     "itemCategory":itemCategory,
     "itemSubCategory":itemSubCategory,
     "itemMainImage":itemMainImage,
     "itemDescription":itemDescription,
     "itemBrand":itemBrand,
     "itemPrice":itemPrice,
     "itemMrp":itemMrp,
    "itemSellingPrize":itemSellingPrize,
    "itemFirebaseNodeId":itemFirebaseNodeId,
    "itemProductId":itemProductId,
    "itemCartedQuantity":itemCartedQuantity,
    "itemCartedLastAmt":itemCartedLastAmt,
    "itemDiscountPercent":itemDiscountPercent,
    "itemStatus":itemStatus,
    "itemDiscountAmt":itemDiscountAmt,
     "imagesList":imagesList,
    };
  }
/*CartModel toModel (e){
    return CartModel(
      itemName: e["itemName"],
      category: e["category"],
      firebaseNodeId: e["firebaseNodeId"],
      productId: e["productId"],
      status: e["status"],
      stock: e["stock"],
      totalAmount: e["totalAmount"],
      cartedQuantity: e["cartedQuantity"],
      price: e["price"],
      subCategory: e["subCategory"],
      imagesList: e["imagesList"],
      description: e["description"],
      itemBrand: e["itemBrand"],
      mainImage: e["mainImage"],
      sellingPrize: e["sellingPrize"],
    );
  }*/
}
