// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stasher_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _StasherService implements StasherService {
  _StasherService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api-staging.stasher.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GetStashPointResponse> getStashpoints(
    active,
    availability,
    capacity,
    dropOff,
    pickUp,
    latitude,
    longtitude,
    page,
    itemCount,
    sort,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'active': active,
      r'availability': availability,
      r'capacity': capacity,
      r'dropoff': dropOff,
      r'pickup': pickUp,
      r'lat': latitude,
      r'lng': longtitude,
      r'page': page,
      r'per_page': itemCount,
      r'sort': sort,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetStashPointResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'v2/stashpoints',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetStashPointResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
