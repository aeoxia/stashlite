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
    )
      ..currentPage = json['page'] as int?
      ..hasNextPage = json['has_next'] as bool?;

Map<String, dynamic> _$GetStashPointResponseToJson(
        GetStashPointResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'page': instance.currentPage,
      'has_next': instance.hasNextPage,
    };

GetStashpointItem _$GetStashpointItemFromJson(Map<String, dynamic> json) =>
    GetStashpointItem(
      id: json['id'] as String?,
      address: json['address'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      name: json['location_name'] as String?,
      imageList:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isAlwaysOpen: json['open_twentyfour_seven'] as bool?,
      priceStructure: json['pricing_structure'] == null
          ? null
          : GetStashpointItemPricing.fromJson(
              json['pricing_structure'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetStashpointItemToJson(GetStashpointItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'rating': instance.rating,
      'location_name': instance.name,
      'photos': instance.imageList,
      'open_twentyfour_seven': instance.isAlwaysOpen,
      'pricing_structure': instance.priceStructure,
    };

GetStashpointItemPricing _$GetStashpointItemPricingFromJson(
        Map<String, dynamic> json) =>
    GetStashpointItemPricing(
      firstDay: (json['first_day_cost'] as num?)?.toDouble(),
      symbol: json['ccy_symbol'] as String?,
      minorInMajor: (json['ccy_minor_in_major'] as num?)?.toDouble(),
      extraDay: (json['extra_day_cost'] as num?)?.toDouble(),
      symbolName: json['ccy'] as String?,
    );

Map<String, dynamic> _$GetStashpointItemPricingToJson(
        GetStashpointItemPricing instance) =>
    <String, dynamic>{
      'first_day_cost': instance.firstDay,
      'ccy_symbol': instance.symbol,
      'ccy_minor_in_major': instance.minorInMajor,
      'extra_day_cost': instance.extraDay,
      'ccy': instance.symbolName,
    };
