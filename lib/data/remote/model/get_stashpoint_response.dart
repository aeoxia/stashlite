import 'package:json_annotation/json_annotation.dart';

import '../definition.dart';
part 'get_stashpoint_response.g.dart';

@JsonSerializable()
class GetStashPointResponse {
  @JsonKey(name: "items")
  List<GetStashpointItem>? items;
  @JsonKey(name: "page")
  int? currentPage;
  @JsonKey(name: "has_next")
  bool? hasNextPage;

  GetStashPointResponse({this.items});

  factory GetStashPointResponse.fromJson(JsonObject json) =>
      _$GetStashPointResponseFromJson(json);
}

@JsonSerializable()
class GetStashpointItem {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "rating")
  double? rating;
  @JsonKey(name: "location_name")
  String? name;
  @JsonKey(name: "photos")
  List<String>? imageList;
  @JsonKey(name: "open_twentyfour_seven")
  bool? isAlwaysOpen;
  @JsonKey(name: "pricing_structure")
  GetStashpointItemPricing? priceStructure;

  GetStashpointItem({
    this.id,
    this.address,
    this.rating,
    this.name,
    this.imageList,
    this.isAlwaysOpen,
    this.priceStructure,
  });

  factory GetStashpointItem.fromJson(JsonObject json) =>
      _$GetStashpointItemFromJson(json);
}

@JsonSerializable()
class GetStashpointItemPricing {
  @JsonKey(name: "first_day_cost")
  double? firstDay;
  @JsonKey(name: "ccy_symbol")
  String? symbol;
  @JsonKey(name: "ccy_minor_in_major")
  double? minorInMajor;
  @JsonKey(name: "extra_day_cost")
  double? extraDay;
  @JsonKey(name: "ccy")
  String? symbolName;

  GetStashpointItemPricing({
    this.firstDay,
    this.symbol,
    this.minorInMajor,
    this.extraDay,
    this.symbolName,
  });

  factory GetStashpointItemPricing.fromJson(JsonObject json) =>
      _$GetStashpointItemPricingFromJson(json);
}
