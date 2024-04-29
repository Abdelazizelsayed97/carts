import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_entity.dart';

import '../../../../../../core/helper/pagination.dart';
import '../../../../domain/get_all_carts/use_cases/get_all_carts_use_case.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final GetCartsUseCase getAllCartsUseCase;
  final List<Products> product = [];
  late final PaginatedData<Carts> allProduct;

  CartsCubit(this.getAllCartsUseCase) : super(CartsInitialState());

  Future<void> fetchData(int limit) async {
    print('fetchData');
    // emit(CartsInitialState());
    try {
      final response =
          await getAllCartsUseCase.fetchData(limit: limit, skip: 0);
      // emit(CartsLoadingState());
      print('---------------------');
      response.fold(
        (l) {
          emit(CartsFailureState(message: const Text('No Found Data')));
        },
        (r) async {
          emit(
            CartsSuccessState(
              getPostState: r,
            ),
          );

          allProduct = r;
        },
      );
    } catch (e) {
      emit(CartsFailureState(message: const Text('No Found Data')));
    }
  }

  Future<List<Carts>?> loadMoreCarts({required int limit}) async {
    final newCarts = await getAllCartsUseCase.fetchData(
      limit: limit,
      skip: 0,
    );
    newCarts.fold(
        (l) => emit(CartsFailureState(message: const Text('No Found Data'))),
        (r) async {
      emit(CartsSuccessState(getPostState: r));
    });
    return null;
  }

  void addAndRemoveFromCart(Products item) async {
    if (product.contains(item)) {
      product.remove(item);
      if (state is CartsSuccessState) {
        final newState = state as CartsSuccessState;
        emit(CartsSuccessState(
            product: product, getPostState: newState.getPostState));
      }
      print('item removed>>>>>>>>$product');
    } else {
      product.add(item);
      print('Item Add>>>>>>>>$product');
      if (state is CartsSuccessState) {
        final newState = state as CartsSuccessState;
        emit(CartsSuccessState(
            product: product, getPostState: newState.getPostState));
      }
    }
  }

  void deleteItem(Carts item) {
    if(state is CartsSuccessState){
      final states = state as CartsSuccessState;
      final newState = states.getPostState;
      if (newState!.dataItems.contains(item)) {
        newState.dataItems.remove(item);
        emit(CartsSuccessState(getPostState: newState,product: product));
      }
    }

  }
}
