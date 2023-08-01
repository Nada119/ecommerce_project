import 'package:ecommerce_project/data/api/api_client.dart';
import 'package:ecommerce_project/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  // String api = "https://mvs.bslmeiyu.com/api/v1/products/popular";
  final ApiClient apiClent;
  RecommendedProductRepo({required this.apiClent});

  Future<Response> getRecommendedProductList() async {
    return await apiClent.getData(AppConstants.RECOMMENDED_PRODUCT_URL);
  }
}
