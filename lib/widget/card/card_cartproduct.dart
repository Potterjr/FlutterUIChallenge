import 'package:ex_ui_shoping/service/deviceutility.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CardCartProduct extends StatelessWidget {
  final String? porductName;
  final String? imagenetwork;
  final double? price;
  final int? quantity;
  final bool? favorite;
  final VoidCallback? onPlusQuantity;
  final VoidCallback? onNagativeQuantity;

  const CardCartProduct({
    super.key,
    this.porductName,
    this.imagenetwork,
    this.price,
    this.quantity,
    this.favorite,
    this.onPlusQuantity,
    this.onNagativeQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceUtils.deviceType(context) == 'Tablet';
    final imageWidth = isTablet ? 150.0 : 100.0;
    final nameMinSize = isTablet ? 18.0 : 12.0;
    final nameMaxSize = isTablet ? 22.0 : 16.0;
    final priceMinSize = isTablet ? 16.0 : 10.0;
    final priceMaxSize = isTablet ? 20.0 : 14.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width * 0.42;
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : MediaQuery.of(context).size.height * (isTablet ? 0.12 : 0.16);

        return SizedBox(
          width: width,
          height: height,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imagenetwork != "" && imagenetwork != null && imagenetwork!.isNotEmpty
                      ? Image.network(
                          imagenetwork!, width: imageWidth, fit: BoxFit.cover)
                      : Container(
                        width: imageWidth,
                        height: imageWidth,
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width - imageWidth - 20,
                          child: AutoSizeText(
                            porductName ?? '',
                            maxLines: 1,
                            minFontSize: nameMinSize,
                            maxFontSize: nameMaxSize,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600, height: 1.1),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: width - imageWidth - 20,
                          child: AutoSizeText(
                            '\$${price?.toString() ?? ''}',
                            maxLines: 1,
                            minFontSize: priceMinSize,
                            maxFontSize: priceMaxSize,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                              height: 1.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.remove, size: 20),
                                onPressed: () => {
                                  onNagativeQuantity?.call()
                                },
                              ),
                            ),
            
                            Container(
                              alignment: Alignment.center,
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(color: Colors.grey.shade300),
                                  bottom: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              child:  Text(
                                quantity?.toString() ?? '',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
            
                            Container(
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add, size: 20),
                                onPressed: () => {
                                  onPlusQuantity?.call()
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
