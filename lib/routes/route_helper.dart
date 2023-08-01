import 'package:ecommerce_project/pages/food/popular_food_detail.dart';
import 'package:ecommerce_project/pages/food/recomended_food_detail.dart';
import 'package:ecommerce_project/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  //static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendeFood = "/recommended-food";
  //static const String cartPage = "/cart-page";
  //static const String sigIn = "/sign-in";
  //static const String addAddress = "/add-address";

  //we do this to have the ability to pass parameters
  //static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(
    int pageId,
    /*String page*/
  ) =>
      '$popularFood?pageId=$pageId'; //pass parameters
  static String getRecommendedFood() => '$recommendeFood';
  //static String getCartPage() => '$cartPage';
  //static String getsigInPage() => '$sigIn';
  //static String getAddresssPage() => '$addAddress';

  //it takes list of pages
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()), //use strings
    //GetPage(name: popularFood, page: () => PopularFoodDetail()),
    //GetPage(name: splashPage, page: () => SplashScreen()),
    //GetPage(name: initial, page: () => HomePage(), transition: Transition.fade),
    //GetPage(name: sigIn, page: () => SignInPage(), transition: Transition.fade),

    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId']; //variable we want to catch
        var page = Get.parameters['page'];
        return PopularFoodDetail(
          pageId: int.parse(pageId!), /*page: page!*/
        );
      },
      transition: Transition.fadeIn, //make animations
    ),

    GetPage(
      name: recommendeFood,
      page: () {
        return RecommendedFoodDetail();
      },
      transition: Transition.fadeIn,
    ),
    /*
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        })*/
  ];
}
