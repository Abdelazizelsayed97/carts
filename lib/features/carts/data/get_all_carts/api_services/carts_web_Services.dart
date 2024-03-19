import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:product_cart/core/error_handler/error_handler.dart';
import 'package:product_cart/core/helper/pagination.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

import '../models/get_all_carts.dart';

class GetAllCartsWebServices {
  final Dio dio = Dio();

  Future<Either<ApiError, PaginatedData<Carts>>> getAllCarts() async {
    Response response = await dio.request(
      'https://dummyjson.com/carts?limit=10&skip=0',
      options: Options(
        method: 'GET',
      ),
    );
    final result = ApiCartsModel.fromJson(response.data).carts;

    try {
      json.encode(response.data);
      if (response.statusCode == 200) {


        return Right(response.data);
      } else {
        ApiError(message: response.statusMessage);
        print(response.statusMessage);
      }
    } catch (e) {
      e.toString();
    }
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${response.data}');
    return response.data;

  }
}

// class CharactersWebServices {
//   Dio dio = Dio();
//
//   CharactersWebServices() {
//     BaseOptions options = BaseOptions(
//       baseUrl: baseUrl,
//       receiveDataWhenStatusError: true,
//       connectTimeout: const Duration(milliseconds: 20 * 1000), // 60 seconds,
//       receiveTimeout: const Duration(milliseconds: 20 * 1000),
//     );
//
//     dio = Dio(options);
//   }

// Future<Either<ApiError, List<GetAllCartsEntity>>> getAllCharacters() async {
//   try {
//     Response response = await dio.get('carts');
//     print(response.data.toString());
//     return response.data;
//   } catch (e) {
//     print(e.toString());
//     return [];
//   }
// }

// Future<Either<ApiError,List<Products>>> getCharacterQuotes(int PageKey) async {
//   try {
//     Response response = await dio.get('quote' , queryParameters: {'author' : PageKey});
//     print(response.data.toString());
//     return response.data;
//   } catch (e) {
//     print(e.toString());
//     return [];
//   }
// }
// }
