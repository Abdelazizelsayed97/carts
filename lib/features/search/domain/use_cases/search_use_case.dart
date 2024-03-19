import 'package:dartz/dartz.dart';
import 'package:product_cart/core/error_handler/error_handler.dart';
import 'package:product_cart/core/helper/pagination.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/repositories/get_all_carts_abstract_repo.dart';

class SearchUseCase {
   final GetAllCartsRepository repository;

  SearchUseCase(this.repository);
  Future<Either<ApiError,PaginatedData<Carts>>> execute()async{
    return await repository.fetchData(1);
  }

}