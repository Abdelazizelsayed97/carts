// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_get_all_carts_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiPaginationInput _$ApiPaginationInputFromJson(Map<String, dynamic> json) =>
    ApiPaginationInput(
      page: json['page'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$ApiPaginationInputToJson(ApiPaginationInput instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
    };
