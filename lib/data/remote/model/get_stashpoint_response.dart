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

  GetStashpointItem({this.id, this.address, this.rating, this.name});

  factory GetStashpointItem.fromJson(JsonObject json) =>
      _$GetStashpointItemFromJson(json);
}
