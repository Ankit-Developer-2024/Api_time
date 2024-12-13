import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class ApiRequestDio {
  final String? url;
  final dynamic data;
  final dynamic apiTimeOut;
  final Map<String,dynamic> headers;
  final Map<String,dynamic>? queryParams;
  String apiStartTime;
  String apiEndTime;
  ApiRequestDio({required this.url, this.data, this.apiTimeOut, required this.headers,this.queryParams,required this.apiStartTime,required this.apiEndTime});

  Dio _dio() {
   // print('===$headers');
    var options = BaseOptions(
      headers: headers,
      connectTimeout: Duration(milliseconds: apiTimeOut),
      receiveTimeout: Duration(milliseconds: apiTimeOut),
    );
    var dio = Dio(options);

    return dio;
  }


  Future<dynamic> get({
    Function()? beforeSend,
    Function(dynamic data,String startTime,String endTime)? onSuccess,
    Function(dynamic error,dynamic val,String startTime,String endTime)? onError,
  }) async {
    try {

      // print("url:----${url} ---- ${this.queryParams as Map<String, dynamic>}----${this.headers}");
      apiStartTime=DateTime.now().millisecondsSinceEpoch.toString();
      dynamic response = await _dio().get(url!, queryParameters: queryParams as Map<String, dynamic>, );
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();

      if (response!=null) {
        onSuccess?.call(response,apiStartTime,apiEndTime);
      } else {
        onError?.call('api error in get   Request ','',apiStartTime,apiEndTime);
      }
       return response;
    } on DioException catch (e) {
        apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
        if (e.type == DioExceptionType.connectionTimeout) {
          if (kDebugMode) {
            print('Connection timeout');
          }
          onError?.call("Connection timeout",e.message,apiStartTime,apiEndTime);

          return null;
        } else if (e.type == DioExceptionType.sendTimeout) {
          //print('Send timeout');
          onError?.call("Send timeout",e.message,apiStartTime,apiEndTime);
          return null;
        } else if (e.type == DioExceptionType.receiveTimeout) {
          //print('Receive timeout');
          onError?.call("Receive timeout",e.message,apiStartTime,apiEndTime);
          return null;
        } else if (e.type == DioExceptionType.badResponse) {
          // The server responded with a non-2xx status code
         // print('Response error: ${e.response?.statusCode}');
          onError?.call("Response error",e.response,apiStartTime,apiEndTime);
          return null;
        } else if (e.type == DioExceptionType.cancel) {
          //print('Request cancelled');
          onError?.call("Request cancelled",e.message,apiStartTime,apiEndTime);
          return null;
        } else if (e.type == DioExceptionType.unknown) {
          // Other errors, such as network issues or DNS lookup failures
          if (kDebugMode) {
            print('Other error: ${e.message}');
          }
          onError?.call("Other error",e.message,apiStartTime,apiEndTime);
          return null;

        }
      } catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      //print('Uncaught exception: ${e.toString()}');
      onError?.call(e,"",apiStartTime,apiEndTime);
      return null;
    }


    return null;
  }


  Future<dynamic> post({
    Function()? beforeSend,
    Function(dynamic data,String startTime,String endTime)? onSuccess,
    Function(dynamic error,dynamic val,String startTime,String endTime)? onError,
  }) async {
    try {

     // print("api call triggered --->" + this.url!);
      apiStartTime=DateTime.now().millisecondsSinceEpoch.toString();
      dynamic response = await _dio().post(url!, data: data);
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (response != null) {
        onSuccess?.call(response,apiStartTime,apiEndTime);
      } else {
        onError?.call('api error in post Request','',apiStartTime,apiEndTime);
      }
      return response;
    } on DioException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (e.type == DioExceptionType.connectionTimeout) {
        if (kDebugMode) {
          print('Connection timeout');
        }
        onError?.call("Connection timeout",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.sendTimeout) {
        if (kDebugMode) {
          print('Send timeout');
        }
        onError?.call("Send timeout",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.receiveTimeout) {
        if (kDebugMode) {
          print('Receive timeout');
        }
        onError?.call("Receive timeout",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.badResponse) {
        // The server responded with a non-2xx status code
        if (kDebugMode) {
          print('Response error: ${e.response?.statusCode}');
        }
        onError?.call("Response error",e.response,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.cancel) {
        if (kDebugMode) {
          print('Request cancelled');
        }
        onError?.call("Request cancelled",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.unknown) {
        // Other errors, such as network issues or DNS lookup failures
        if (kDebugMode) {
          print('Other error: ${e.message}');
        }
        onError?.call("Other error",e.message,apiStartTime,apiEndTime);
        return null;
      }
    } catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      onError?.call(e,"",apiStartTime,apiEndTime);
      return null;
    }
    return null;
  }

  Future<dynamic> delete({
    Function()? beforeSend,
    Function(dynamic data,String startTime,String endTime)? onSuccess,
    Function(dynamic error,dynamic val,String startTime,String endTime)? onError,
  }) async {
    try {
      apiStartTime=DateTime.now().millisecondsSinceEpoch.toString();
      dynamic response = await _dio().delete(url!,data: data, queryParameters: queryParams as Map<String, dynamic> );
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (response != null) {
        onSuccess?.call(response,apiStartTime,apiEndTime);
      } else {
        onError?.call('Api error in delete request ','',apiStartTime,apiEndTime);
      }
      return response;
    } on DioException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (e.type == DioExceptionType.connectionTimeout) {
        if (kDebugMode) {
          print('Connection timeout');
        }
        onError?.call("Connection timeout",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.sendTimeout) {
        if (kDebugMode) {
          print('Send timeout');
        }
        onError?.call("Send timeout",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.receiveTimeout) {
        if (kDebugMode) {
          print('Receive timeout');
        }
        onError?.call("Receive timeout",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.badResponse) {
        // The server responded with a non-2xx status code
        if (kDebugMode) {
          print('Response error: ${e.response?.statusCode}');
        }
        onError?.call("Response error",e.response,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.cancel) {
        if (kDebugMode) {
          print('Request cancelled');
        }
        onError?.call("Request cancelled",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.unknown) {
        // Other errors, such as network issues or DNS lookup failures
        if (kDebugMode) {
          print('Other error: ${e.message}');
        }
        onError?.call("Other error",e.message,apiStartTime,apiEndTime);
        return null;
      }
    } catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      onError?.call(e,"",apiStartTime,apiEndTime);
      return null;
    }
    return null;
  }

  Future<dynamic> put({
    Function()? beforeSend,
    Function(dynamic data,String startTime,String endTime)? onSuccess,
    Function(dynamic error,dynamic val,String startTime,String endTime)? onError,
  }) async {
    try {
     // print("qq$queryParams");
      apiStartTime=DateTime.now().millisecondsSinceEpoch.toString();
      dynamic response = await _dio().put(url! , queryParameters: queryParams);
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (response != null) {
        onSuccess?.call(response,apiStartTime,apiEndTime);
      } else {
        onError?.call('api error in put Request','',apiStartTime,apiEndTime);
      }
      return response;
    } on DioException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (e.type == DioExceptionType.connectionTimeout) {
        if (kDebugMode) {
          print('Connection timeout');
        }
        onError?.call("Connection timeout",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.sendTimeout) {
        if (kDebugMode) {
          print('Send timeout');
        }
        onError?.call("Send timeout",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.receiveTimeout) {
        if (kDebugMode) {
          print('Receive timeout');
        }
        onError?.call("Receive timeout",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.badResponse) {
        // The server responded with a non-2xx status code
        if (kDebugMode) {
          print('Response error: ${e.response?.statusCode}');
        }
        onError?.call("Response error",e.response,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.cancel) {
        if (kDebugMode) {
          print('Request cancelled');
        }
        onError?.call("Request cancelled",e.message,apiStartTime,apiEndTime);
        return null;
      } else if (e.type == DioExceptionType.unknown) {
        // Other errors, such as network issues or DNS lookup failures
        if (kDebugMode) {
          print('Other error: ${e.message}');
        }
        onError?.call("Other  error",e.message,apiStartTime,apiEndTime);
        return null;
      }
    } catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      onError?.call(e,"",apiStartTime,apiEndTime);
      return null;
    }
    return null;
  }


}
