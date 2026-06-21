import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:small_food_app/core/networking/api_endpoints.dart';

class DioHelper {
  static Dio? dio;

  static void initDio() {
    if (dio != null) return;
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio!.interceptors.add(PrettyDioLogger());
  }

  static Future<Response> getDio({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    final Response response;

    try {
      response = await dio!.get(endPoint, queryParameters: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
