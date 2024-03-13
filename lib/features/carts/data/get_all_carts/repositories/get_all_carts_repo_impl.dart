import 'package:dartz/dartz.dart';
import 'package:product_cart/core/error_handler/error_handler.dart';
import 'package:product_cart/features/carts/data/get_all_carts/api_services/carts_web_Services.dart';
import 'package:product_cart/features/carts/data/get_all_carts/models/get_all_carts.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/repositories/get_all_carts_abstract_repo.dart';

import '../../../../../core/helper/pagination.dart';

class GetAllCartsRepositoriesImpl implements GetAllCartsRepository {
  GetAllCartsWebServices getAllCartsWebServices;

  GetAllCartsRepositoriesImpl(this.getAllCartsWebServices);

  @override
  Future<Either<ApiError, PaginatedData<Cart>>> getAllPosts(int pageKey) async {
    final data = await getAllCartsWebServices.getAllCarts();
    try {
      data.fold((l) {
        return ApiError(message: l.message);
      }, (r) {
        return r.map((e) => e.items).toList();
      });
    }catch(e){
      e.toString();
    }
    throw Exception();

  }
}
