// class GetAllCartsModel{
//   final int id ;
//   final Products products;
//
//   GetAllCartsModel(this.id, this.products);
// }
//
// class Products {
// final String title;
// final String thumbnail;
//
//   Products(this.title, this.thumbnail);
//
// }

class ApiGetAllCarts {
  final List<Cart>? carts;
  final int? total;
  final int? skip;
  final int? limit;

  ApiGetAllCarts({
    this.carts,
    this.total,
    this.skip,
    this.limit,
  });

  factory ApiGetAllCarts.fromJson(Map<String, dynamic> json) {
    List<dynamic>? cartsJson = json['carts'];
    List<Cart>? carts = cartsJson?.map((cartJson) => Cart.fromJson(cartJson)).toList();

    return ApiGetAllCarts(
      carts: carts,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? cartsJson = carts?.map((cart) => cart.toJson()).toList();
    return {
      'carts': cartsJson,
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}

class Cart {
  final int? id;
  final List<Product>? products;

  Cart({
    this.id,
    this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<dynamic>? productsJson = json['products'];
    List<Product>? products = productsJson?.map((productJson) => Product.fromJson(productJson)).toList();

    return Cart(
      id: json['id'],
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? productsJson = products?.map((product) => product.toJson()).toList();
    return {
      'id': id,
      'products': productsJson,
    };
  }
}

class Product {
  final int? id;
  final String? title;
  final int? price;
  final int? quantity;
  final int? total;
  final double? discountPercentage;
  final int? discountedPrice;
  final String? thumbnail;

  Product({
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.total,
    this.discountPercentage,
    this.discountedPrice,
    this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      quantity: json['quantity'],
      total: json['total'],
      discountPercentage: json['discountPercentage'],
      discountedPrice: json['discountedPrice'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity': quantity,
      'total': total,
      'discountPercentage': discountPercentage,
      'discountedPrice': discountedPrice,
      'thumbnail': thumbnail,
    };
  }
}

