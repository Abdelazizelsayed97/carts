import 'package:get_it/get_it.dart';
import 'package:product_cart/features/carts/data/get_all_carts/repositories/get_all_carts_repo_impl.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/repositories/get_all_carts_abstract_repo.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';

import '../../features/carts/domain/get_all_carts/use_cases/get_all_carts_use_case.dart';
import '../constants/constants.dart';

final GetIt inject = GetIt.instance;

Future<void> setupGetIt() async {
  inject.registerFactory<ApiConstants>(() => ApiConstants());

  inject
      .registerFactory<GetCartsRepository>(() => GetAllCartsRepositoriesImpl());

  inject.registerFactory<CartsCubit>(() => CartsCubit(inject()));

  inject.registerFactory<GetCartsUseCase>(
    () => GetCartsUseCase(inject<GetCartsRepository>()),
  );
}
