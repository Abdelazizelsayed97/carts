import 'package:dartz/dartz.dart';
import 'package:product_cart/core/error_handler/error_handler.dart';
import 'package:product_cart/core/helper/pagination.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_entity.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/repositories/get_all_carts_abstract_repo.dart';

class GetCartsUseCase {
  final GetCartsRepository repository;

  GetCartsUseCase(this.repository);

  Future<Either<ApiError, PaginatedData<Carts>>> fetchData(
      {required int limit, required int skip}) async {
    return await repository.fetchData(limit);
  }
}
