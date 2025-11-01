import 'package:ex_ui_shoping/service/deviceutility.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CardProduct extends StatelessWidget {
  final String? porductName;
  final String? imagenetwork;
  final String? price;
  final bool? favorite;
  final VoidCallback? onPressed;
  final Function(bool)? onupdatefavorite;
  const CardProduct({
    this.porductName,
    this.imagenetwork,
    this.price,
    this.favorite,
    this.onupdatefavorite,
    this.onPressed,
    super.key,
  });

  @override
/// Builds a product card widget with an image, product name, price, and a favorite button.
///
/// The product card is sized based on the device type and screen size.
///
/// The product image is displayed in a [Hero] widget with a tag that is used to identify the product that is being viewed.
///
/// The product name and price are displayed in [AutoSizeText] widgets, with the font size and style adjusted based on the device type and screen size.
///
/// The favorite button is displayed in an [IconButton] widget, with the color changed based on whether the product is favorited or not.
  Widget build(BuildContext context) {
    final cardheight = DeviceUtils.deviceType(context) == "Tablet"
        ? MediaQuery.of(context).size.height * 0.38
        : MediaQuery.of(context).size.height * 0.18;
    final cardwidth = MediaQuery.of(context).size.width * 0.4;
    return SizedBox(
      height: cardheight,
      width: cardwidth,
      child: Card(
        elevation: 5,
        child: Stack(
          children: [
            GestureDetector(
              onTap: onPressed,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: porductName ?? "",
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width,
                        child:
                            imagenetwork != "" && imagenetwork != null && imagenetwork!.isNotEmpty
                            ? Image.network(
                                imagenetwork!,
                                fit: BoxFit.cover,
                                height: cardheight * 0.7,
                              )
                            : Container(
                                height: MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.4,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            textAlign: TextAlign.center,
                            porductName ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            minFontSize: DeviceUtils.deviceType(context) == "Tablet" ? 20 : 10,
                            maxFontSize: DeviceUtils.deviceType(context) == "Tablet" ? 24 : 14,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            '\$${price ?? ''}',
                            textAlign: TextAlign.center,
                            minFontSize: DeviceUtils.deviceType(context) == "Tablet" ? 16 : 8,
                            maxFontSize: DeviceUtils.deviceType(context) == "Tablet" ? 20 : 12,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                onPressed: () => {onupdatefavorite!(!favorite!)},
                icon: Icon(
                  Icons.favorite,
                  size: DeviceUtils.deviceType(context) == "Tablet" ? 50 : 30,
                  color: favorite == true ? Colors.red : Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
