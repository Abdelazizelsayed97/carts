import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:product_cart/features/carts/data/get_all_carts/repositories/get_all_carts_repo_impl.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/repositories/get_all_carts_abstract_repo.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';

import '../../features/carts/domain/get_all_carts/use_cases/get_all_carts_use_case.dart';
import '../constants/constants.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerFactory<ApiConstants>(() => ApiConstants());
  getIt.registerFactory<GetCartsRepository>(
      () => GetAllCartsRepositoriesImpl());
  getIt.registerFactory<CartsCubit>(() => CartsCubit(getIt()));

  getIt.registerFactory<GetCartsUseCase>(
    () => GetCartsUseCase(getIt<GetCartsRepository>()),
  );
}


