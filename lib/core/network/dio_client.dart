import 'package:dio/dio.dart';
import 'api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient({Dio? dio})
      : dio = dio ?? Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters, 
      }) async {
    return await dio.get<T>(
      path,
      queryParameters: queryParameters,
    );
  }

  Future<Map<String, dynamic>> post(
      String url,
      Map<String, dynamic> body,
      ) async {
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 202 || response.statusCode == 400) {
        return {
          "statusCode": response.statusCode
        };
      } else {
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    }
  }
}
