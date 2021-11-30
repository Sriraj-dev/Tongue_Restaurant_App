
import 'package:delivery_app/restaurantModel.dart';

class Billing{
  calculateBill(List<Map<String,dynamic>> billingItems){
    num cost = 0;
    var deliveryCharge = 20;
    billingItems.forEach((e) {
      var res = menu.firstWhere((menuItem) => menuItem['id']==e['id']);
      cost += int.parse(res['item']['cost']) * e['count'];
    });
    cost+=deliveryCharge;
    print(cost);
    return cost;
  }
}