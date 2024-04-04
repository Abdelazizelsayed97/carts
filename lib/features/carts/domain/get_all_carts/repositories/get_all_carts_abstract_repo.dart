import 'package:dartz/dartz.dart';

import 'package:product_cart/core/helper/pagination.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_entity.dart';

import '../../../../../core/error_handler/error_handler.dart';

abstract class GetCartsRepository {
  Future<Either<ApiError, PaginatedData<Carts>>> fetchData(int limit);
}
