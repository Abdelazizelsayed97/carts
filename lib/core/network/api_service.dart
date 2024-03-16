import 'package:dio/dio.dart';
import 'package:product_cart/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/carts/data/get_all_carts/models/api_get_all_carts_input.dart';
import '../../features/carts/data/get_all_carts/models/get_all_carts.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(ApiConstants.baseUrl)
  Future<ApiCartsModel> call(
    @Body() ApiPaginationInput paginationInput,
  );
}
