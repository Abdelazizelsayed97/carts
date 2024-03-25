import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:product_cart/core/constants/constants.dart';
import 'package:product_cart/core/error_handler/error_handler.dart';
import 'package:product_cart/features/carts/data/get_all_carts/mapper/carts_maper.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/repositories/get_all_carts_abstract_repo.dart';

import '../../../../../core/helper/pagination.dart';
import '../models/get_all_carts.dart';

class GetAllCartsRepositoriesImpl implements GetCartsRepository {
  GetAllCartsRepositoriesImpl();

  @override
  Future<Either<ApiError, PaginatedData<Carts>>> fetchData(int limit) async {
    final response =
        await get(Uri.parse('${ApiConstants.baseUrl}?limit=$limit&skip=0'));

    if (response == null) {
      throw Exception();
    } else {
      try {
        if (response.statusCode == 200) {
          final result = cartsModelFromJson(response.body);

          return right(PaginatedData(result.total, result.skip, result.limit,
              dataItems: result.carts!.map((e) => e.mapCart()).toList()));
        }
      } catch (e) {
        return Left(ApiError(message: response.reasonPhrase));
      }
      throw Future.error(response.statusCode);
    }
  }
}
