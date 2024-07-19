import 'package:dio/dio.dart';




class ApiRequest {
  final String? url;
  final dynamic data;
  final dynamic apiTimeOut;
  final Map<String,dynamic> headers;
  final Map<String,dynamic>? queryParams;
  ApiRequest({required this.url, this.data, this.apiTimeOut, required this.headers,this.queryParams});

  Dio _dio() {
    print('===$headers');
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
    Function(dynamic data)? onSuccess,
    Function(dynamic error,dynamic val)? onError,
  }) async {
    try {

      // print("url:----${url} ---- ${this.queryParams as Map<String, dynamic>}----${this.headers}");
      dynamic response = await _dio().get(url!, queryParameters: queryParams as Map<String, dynamic>, );

      if (response!=null) {
        onSuccess?.call(response);
      } else {
        onError?.call('api error in get   Request ','');
      }
       return response;
    } on DioException catch (e) {

        if (e.type == DioExceptionType.connectionTimeout) {
          print('Connection timeout');
          onError?.call("Connection timeout",e.message);

          return null;
        } else if (e.type == DioExceptionType.sendTimeout) {
          print('Send timeout');
          onError?.call("Send timeout",e.message);
          return null;
        } else if (e.type == DioExceptionType.receiveTimeout) {
          print('Receive timeout');
          onError?.call("Receive timeout",e.message);
          return null;
        } else if (e.type == DioExceptionType.badResponse) {
          // The server responded with a non-2xx status code
          print('Response error: ${e.response?.statusCode}');
          onError?.call("Response error",e.response);
          return null;
        } else if (e.type == DioExceptionType.cancel) {
          print('Request cancelled');
          onError?.call("Request cancelled",e.message);
          return null;
        } else if (e.type == DioExceptionType.unknown) {
          // Other errors, such as network issues or DNS lookup failures
          print('Other error: ${e.message}');
          onError?.call("Other error",e.message);
          return null;

        }
      } catch (e) {
      print('Uncaught exception: ${e.toString()}');
      onError?.call(e,"");
      return null;
    }


    return null;
  }


  Future<dynamic> post({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error,dynamic val)? onError,
  }) async {
    try {

     // print("api call triggered --->" + this.url!);
      dynamic response = await _dio().post(url!, data: data);
      if (response != null) {
        onSuccess?.call(response);
      } else {
        onError?.call('api error in post Request','');
      }
      return response;
    } on DioException catch (e) {

      if (e.type == DioExceptionType.connectionTimeout) {
        print('Connection timeout');
        onError?.call("Connection timeout",e.message);
        return null;
      } else if (e.type == DioExceptionType.sendTimeout) {
        print('Send timeout');
        onError?.call("Send timeout",e.message);
        return null;
      } else if (e.type == DioExceptionType.receiveTimeout) {
        print('Receive timeout');
        onError?.call("Receive timeout",e.message);
        return null;
      } else if (e.type == DioExceptionType.badResponse) {
        // The server responded with a non-2xx status code
        print('Response error: ${e.response?.statusCode}');
        onError?.call("Response error",e.response);
        return null;
      } else if (e.type == DioExceptionType.cancel) {
        print('Request cancelled');
        onError?.call("Request cancelled",e.message);
        return null;
      } else if (e.type == DioExceptionType.unknown) {
        // Other errors, such as network issues or DNS lookup failures
        print('Other error: ${e.message}');
        onError?.call("Other error",e.message);
        return null;
      }
    } catch (e) {
      onError?.call(e,"");
      return null;
    }
    return null;
  }

  Future<dynamic> delete({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error,dynamic val)? onError,
  }) async {
    try {

      dynamic response = await _dio().delete(url!,data: data, queryParameters: queryParams as Map<String, dynamic> );
      if (response != null) {
        onSuccess?.call(response);
      } else {
        onError?.call('Api error in delete request ','');
      }
      return response;
    } on DioException catch (e) {

      if (e.type == DioExceptionType.connectionTimeout) {
        print('Connection timeout');
        onError?.call("Connection timeout",e.message);
        return null;
      } else if (e.type == DioExceptionType.sendTimeout) {
        print('Send timeout');
        onError?.call("Send timeout",e.message);
        return null;
      } else if (e.type == DioExceptionType.receiveTimeout) {
        print('Receive timeout');
        onError?.call("Receive timeout",e.message);
        return null;
      } else if (e.type == DioExceptionType.badResponse) {
        // The server responded with a non-2xx status code
        print('Response error: ${e.response?.statusCode}');
        onError?.call("Response error",e.response);
        return null;
      } else if (e.type == DioExceptionType.cancel) {
        print('Request cancelled');
        onError?.call("Request cancelled",e.message);
        return null;
      } else if (e.type == DioExceptionType.unknown) {
        // Other errors, such as network issues or DNS lookup failures
        print('Other error: ${e.message}');
        onError?.call("Other error",e.message);
        return null;
      }
    } catch (e) {
      onError?.call(e,"");
      return null;
    }
    return null;
  }

  Future<dynamic> put({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error,dynamic val)? onError,
  }) async {
    try {
      print("qq$queryParams");
      dynamic response = await _dio().put(url! , queryParameters: queryParams);
      if (response != null) {
        onSuccess?.call(response);
      } else {
        onError?.call('api error in put Request','');
      }
      return response;
    } on DioException catch (e) {

      if (e.type == DioExceptionType.connectionTimeout) {
        print('Connection timeout');
        onError?.call("Connection timeout",e.message);
        return null;
      } else if (e.type == DioExceptionType.sendTimeout) {
        print('Send timeout');
        onError?.call("Send timeout",e.message);
        return null;
      } else if (e.type == DioExceptionType.receiveTimeout) {
        print('Receive timeout');
        onError?.call("Receive timeout",e.message);
        return null;
      } else if (e.type == DioExceptionType.badResponse) {
        // The server responded with a non-2xx status code
        print('Response error: ${e.response?.statusCode}');
        onError?.call("Response error",e.response);
        return null;
      } else if (e.type == DioExceptionType.cancel) {
        print('Request cancelled');
        onError?.call("Request cancelled",e.message);
        return null;
      } else if (e.type == DioExceptionType.unknown) {
        // Other errors, such as network issues or DNS lookup failures
        print('Other error: ${e.message}');
        onError?.call("Other  error",e.message);
        return null;
      }
    } catch (e) {
      onError?.call(e,"");
      return null;
    }
    return null;
  }


}
