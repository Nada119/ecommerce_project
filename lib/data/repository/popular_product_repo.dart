import 'package:ecommerce_project/data/api/api_client.dart';
import 'package:ecommerce_project/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  // we need to extend getxservice when we get data from internet
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPUPAR_PRODUCT_URL);
  }
}
