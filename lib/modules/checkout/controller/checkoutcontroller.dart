import 'package:ex_ui_shoping/config/api/endpint.dart';
import 'package:ex_ui_shoping/config/api/setupapi.dart';
import 'package:ex_ui_shoping/service/networkservice.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final productItemscart = Get.arguments["productItemscart"];
  final totalCart = Get.arguments["totalCart"];
  final RxString qrCode = "".obs;
  final RxBool checkoutLoading = false.obs;
  final Networkservice networkservice = Networkservice();

  @override
  void onInit() {
    ever(networkservice.loading, (loading) {
      checkoutLoading.value = loading;
    });
    //createQrCode();
    testapi();
    super.onInit();
  }

  Future<void> testapi() async {
    final response = await networkservice.post("https://jsonplaceholder.typicode.com/posts", {
      "title": "foo",
      "body": "bar",
      "userId": 1,
    });
  }

  /// Send cart items to checkout endpoint
  /// 
  /// Set the qr code to the checkout endpoint with the total price
  /// 
  /// The checkout endpoint is: https://payment.spw.challenge/checkout?price=$%7Bprice%7D
  Future<void> sendToCheckout() async {
    final url = API.url(Endpoint.checkout);
    qrCode.value = "$url&price=$totalCart";
    //https://payment.spw.challenge/checkout?price=$%7Bprice%7D

    // final payload = {"items": productItemscart, "total": totalCart};
    // final response = await networkservice.post("$url&price=$totalCart", payload);
    // return response;
  }

  Future<void> genarateQRCode() async {}
}
