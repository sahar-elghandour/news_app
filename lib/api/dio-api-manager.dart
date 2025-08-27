import 'package:dio/dio.dart';
import 'package:news_app/api/app-exception.dart';
import 'package:news_app/api/endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../model/NewsResponse.dart';
import '../model/SourceResponse.dart';
import 'api_constant.dart';

class DioApiManager{
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org',
      queryParameters: {
        'apiKey':ApiConstant.apiKey,
      }
    )
  );
  DioApiManager._(){
    dio.interceptors.add(DioInterceptors());
    dio.interceptors.add(PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
            enabled: true,

        )
        );
  }
  static DioApiManager? _dioApiManager;

  static DioApiManager getInstance(){

    return _dioApiManager ??= DioApiManager._();

  }
  Future<SourceResponse?> getSources(String categoryId) async {
    try{
      var response = await dio.get(EndPoints.sourceApi
          , queryParameters: {
            'category':categoryId
          });

      var json = response.data;//todo: json
      //todo:json => obj
      var sourceResponse=SourceResponse.fromJson(json);
      return sourceResponse;

    }
   // on DioException catch(e){
    //  e.error;

   // }
    catch(e){
      rethrow;
    }
    
  }
  Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    try{
      var response = await dio.get(EndPoints.everythingApi
          , queryParameters: {

            'sources': sourceId,
          });
      //todo:json => obj
      var newsResponse=NewsResponse.fromJson(response.data);
      return newsResponse;

    }catch(e){
      rethrow;
    }

  }

}
class DioInterceptors extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    String message = 'Something went wrong, Please try again';

    try {
      if (err.response !=null&& err.response!.data is Map &&
          err.response!.data.containsKey('message')) {
        message = err.response!.data['message'];

      } else {

//todo: fallback message for other bad response types
        switch (err.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.connectionError:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.sendTimeout:
            message =
            'Connection time out. Please check your internet connection.';
            break;
          case DioExceptionType.badResponse:
            message =
            'Failed to load data. status code: ${err.response?.statusCode}';
            break;
          case DioExceptionType.cancel:
            message = 'Request was cancelled.';
            break;
          case DioExceptionType.unknown:
            message = 'An unknown network error occurred';
            break;
          default:
            message = 'An unknown error occurred';

            break;
        }}}
    catch (e) {
//todo: if parsing fails, fall back to a generic message

      message = 'An unexpected error occurred: ${e.toString()}';
    }
    //super.onError(err, handler);
    handler.next(DioException(
        requestOptions: err.requestOptions,
      message: message,
      error: AppException(message: message),
      type: err.type,
      response: err.response
    ));
  }
}