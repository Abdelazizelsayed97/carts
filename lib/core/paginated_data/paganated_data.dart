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
  final int? total;
  final int? skip;
  final int? limit;

  const PageInfo( {this.total, this.skip, this.limit,

  });

  @override
  List<Object?> get props => [
    total,skip,limit
      ];
}
