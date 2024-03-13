import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:product_cart/core/error_handler/error_handler.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/constants.dart';

class GetAllCartsWebServices {
  var dio = Dio();


  Future<Either<ApiError, List<Carts>>> getAllCarts() async {
    Response response = await dio.request(
      'https://dummyjson.com/carts',
      options: Options(
        method: 'GET',
      ),
    );

    try {
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return response.data;
      }
      else {
        ApiError(message: response.statusMessage);
        print(response.statusMessage);
      }
    } catch (e) {
      e.toString();
    }

    throw Exception();
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
