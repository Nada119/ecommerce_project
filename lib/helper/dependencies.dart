import 'package:ecommerce_project/controllers/popular_product_controller.dart';
import 'package:ecommerce_project/controllers/recommended_product_controller.dart';
import 'package:ecommerce_project/data/api/api_client.dart';
import 'package:ecommerce_project/data/repository/popular_product_repo.dart';
import 'package:ecommerce_project/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';

Future<void> init() async {
  //async because of future

  //first dependency that we loaded

  //api client
  Get.lazyPut(() => ApiClient(
        appBaseUrl: AppConstants.BASE_URL, /*sharedPreferences: Get.find()*/
      ));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClent: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
}
