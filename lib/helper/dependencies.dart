import 'package:ecommerce_project/controllers/cart_controller.dart';
import 'package:ecommerce_project/controllers/popular_product_controller.dart';
import 'package:ecommerce_project/controllers/recommended_product_controller.dart';
import 'package:ecommerce_project/data/api/api_client.dart';
import 'package:ecommerce_project/data/repository/cart_repo.dart';
import 'package:ecommerce_project/data/repository/popular_product_repo.dart';
import 'package:ecommerce_project/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

Future<void> init() async {
  //async because of future

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //first dependency that we loaded

  //api client
  Get.lazyPut(() => ApiClient(
        appBaseUrl: AppConstants.BASE_URL, /*sharedPreferences: Get.find()*/
      ));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClent: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));

  Get.lazyPut(() => CartController(
      cartRepo: Get.find())); //or permanent:true but it doesn't work now
}
