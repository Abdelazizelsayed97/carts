import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

import '../domain/use_cases/search_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase searchUseCase;

  SearchCubit(this.searchUseCase) : super(SearchInitial());

  void setSearchUseCase() async {
    final result = await searchUseCase.execute();
    result.fold((l) => emit(SearchFailure(l.message??"")),
        (r) => emit(SearchSuccess(r.dataItems.map((e) => e.items))));
  }
}
