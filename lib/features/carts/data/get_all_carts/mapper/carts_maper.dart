import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

import '../models/get_all_carts.dart';

extension ConvertApiGetAllCartsToGatAllCarts on ApiGetAllCarts {
  GetAllCartsEntity mapAllCarts() {
    return GetAllCartsEntity(
        limit: limit,
        carts: carts?.map((e) => e.mapCart()).toList(),
        skip: skip,
        total: total);
  }
}

extension ConvertPostsEntityToApiPostsDataEntity on Cart {
  Carts mapCart() {
    return Carts(
        cartId: id ?? 0, items: products!.map((e) => e.proMap()).toList());
  }
}

extension ConvertApiProductsToProducts on Product {
  Products proMap() {
    return Products(title: title, thumbnail: thumbnail);
  }
}
