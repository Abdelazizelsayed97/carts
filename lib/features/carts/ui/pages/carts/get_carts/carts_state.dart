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
  List<Object?> get props => [];
}

class CartsSuccessState extends CartsState {
  final PaginatedData<Carts>? getPostState;
  final List<Products>? product;

  // final List<Products>? removedProducts;

  CartsSuccessState({
    this.getPostState,
    this.product,
  });

  CartsSuccessState reduce({
    PaginatedData<Carts>? getPostState,
    List<Products>? product,
    List<Products>? removedProducts,
  }) {
    return CartsSuccessState(
      product: product ?? this.product,
      getPostState: getPostState ?? this.getPostState,
    );
  }

  @override
  List<Object?> get props => [
        getPostState,
        product,
      ];
}

class CartsFailureState extends CartsState {
  final Text message;

  CartsFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

class AddOrRemoveSuccessState extends CartsState {
  final List<Products> product;

  AddOrRemoveSuccessState(this.product);

  @override
  List<Object?> get props => [product];
}
