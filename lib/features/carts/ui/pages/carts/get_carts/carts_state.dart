part of 'carts_cubit.dart';

@immutable
abstract class CartsState extends Equatable {}

class CartsInitialState extends CartsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartsLoadingState extends CartsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartsSuccessState extends CartsState {
  final PaginatedData<Carts> getPostState;

  CartsSuccessState(this.getPostState, );

  @override
  // TODO: implement props
  List<Object?> get props => [getPostState, ];
}

class CartsFailureState extends CartsState {
  final String message;

  CartsFailureState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

class AddOrRemoveSuccessState extends CartsState {
  @override
  List<Object?> get props => [];
}

class AddOrRemoveFailureState extends CartsState {
  @override
  List<Object?> get props => [];
}
