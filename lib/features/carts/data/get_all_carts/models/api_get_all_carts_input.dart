

import 'package:json_annotation/json_annotation.dart';

part 'api_get_all_carts_input.g.dart';

@JsonSerializable()
class ApiPaginationInput {
  final int? page;
  final int? limit;

  ApiPaginationInput({
    this.page,
    this.limit,
  });
  factory ApiPaginationInput.fromJson(Map<String, dynamic> json) =>
      _$ApiPaginationInputFromJson(json);

  Map<String, dynamic> toJson() => _$ApiPaginationInputToJson(this);
}