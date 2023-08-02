import 'package:ecommerce_project/controllers/cart_controller.dart';
import 'package:ecommerce_project/data/repository/popular_product_repo.dart';
import 'package:ecommerce_project/models/cart_model.dart';
import 'package:ecommerce_project/models/products_model.dart';
import 'package:ecommerce_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  // when we return data from repo we will save it here
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity; //get makes me use quantity directly 3ady

  int _ionCartItems = 0;
  int get ionCartItems =>
      _ionCartItems + _quantity; //resposible of keeping track of products

  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got products");
      //200 means unsucessful most servers do this
      _popularProductList = []; //intialize it to no
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      _isLoaded = true;
      update(); //it is like setstate
    } else {}
  }

  //decreasing or increasing items using +,-
  // Shop add
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      // print("numer of items " + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print("decrement " + _quantity.toString());
    }
    update();
  }

//quantity used as parameter is different from the one which we use in get method
//local scope has pirority than global one
  int checkQuantity(int quantity) {
    if ((_ionCartItems + quantity) < 0) {
      //we add inCartItems to be able to decrease
      //send message to user with instructions from controller
      Get.snackbar("Item count", "You can't reduce more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_ionCartItems > 0) {
        _quantity = -_ionCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_ionCartItems + quantity) > 20) {
      Get.snackbar("Item count", "You can't add more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20; //maximum number of orders from one person
    } else {
      return quantity;
    }
  }

  //every time we call new page we call this one, this only will clear data so I need to save it also
  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    //_ionCartItems = 0;
    //get from storage _incartitems
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _ionCartItems = _cart.getQuentity(product);
    }
    print("the quantity in the cart is" + _ionCartItems.toString());
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0; //it should be rest after and before adding
    _ionCartItems = _cart.getQuentity(product);

    _cart.items.forEach((key, value) {
      print("The id is  " +
          value.id.toString() +
          "The quantity is  " +
          value.quantity.toString());
    });

    update(); //to update UI, very important
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
