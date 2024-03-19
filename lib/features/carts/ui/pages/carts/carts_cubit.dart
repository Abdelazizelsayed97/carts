import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

import '../../../../../core/helper/pagination.dart';
import '../../../domain/get_all_carts/use_cases/get_all_carts_use_case.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final GetAllCartsUseCase getAllCartsUseCase;

  CartsCubit(this.getAllCartsUseCase) : super(CartsInitialState());
  List<Carts> newCarts = [];

  Future fetchData(int limit) async {
    emit(CartsInitialState());
    final response = await getAllCartsUseCase.fetchData(limit: limit, skip: 0);
    print('########±##########################################${response}');
    emit(CartsLoadingState());
    response.fold(
      (l) {
        emit(CartsFailureState(message: l.message ?? ""));
      },
      (r) async {
        emit(CartsSuccessState(r));
      },
    );
  }

  void loadMoreCarts({required int limit}) async {
    final newCarts = await getAllCartsUseCase.fetchData(
      limit: 10,
      skip: _currentPage * 10,
    );
    newCarts.fold((l) => emit(CartsFailureState(message: l.message ?? "")),
        (r) {
      emit(CartsSuccessState(r));
      _carts.addAll(r.dataItems);
      _cartsController.sink.add(_carts);
      _currentPage++;
    });
  }
}

final _cartsController = StreamController<List<Carts>>();

Stream<List<Carts>> get cartsStream => _cartsController.stream;

int _currentPage = 0;
List<Carts> _carts = [];

void dispose() {
  _cartsController.close();
}
