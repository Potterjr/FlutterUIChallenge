import 'package:ex_ui_shoping/modules/home/controller/homecontroller.dart';
import 'package:ex_ui_shoping/widget/button/button.dart';
import 'package:ex_ui_shoping/widget/card/card_cartproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Cartscreen extends GetView<HomeController> {
  Cartscreen({super.key});

  @override
  final controller = Get.put(HomeController());

  @override
/// Builds the cart screen with a list of products and a total price at the bottom.
/// The list of products is a Obx widget, which is a widget that rebuilds when the value of the observable it is listening to changes.
/// The products are displayed as a list of cards, with the option to delete a product from the cart.
/// If the cart is empty, it will display a skeleton list instead.
/// The total price is displayed at the bottom of the screen, and is also an Obx widget.
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Padding(padding: const EdgeInsets.only(left: 8.0, right: 8.0), child: layoutCart()),
        bottomNavigationBar: Padding(padding: const EdgeInsets.all(32.0), child: totalPrice()),
      );
    });
  }


  Widget layoutCart() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        controller.product.value.productItems?.isEmpty ?? true
            ? loaddingListSkeleton()
            : listProductCart(),
      ],
    );
  }

  
  Widget listProductCart() {
    var cartProducts = controller.cart.value.productItemscart ?? [];

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          controller.product.value.productItems!.clear();
          controller.product.refresh();
          await controller.getProduct();
        },
        child: ListView.builder(
          itemCount: cartProducts.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var product = cartProducts[index];
            return Skeletonizer(
              ignoreContainers: true,
              enabled: cartProducts.isEmpty,
              child: Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      label: 'Delete',
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      onPressed: (context) {
                        controller.removeCart(product.id!);
                      },
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    CardCartProduct(
                      imagenetwork: product.imageUrl ?? "",
                      porductName: product.name,
                      quantity: product.quantity,
                      price: product.price,
                      favorite: product.favorite ?? false,
                      onNagativeQuantity: () {
                        controller.updateQuantityCart(false, product.id ?? 0);
                      },
                      onPlusQuantity: () {
                        controller.updateQuantityCart(true, product.id ?? 0);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget totalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              child: AutoSizeText(
                "Total : \$",
                minFontSize: 20,
                maxFontSize: 30,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 100,
              child: AutoSizeText(
                controller.totalCart.value.toStringAsFixed(2),

                minFontSize: 20,
                maxFontSize: 30,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 150,
          child: Button(
            onPressed: () async {
              final result = await Get.toNamed(
                "/checkout",
                arguments: {
                  "productItemscart": controller.cart.value.productItemscart,
                  "totalCart": controller.totalCart.value,
                },
              );
              if (result != null) {}
            },
            label: "Checkout",
            coloroutline: Colors.black,
            textStyle: const TextStyle(color: Colors.black, fontSize: 40),
          ),
        ),
      ],
    );
  }

  Widget loaddingListSkeleton() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Skeletonizer(
          ignoreContainers: true,
          enabled: true,
          child: CardCartProduct(
            imagenetwork: "",
            quantity: 0,
            price: 0,
            favorite: false,
            onNagativeQuantity: () {},
            onPlusQuantity: () {},
            porductName: "mocktext Skeleton",
          ),
        ),
      ),
    );
  }
}
