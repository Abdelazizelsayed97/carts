part of 'search_cubit.dart';

@immutable
abstract class SearchState extends Equatable {}

class SearchInitial extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchSuccess extends SearchState {
  SearchSuccess(Iterable<List<Products>> map);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
