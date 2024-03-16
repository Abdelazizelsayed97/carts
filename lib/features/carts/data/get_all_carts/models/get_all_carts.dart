// To parse this JSON data, do
//
//     final cartsModel = cartsModelFromJson(jsonString);

import 'dart:convert';

ApiCartsModel cartsModelFromJson(String str) => ApiCartsModel.fromJson(json.decode(str));

String cartsModelToJson(ApiCartsModel data) => json.encode(data.toJson());

class ApiCartsModel {
  final List<ApiCart>? carts;
  final int? total;
  final int? skip;
  final int? limit;

  ApiCartsModel({
    this.carts,
    this.total,
    this.skip,
    this.limit,
  });

  factory ApiCartsModel.fromJson(Map<String, dynamic> json) => ApiCartsModel(
    carts: json["carts"] == null ? [] : List<ApiCart>.from(json["carts"]!.map((x) => ApiCart.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "carts": carts == null ? [] : List<dynamic>.from(carts!.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class ApiCart {
  final int? id;
  final List<ApiProduct>? products;
  final int? total;
  final int? discountedTotal;
  final int? userId;
  final int? totalProducts;
  final int? totalQuantity;

  ApiCart({
    this.id,
    this.products,
    this.total,
    this.discountedTotal,
    this.userId,
    this.totalProducts,
    this.totalQuantity,
  });

  factory ApiCart.fromJson(Map<String, dynamic> json) => ApiCart(
    id: json["id"],
    products: json["products"] == null ? [] : List<ApiProduct>.from(json["products"]!.map((x) => ApiProduct.fromJson(x))),
    total: json["total"],
    discountedTotal: json["discountedTotal"],
    userId: json["userId"],
    totalProducts: json["totalProducts"],
    totalQuantity: json["totalQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "total": total,
    "discountedTotal": discountedTotal,
    "userId": userId,
    "totalProducts": totalProducts,
    "totalQuantity": totalQuantity,
  };
}

class ApiProduct {
  final int? id;
  final String? title;
  final int? price;
  final int? quantity;
  final int? total;
  final double? discountPercentage;
  final int? discountedPrice;
  final String? thumbnail;

  ApiProduct({
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.total,
    this.discountPercentage,
    this.discountedPrice,
    this.thumbnail,
  });

  factory ApiProduct.fromJson(Map<String, dynamic> json) => ApiProduct(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    quantity: json["quantity"],
    total: json["total"],
    discountPercentage: json["discountPercentage"]?.toDouble(),
    discountedPrice: json["discountedPrice"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "quantity": quantity,
    "total": total,
    "discountPercentage": discountPercentage,
    "discountedPrice": discountedPrice,
    "thumbnail": thumbnail,
  };
}
