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
