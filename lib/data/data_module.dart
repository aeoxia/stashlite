import 'package:city_stasher_lite/data/remote/stasher_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataModule {
  Dio get dio => Dio();
  StasherService getStasherService(Dio dio) => StasherService(dio);
}
