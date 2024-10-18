class CommonData{
  static List<String> statusRawData(){
    return ["Available","Not Available",];
  }

  static List<String> couponStatusRawData(){
    return ["Active","In-Active",];
  }

  static List<String> getOrderStatusList(){
    return ["Order Placed","Order Shipped","Order Delivered","Pending"];
  }

  /*static String updateOrderStatus(String status){
    if(status =="order_placed"){
      return "Order Placed";
    }else if(status =="order_shipped"){
      return "Order Shipped";
    }else if(status =="order_delivered"){
      return "Order Delivered";
    }
    return "Pending";
  }*/
}