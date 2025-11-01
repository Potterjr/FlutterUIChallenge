import 'package:ex_ui_shoping/modules/checkout/screen/checkoutscreen.dart';
import 'package:ex_ui_shoping/modules/productdetail/screen/productdetail.dart';
import 'package:ex_ui_shoping/modules/home/screen/homescreen.dart';
import 'package:get/get.dart';

abstract class RoutesHandler {
  static const home = '/home';
  static const productdetail = '/productdetail';
  static const checkout = '/checkout';
}

const trandulation = Duration(milliseconds: 500);
const transitionpage = Transition.cupertino;
final routes = [
  GetPage(
    name: RoutesHandler.home,
    page: () => HomeScreen(),
    transition: transitionpage,
    transitionDuration: trandulation,
  ),
  GetPage(
    name: RoutesHandler.productdetail,
    page: () => Productdetail(),
    transition: transitionpage,
    transitionDuration: trandulation,
  ),
  GetPage(
    name: RoutesHandler.checkout,
    page: () => Checkoutscreen(),
    transition: transitionpage,
    transitionDuration: trandulation,
    
  ),
];
