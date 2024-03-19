import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import 'package:product_cart/core/helper/pagination.dart';
import 'package:product_cart/features/carts/data/get_all_carts/models/get_all_carts.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

import '../../../../../core/error_handler/error_handler.dart';

abstract class GetAllCartsRepository {
  Future<Either<ApiError, PaginatedData<Carts>>> fetchData(int limit);
}
