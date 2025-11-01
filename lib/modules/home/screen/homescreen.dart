import 'package:ex_ui_shoping/config/routes/routes.dart';
import 'package:ex_ui_shoping/modules/home/screen/cartscreen.dart';
import 'package:ex_ui_shoping/modules/home/screen/favoritescreen.dart';
import 'package:ex_ui_shoping/widget/card/card_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controller/homecontroller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  @override
  final controller = Get.put(HomeController());

  @override
  /// Builds the widget tree for the home screen.
  ///
  /// This widget is responsible for building the home screen which
  /// includes a bottom navigation bar with three items: Home, Saved,
  /// and Cart. It also includes a page view with three pages: Home
  /// screen, Favorites screen, and Cart screen. The home screen
  /// is the first page of the page view. The bottom navigation bar is
  /// used to navigate between the three pages of the page view.
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: controller.navigatepage.value == 0
              ? Text("Home")
              : controller.navigatepage.value == 1
              ? Text("Saved")
              : Text("Cart"),
        ),
        body: PageView(
          onPageChanged: (index) {
            controller.navigatepage(index);
          },
          controller: controller.pageController,
          children: [layouthome(), Favoritescreen(), Cartscreen()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => {
            controller.navigatepage(index),
            controller.pageController.jumpToPage(index),
          },
          currentIndex: controller.navigatepage.value,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.house), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Saved'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          ],
          selectedItemColor: Colors.red[800],
        ),
      );
    });
  }

  Widget layouthome() {
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
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async => {
          controller.product.value.productItems!.clear(),
          controller.product.refresh(),
          await controller.getProduct(),
        },
        child: GridView.count(
          crossAxisCount: 2,
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            controller.product.value.productItems?.length ?? 0,
            (index) => Skeletonizer(
              ignoreContainers: true,
              enabled: controller.product.value.productItems?.isEmpty ?? false,
              child: CardProduct(
                imagenetwork: controller.product.value.productItems?[index].imageUrl ?? "",
                porductName: controller.product.value.productItems?[index].name,
                price: controller.product.value.productItems?[index].price.toString(),
                favorite: controller.product.value.productItems?[index].favorite,
                onupdatefavorite: (value) => {
                  controller.saveFavorite(controller.product.value.productItems![index]),
                },
                onPressed: () async {
                  final res = await Get.toNamed(
                    RoutesHandler.productdetail,
                    arguments: {
                      "tag": controller.product.value.productItems![index].name,
                      "id": controller.product.value.productItems![index].id,
                      "img": controller.product.value.productItems![index].imageUrl,
                      "porductName": controller.product.value.productItems![index].name,
                      "favorite": controller.product.value.productItems![index].favorite,
                      "price": controller.product.value.productItems![index].price,
                    },
                  );

                  if (res == null) {
                    return;
                  }

                  controller.savetoCart(res);
                },
              ),
            ),
          ),
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
