import 'package:al_hidayah/utils/store.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await Store.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }
}
