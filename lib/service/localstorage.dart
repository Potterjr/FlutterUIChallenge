import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageKey {
  static const String favoritePref = 'favorite';
  static const String cartPref = 'cart';
}

class LocalStorageService {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Future<void> saveFavoritePref(List<dynamic> favorite) async {
    final prefs = await LocalStorageService.prefs;
    String favoriteJson = json.encode(favorite);
    await prefs.setString(LocalStorageKey.favoritePref, favoriteJson);
  }

  Future<List<Map<String, dynamic>>?> getFavoritePref() async {
    final prefs = await LocalStorageService.prefs;
    String? favoriteJson = prefs.getString(LocalStorageKey.favoritePref);
    if (favoriteJson != null) {
      List<dynamic> favoriteList = json.decode(favoriteJson);
      return List<Map<String, dynamic>>.from(favoriteList);
    }
    return null;
  }

  Future<void> removeFavoritePref(int id) async {
    final prefs = await LocalStorageService.prefs;
    String? favoriteJson = prefs.getString(LocalStorageKey.favoritePref);

    if (favoriteJson != null) {
      List<dynamic> favoriteList = json.decode(favoriteJson);
      favoriteList.removeWhere((element) => element["id"] == id);
      String updatedFavoriteJson = json.encode(favoriteList);
      await prefs.setString(LocalStorageKey.favoritePref, updatedFavoriteJson);
    }
  }

  Future<void> clearFavoritePref() async {
    final prefs = await LocalStorageService.prefs;
    await prefs.remove(LocalStorageKey.favoritePref);
  }

  Future<void> saveCartPref(List<dynamic> cart) async {
    final prefs = await LocalStorageService.prefs;
    String cartJson = json.encode(cart);
    await prefs.setString(LocalStorageKey.cartPref, cartJson);
  }

  Future<List<Map<String, dynamic>>?> getCartPref() async {
    final prefs = await LocalStorageService.prefs;
    String? cartJson = prefs.getString(LocalStorageKey.cartPref);
    if (cartJson != null) {
      List<dynamic> favoriteList = json.decode(cartJson);
      return List<Map<String, dynamic>>.from(favoriteList);
    }
    return null;
  }

  Future<void> removeCartPref(int id) async {
    final prefs = await LocalStorageService.prefs;
    String? cartJson = prefs.getString(LocalStorageKey.cartPref);

    if (cartJson != null) {
      List<dynamic> cartList = json.decode(cartJson);
      cartList.removeWhere((element) => element["id"] == id);
      String updatedcartJsonJson = json.encode(cartList);
      await prefs.setString(LocalStorageKey.cartPref, updatedcartJsonJson);
    }
  }

  Future<void> updateQuantityCart(int id, int quantity) async {
    final prefs = await LocalStorageService.prefs;
    String? cartJson = prefs.getString(LocalStorageKey.cartPref);

  

    if (cartJson != null) {
      List<dynamic> cartList = json.decode(cartJson);
      cartList.map((element) {
        if (element["id"] == id) {
          element["quantity"] = quantity;
        }
        return element;
      }).toList();
      String updatedcartJsonJson = json.encode(cartList);
      await prefs.setString(LocalStorageKey.cartPref, updatedcartJsonJson);
    }
  }

  Future<void> clearCartPref() async {
    final prefs = await LocalStorageService.prefs;
    await prefs.remove(LocalStorageKey.cartPref);
  }
}
