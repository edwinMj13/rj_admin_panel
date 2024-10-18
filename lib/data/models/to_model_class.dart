
import 'package:project_rj_admin_panel/data/models/order_cart_purchase_model.dart';

class ToModelClass {
  static OrderCartPurchaseModel toPurchaseModel(item){
    return OrderCartPurchaseModel(
      itemName: item["itemName"],
      itemCategory: item["itemCategory"],
      itemFirebaseNodeId: item["itemFirebaseNodeId"],
      itemProductId: item["itemProductId"],
      itemStatus: item["itemStatus"],
      itemMrp: item["itemMrp"],
      imagesList: item["imagesList"],
      itemCartedQuantity: item["itemCartedQuantity"],
      itemPrice: item["itemPrice"],
      itemSubCategory: item["itemSubCategory"],
      itemCartedLastAmt: item["itemCartedLastAmt"],
      itemDiscountAmt: item["itemDiscountAmt"],
      itemDiscountPercent: item["itemDiscountPercent"],
      itemDescription: item["itemDescription"],
      itemBrand: item["itemBrand"],
      itemMainImage: item["itemMainImage"],
      itemSellingPrize: item["itemSellingPrize"],
    );
  }
}