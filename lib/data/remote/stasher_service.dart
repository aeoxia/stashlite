import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'model/get_stashpoint_response.dart';

part 'stasher_service.g.dart';

@RestApi(baseUrl: "https://api-staging.stasher.com/")
abstract class StasherService {
  factory StasherService(Dio dio, {String baseUrl}) = _StasherService;

  @GET("v2/stashpoints")
  Future<GetStashPointResponse> getStashpoints(
      @Query("active") bool active,
      @Query("availability") String availability,
      @Query("capacity") int capacity,
      @Query("dropoff") String dropOff,
      @Query("pickup") String pickUp,
      @Query("lat") double latitude,
      @Query("lng") double longtitude,
      @Query("page") int page,
      @Query("per_page") int itemCount,
      @Query("sort") String sort);
}
