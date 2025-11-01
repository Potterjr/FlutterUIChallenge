import 'package:auto_size_text/auto_size_text.dart';
import 'package:ex_ui_shoping/modules/productdetail/controller/productdetailcontroller.dart';
import 'package:ex_ui_shoping/service/deviceutility.dart';
import 'package:ex_ui_shoping/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Productdetail extends GetView<Productdetail> {
  const Productdetail({super.key});

  @override
/// Builds a product detail screen with a product image, product name, product price, add to cart button, and favorite button.
///
/// The screen is wrapped in a [Hero] widget with a tag that is used to identify the product that is being viewed.
///
/// The screen is also wrapped in a [Theme] widget with a divider theme that is used to remove the divider between the app bar and the body of the screen.
///
/// The product image is displayed in a [ClipRRect] widget with a circular border radius of 10.
///
/// The product name is displayed in an [AutoSizeText] widget with a minimum font size of 26 and a maximum font size of 30.
///
/// The product price is displayed in an [AutoSizeText] widget with a minimum font size of 16 and a maximum font size of 20.
///
/// The add to cart button is displayed in a [Button] widget with a red color outline and a bold font weight.
///
/// The favorite button is displayed in an [IconButton] widget with a red color if the product is favorited and a grey color if the product is not favorited.
  Widget build(BuildContext context) {
    final controller = Get.put(Productdetailcontroller());

    final isTablet = DeviceUtils.deviceType(context) == 'Tablet';
    final imageWidth = isTablet
        ? MediaQuery.of(context).size.width * 0.9
        : MediaQuery.of(context).size.width * 0.85;
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(dividerTheme: const DividerThemeData(color: Colors.transparent)),
      child: Scaffold(
        appBar: AppBar(),
        body: Hero(
          tag: controller.tag!,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          controller.img!,
                          height: imageWidth,
                          width: imageWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: AutoSizeText(
                              controller.porductName!,
                              maxLines: 1,
                              minFontSize: 26,
                              maxFontSize: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () => {},
                            icon: Icon(
                              Icons.favorite,
                              size: DeviceUtils.deviceType(context) == "Tablet" ? 60 : 40,
                              color: controller.favorite == true ? Colors.red : Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: AutoSizeText(
                          '\$${controller.price ?? ''}',
                          maxLines: 1,
                          minFontSize: 16,
                          maxFontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Button(
              label: "Add to Cart",
              coloroutline: Colors.red,
              textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
              onPressed: () => {
                Get.back(
                  result: {
                    "tag": controller.tag,
                    "id": controller.id,
                    "porductName": controller.porductName,
                    "price": controller.price,
                    "favorite": controller.favorite,
                    "image_url": controller.img,
                    "quantity": 1,
                  },
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
