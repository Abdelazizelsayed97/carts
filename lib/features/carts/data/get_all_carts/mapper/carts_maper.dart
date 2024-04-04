import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_entity.dart';

import '../models/get_all_carts.dart';

extension ConvertApiGetAllCartsToGatAllCarts on ApiCartsModel {
  GetAllCartsEntity mapAllCarts() {
    return GetAllCartsEntity(
      carts: carts?.map((e) => e.mapCart()).toList(),
      limitEnt: limit,
      skipEnt: skip,
      totalEnt: total,
    );
  }
}

extension ConvertPostsEntityToApiPostsDataEntity on ApiCart {
  Carts mapCart() {
    return Carts(
        cartId: id ?? 0, items: products!.map((e) => e.proMap()).toList());
  }
}

extension ConvertApiProductsToProducts on ApiProduct {
  Products proMap() {
    return Products(
      title: title,
      thumbnail: thumbnail,
      total: total,
      discountedPrice: discountedPrice,
      discountPercentage: discountPercentage,
      iD: id,
      price: price,
      quantity: quantity,
    );
  }
}
