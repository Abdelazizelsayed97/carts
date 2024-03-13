import 'package:equatable/equatable.dart';

class GetAllCartsEntity extends Equatable {
  final List<Carts>? carts;
  final int? total;
  final int? skip;
  final int? limit;

  const GetAllCartsEntity({
    this.carts,
    this.total,
    this.skip,
    this.limit,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [carts,total,skip,limit];
}

class Carts {
  final int cartId;

  final List<Products> items;

  Carts({required this.cartId, required this.items});
}

class Products {
  final String? title;
  final String? thumbnail;

  Products({this.title, this.thumbnail});
}
