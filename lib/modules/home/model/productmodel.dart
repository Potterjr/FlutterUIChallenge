class Porductresponsemodel {
  List<ProductItems>? productItems;

  Porductresponsemodel({this.productItems});

  Porductresponsemodel.fromJson(Map<String, dynamic> json) {
    if (json['product_items'] != null) {
      productItems = <ProductItems>[];
      json['product_items'].forEach((v) {
        productItems!.add(ProductItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productItems != null) {
      data['product_items'] = productItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductItems {
  int? id;
  String? name;
  String? imageUrl;
  double? price;
  bool? favorite = false;
  bool? isAddedToCart = true;

  ProductItems({this.id, this.name, this.imageUrl, this.price, this.favorite});

  ProductItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    price = (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['price'] = price;
    return data;
  }
}
