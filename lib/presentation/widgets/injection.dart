import 'package:dio/dio.dart';
import 'package:eyecg/data/web_services/web_services.dart';
import 'package:get_it/get_it.dart';
/*
final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton<WebServices>( () => WebServices( createAndSetupDio() ));
}

Dio createAndSetupDio(){
  Dio dio = Dio();
  dio
    ..options.connectTimeout = const Duration(seconds : 30)
    ..options.receiveTimeout = const Duration(seconds : 30);
  dio.interceptors.add(LogInterceptor(
    responseBody: true,
    error: true,
    requestHeader: false,
    responseHeader: false,
    request: true,
    requestBody: true,
  ));
  return dio;
}
*/
