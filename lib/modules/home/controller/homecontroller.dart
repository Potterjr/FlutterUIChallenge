import 'dart:convert';

import 'package:ex_ui_shoping/modules/home/model/cartmodel.dart';
import 'package:ex_ui_shoping/modules/home/model/productmodel.dart';
import 'package:ex_ui_shoping/service/localstorage.dart';
import 'package:ex_ui_shoping/service/networkservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Networkservice networkservice = Networkservice();
  Rx<Porductresponsemodel> product = Rx<Porductresponsemodel>(Porductresponsemodel());
  Rx<Cartsmodel> cart = Rx<Cartsmodel>(Cartsmodel());
  RxDouble totalCart = 0.0.obs;
  LocalStorageService localStorage = LocalStorageService();

  RxInt navigatepage = 0.obs;
  PageController pageController = PageController();

  @override
  void onInit() {


    getProduct();
    getProductCart();

    super.onInit();
  }

  /// Get product from mock endpoint url.
  /// If the response is null, it will return immediately.
  /// After getting the product, it will call [getFavorite] to refresh favorite pref.
  Future<void> getProduct() async {
    var response = await networkservice.getmock("mock endpoint url");
    if (response == null) {
      return;
    }
    final data = json.decode(response);
    product.value = Porductresponsemodel.fromJson(data);
    getFavorite();
  }

  /// Save product to favorite pref.
  /// If product is already in favorite pref, it will remove product from favorite pref.
  /// If product is not in favorite pref, it will add product to favorite pref.
  /// After saving to favorite, it will call [getFavorite] to refresh favorite pref.
  Future<void> saveFavorite(ProductItems productItems) async {
    final localStorage = LocalStorageService();
    final favoritelist = await localStorage.getFavoritePref();

    final duplicateProduct = favoritelist?.firstWhere(
      (element) => element["id"] == productItems.id,
      orElse: () => {},
    );

    if (duplicateProduct != null && duplicateProduct.isNotEmpty) {
      localStorage.removeFavoritePref(duplicateProduct["id"] ?? "");
    } else {
      localStorage.saveFavoritePref([...favoritelist ?? [], productItems.toJson()]);
    }

    getFavorite();
  }

/// Get favorite pref from local storage and update product items with the response.
/// If the response is null, it will return immediately.
/// After updating product items, it will call [refresh] to update the product.
  Future<void> getFavorite() async {
    final favoritelist = await localStorage.getFavoritePref();
    product.value.productItems?.forEach((element) {
      element.favorite = favoritelist?.any((fav) => fav["id"] == element.id) ?? false;
    });
    product.refresh();
  }

/// Get cart pref from local storage and update cart with the response.
/// If the response is null, it will return immediately.
/// After updating cart, it will call [getTotal] to update total price of the cart.
  Future<void> getProductCart() async {
    var response = await localStorage.getCartPref();
    if (response == null) {
      return;
    }
    cart.value = Cartsmodel.fromJson({"product_items_cart": response});
    getTotal();
  }

/// Save response to cart pref and increment quantity of the product.
/// If product is already in cart, it will increment quantity by 1.
/// If product is not in cart, it will add product to cart with quantity 1.
/// After saving to cart, it will call [getProductCart] to refresh the cart.
/// Then it will navigate to page with index 2.
  Future<void> savetoCart(response) async {
    final cartList = await localStorage.getCartPref();

    final duplicateProduct = cartList?.firstWhere(
      (element) => element["id"] == response["id"],
      orElse: () => {},
    );

    if (duplicateProduct != null && duplicateProduct.isNotEmpty) {
      localStorage.saveCartPref(
        cartList?.map((e) {
              if (e["id"] == duplicateProduct["id"]) {
                e["quantity"] = e["quantity"] + 1;
              }
              return e;
            }).toList() ??
            [],
      );
    } else {
      localStorage.saveCartPref([...cartList ?? [], response]);
    }
    getProductCart();
    navigatepage.value = 2;
    pageController.jumpToPage(2);
  }

  Future<void> removeCart(int id) async {
    localStorage.removeCartPref(id);
    getProductCart();
  }


 
  /// Update quantity of product in cart.
  ///
  /// If [isIncrement] is true, it will increment quantity of the product.
  /// If [isIncrement] is false, it will decrement quantity of the product.
  ///
  /// [id] is the id of the product.
  ///
  /// After updating quantity, it will call [getProductCart] to refresh the cart.
  Future<void> updateQuantityCart(bool isIncrement, int id) async {
    final cartList = await localStorage.getCartPref();

    final element = cartList?.firstWhere((element) => element["id"] == id, orElse: () => {});

    if (isIncrement) {
      element!["quantity"] = element["quantity"] + 1;
    } else {
      if (element!["quantity"] == 1) {
        removeCart(id);
        return;
      }
      element["quantity"] = element["quantity"] - 1;
    }

    localStorage.updateQuantityCart(id, element["quantity"] ?? 0);
    getProductCart();
  }

  Future<void> getTotal() async {
    final cartList = await localStorage.getCartPref();
    double total = 0;
    cartList?.forEach((element) {
      total += element["price"] * element["quantity"];
    });
    totalCart.value = total;
  }
}
