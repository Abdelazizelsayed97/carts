import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

import '../../../../../core/helper/pagination.dart';
import '../../../domain/get_all_carts/use_cases/get_all_carts_use_case.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final GetAllCartsUseCase getAllCartsUseCase;
  CartsCubit( this.getAllCartsUseCase) : super(CartsInitialState());

  Future getAllPosts(int pageKey) async {

    emit(CartsInitialState());
    final response = await getAllCartsUseCase.repository.getAllPosts(pageKey);
    print('########±##########################################${response}');
    emit(CartsInitialState());
    response.fold((l) {
      emit(CartsFailureState( message: l.message??""));
    }, (r) async {
      emit(CartsSuccessState(r));

    });
  }
}
