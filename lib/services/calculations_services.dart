class CalculationServices{
 static String addValues(String a,String b){
   double totalVal = double.parse(a) + double.parse(b);
   return totalVal.toStringAsFixed(2);
  }
}