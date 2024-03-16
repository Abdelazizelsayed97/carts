import 'package:equatable/equatable.dart';

class GetAllCartsEntity extends Equatable {
  final List<Carts>? carts;
  final int? totalEnt;
  final int? skipEnt;
  final int? limitEnt;

  const GetAllCartsEntity({
    this.carts,
    this.totalEnt,
    this.skipEnt,
    this.limitEnt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [carts, totalEnt, skipEnt, limitEnt];
}

class Carts {
  final int cartId;
  final List<Products> items;

  Carts({required this.cartId, required this.items});
}

class Products {
  final int? iD;
  final int? price;
  final int? quantity;
  final int? total;
  final double? discountPercentage;
  final int? discountedPrice;
  final String? thumbnail;
  final String? title;

  Products({
    this.title,
    this.thumbnail,
    this.iD,
    this.price,
    this.quantity,
    this.total,
    this.discountPercentage,
    this.discountedPrice,
  });
}
