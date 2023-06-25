// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_stashpoint_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStashPointResponse _$GetStashPointResponseFromJson(
        Map<String, dynamic> json) =>
    GetStashPointResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => GetStashpointItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetStashPointResponseToJson(
        GetStashPointResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

GetStashpointItem _$GetStashpointItemFromJson(Map<String, dynamic> json) =>
    GetStashpointItem(
      id: json['id'] as String?,
      address: json['address'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      name: json['location_name'] as String?,
    );

Map<String, dynamic> _$GetStashpointItemToJson(GetStashpointItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'rating': instance.rating,
      'location_name': instance.name,
    };
