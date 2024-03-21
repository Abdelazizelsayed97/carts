import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

import '../../../../../../core/helper/pagination.dart';
import '../../../../domain/get_all_carts/use_cases/get_all_carts_use_case.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final GetCartsUseCase getAllCartsUseCase;

  CartsCubit(this.getAllCartsUseCase) : super(CartsInitialState());

  Future<void> fetchData(int limit) async {
    emit(CartsInitialState());
    final response = await getAllCartsUseCase.fetchData(limit: limit, skip: 0);
    print('########±##########################################${response}');
    emit(CartsLoadingState());
    response.fold(
      (l) {
        emit(CartsFailureState(message: l.message ?? ""));
      },
      (r) async {
        emit(CartsSuccessState(
          r,
        ));
      },
    );
  }

  Future<List<Carts>?> loadMoreCarts({required int limit}) async {
    final newCarts = await getAllCartsUseCase.fetchData(
      limit: limit,
      skip: 0,
    );
    newCarts.fold((l) => emit(CartsFailureState(message: l.message ?? "")),
        (r) async {
      emit(CartsSuccessState(r));
    });
    return null;
  }

// void addProduct(Products product) {
//   final List<Products> updatedCart = List.from()..add(product);
//   emit();
// }
//
// void removeProduct(String product) {
//   final List<String> updatedCart = List.from(state)..remove(product);
//   emit();
// }
}
