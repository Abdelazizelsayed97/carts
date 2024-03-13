import 'package:equatable/equatable.dart';

class PaginatedData<T> extends Equatable {
  final List<T> dataItems;
  final PageInfo pageInfo;

  const PaginatedData({
    required this.dataItems,
    required this.pageInfo,
  });

  @override
  List<Object?> get props => [
        dataItems,
        pageInfo,
      ];
}

class PageInfo extends Equatable {
  final int page;
  final int limit;
  final bool hasNext;

  const PageInfo({
    required this.page,
    required this.limit,
    required this.hasNext,
  });

  @override
  List<Object?> get props => [
        page,
        limit,
        hasNext,
      ];
}
