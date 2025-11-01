import 'package:auto_size_text/auto_size_text.dart';
import 'package:ex_ui_shoping/modules/checkout/controller/checkoutcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Checkoutscreen extends GetView<CheckoutController> {
  Checkoutscreen({super.key});
  @override
  final controller = Get.put(CheckoutController());
  @override
/// Builds a Scaffold with an AppBar and a Row containing a Column of widgets.
///
/// The Column contains a QrImageView, a SizedBox, an AutoSizeText with the text "Scan And Pay",
/// another SizedBox, and an AutoSizeText with the total price of the items in the cart.
///
/// The QrImageView displays the QR code provided by the controller.
/// The AutoSizeText widgets automatically adjust their font size based on the available space.
/// The total price of the items in the cart is retrieved from the controller.
  Widget build(context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(title: Text("Checkout")),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QrImageView(
                  data: controller.qrCode.value,
                  version: QrVersions.auto,
                  size: MediaQuery.of(context).size.width * 0.8,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: const AutoSizeText(
                    "Scan And Pay",
                    minFontSize: 60,
                    maxFontSize: 80,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: AutoSizeText(
                    "\$${controller.totalCart}",
                    minFontSize: 40,
                    maxFontSize: 50,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
