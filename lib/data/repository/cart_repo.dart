import 'dart:convert';

import 'package:ecommerce_project/models/cart_model.dart';
import 'package:ecommerce_project/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartLIst(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // return;
    var time = DateTime.now().toString();
    cart = [];

//convert objets to string because sharedPreferences only accepts string
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    //see information which will be saved in shared preferences
    sharedPreferences.setStringList("Cart-List",
        cart); //set w get string el 3adeen msh naf3een lazm list m3ahom
    print(sharedPreferences.getStringList("Cart-List"));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences
          .getStringList(AppConstants.CART_LIST)!; // Bomba hato
      print("inside getCartList" + cart.toString());
    }
    List<CartModel> cartList = [];

    carts.forEach((element) =>
        cartList.add(CartModel.fromJson(jsonDecode(element)))); //productModel
    return cartList;
  }
}
