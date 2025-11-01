import 'package:ex_ui_shoping/config/routes/routes.dart';
import 'package:ex_ui_shoping/modules/home/controller/homecontroller.dart';
import 'package:ex_ui_shoping/widget/card/card_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Favoritescreen extends GetView<HomeController> {
  Favoritescreen({super.key});

  @override
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return layoutFavorite();
  }

  Widget layoutFavorite() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        controller.product.value.productItems?.isEmpty ?? true
            ? loaddingListSkeleton()
            : listProduct(),
      ],
    );
  }

  Widget listProduct() {
    var favoriteProducts =
        controller.product.value.productItems
            ?.where((element) => element.favorite == true)
            .toList() ??
        [];
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          controller.product.value.productItems!.clear();
          controller.product.refresh();
          await controller.getProduct();
        },
        child: GridView.builder(
          itemCount: favoriteProducts.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            var product = favoriteProducts[index];
            return Skeletonizer(
              ignoreContainers: true,
              enabled: favoriteProducts.isEmpty,
              child: CardProduct(
                imagenetwork: product.imageUrl ?? "",
                porductName: product.name,
                price: product.price.toString(),
                favorite: product.favorite ?? false,
                onupdatefavorite: (value) {
                  controller.saveFavorite(product);
                },
                onPressed: () async{
                 final res = await Get.toNamed(
                    RoutesHandler.productdetail,
                    arguments: {

                      "tag": product.name,
                      "id": product.id,
                      "porductName": product.name,
                      "price": product.price,
                      "favorite": product.favorite,
                      "img": product.imageUrl
            
                    },
                  );

                  if (res == null) {
                    return;
                  }

                  controller.savetoCart(res);

                },

              ),
            );
          },
        ),
      ),
    );
  }

  Widget loaddingListSkeleton() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          10,
          (index) => Skeletonizer(
            ignoreContainers: true,
            enabled: true,
            child: CardProduct(porductName: "mocktext Skeleton", onPressed: () {}),
          ),
        ),
      ),
    );
  }
}
