class Cartsmodel {
  List<ProductItemsCart>? productItemscart;

  Cartsmodel({this.productItemscart});

  Cartsmodel.fromJson(Map<String, dynamic> json) {
    if (json['product_items_cart'] != null) {
      productItemscart = <ProductItemsCart>[];
      json['product_items_cart'].forEach((v) {
        productItemscart!.add(ProductItemsCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productItemscart != null) {
      data['product_items_cart'] = productItemscart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductItemsCart {
  int? id;
  String? name;
  String? imageUrl;
  double? price;
  bool? favorite = false;
  int? quantity;

  ProductItemsCart({this.id, this.name, this.imageUrl, this.price, this.favorite});

  ProductItemsCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    quantity = json['quantity'];
    price = (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
