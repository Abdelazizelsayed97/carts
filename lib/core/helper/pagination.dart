import 'package:equatable/equatable.dart';

class PaginatedData<T> extends Equatable {
  final List<T> dataItems;
  final int? total;
  final int? skip;
  final int? limit;

  const PaginatedData(this.total, this.skip, this.limit, {
    required this.dataItems,
  });

  @override
  List<Object?> get props => [
    dataItems,
  ];
}
