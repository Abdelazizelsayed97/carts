import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_entity.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/widgets/cart_widget.dart';

import '../../../../../../core/helper/pagination.dart';
import '../../../../domain/get_all_carts/use_cases/get_all_carts_use_case.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final GetCartsUseCase getAllCartsUseCase;
  final List<Products> product = [];

  CartsCubit(this.getAllCartsUseCase) : super(CartsInitialState());

  Future<void> fetchData(int limit) async {
    emit(CartsInitialState());
    final response = await getAllCartsUseCase.fetchData(limit: limit, skip: 0);
    emit(CartsLoadingState());
    response.fold(
          (l) {
        emit(CartsFailureState(message: l.message ?? ""));
      },
          (r) async {
        emit(
          CartsSuccessState(
            r,
          ),
        );
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

  void addAndRemoveFromCart(Products item) async{
    if (product.contains(item)) {
     product.remove(item);
      print('Item Removed >>>>>>>>>>>>$product');
      emit(RemoveSuccessState(product));
      fetchData(10);
    } else {
      product.add(item);
      print('Item Add>>>>>>>>$product');
      emit(AddSuccessState(product));
      emit(CartsSuccessState());
    }
  }
}
