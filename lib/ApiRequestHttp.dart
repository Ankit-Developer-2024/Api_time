import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;




class ApiRequestHttp {
  final String? url;
  final dynamic data;
  final dynamic apiTimeOut;
  final Map<String,dynamic> headers;
  final Map<String,dynamic>? queryParams;
  String apiStartTime;
  String apiEndTime;
  ApiRequestHttp({required this.url, this.data, this.apiTimeOut, required this.headers,this.queryParams,required this.apiStartTime, required this.apiEndTime});


  Future<dynamic> get({
    Function()? beforeSend,
    Function(dynamic data,String startTime,String endTime)? onSuccess,
    Function(dynamic error,dynamic val,String startTime,String endTime)? onError,
  }) async {
    try {

      // print("url:----${url} ---- ${this.queryParams as Map<String, dynamic>}----${this.headers}");
      final finalUrl= queryParams!.isEmpty ? Uri.parse(url!)   : Uri.parse(url!).replace(queryParameters: queryParams );
      apiStartTime=DateTime.now().millisecondsSinceEpoch.toString();
      dynamic response = await http.get(finalUrl,headers: headers as Map<String,String>).timeout(Duration(milliseconds: apiTimeOut));
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (response.statusCode==200) {
        // print("res==${response}");
        onSuccess?.call(response,apiStartTime,apiEndTime);
      } else {
        switch (response.statusCode) {
          case 400:
            onError?.call('Bad  request',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 401:
            onError?.call('Unauthorized',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 403:
            onError?.call('Forbidden',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 404:
            onError?.call('Not found',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 500:
            onError?.call('Internal server error',response.statusCode,apiStartTime,apiEndTime);
            return null;
          default:
            onError?.call('An error occurred',response.statusCode,apiStartTime,apiEndTime);
            return null;
        }

      }
      return response;
    } on TimeoutException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Connection timeout');
      onError?.call("Connection timeout", e.message,apiStartTime,apiEndTime);
      return null;
    } on SocketException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Network error: ${e.message}');
      onError?.call("Network error",e.message,apiStartTime,apiEndTime);
      return null;
    } on HttpException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('HTTP error: $e');
      onError?.call('HTTP error',e.message,apiStartTime,apiEndTime);
    }on FormatException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Invalid format: ${e.message}');
      onError?.call("Invalid format",e.message,apiStartTime,apiEndTime);
      return null;
    } catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Uncaught exception: ${e.toString()}');
      onError?.call('Uncaught exception',e.toString(),apiStartTime,apiEndTime);
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
      final finalUrl= Uri.parse(url!);
      apiStartTime=DateTime.now().millisecondsSinceEpoch.toString();
      dynamic response = await http.post(finalUrl,body: data,headers: headers as Map<String,String>).timeout(Duration(milliseconds: apiTimeOut));
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (response.statusCode==200 || response.statusCode==201) {
        onSuccess?.call(response,apiStartTime,apiEndTime);
      } else {
        switch (response.statusCode) {
          case 400:
            onError?.call('Bad request',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 401:
            onError?.call('Unauthorized',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 403:
            onError?.call('Forbidden',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 404:
            onError?.call('Not found',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 500:
            onError?.call('Internal server error',response.statusCode,apiStartTime,apiEndTime);
            return null;
          default:
            onError?.call('An error occurred',response.statusCode,apiStartTime,apiEndTime);
            return null;
        }

      }
      return response;
    } on TimeoutException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Connection timeout');
      onError?.call("Connection timeout", e.message,apiStartTime,apiEndTime);
      return null;
    } on SocketException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Network error: ${e.message}');
      onError?.call("Network error",e.message,apiStartTime,apiEndTime);
      return null;
    } on HttpException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('HTTP error: $e');
      onError?.call('HTTP error',e.message,apiStartTime,apiEndTime);
    }on FormatException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Invalid format: ${e.message}');
      onError?.call("Invalid format",e.message,apiStartTime,apiEndTime);
      return null;
    } catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Uncaught exception: ${e.toString()}');
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

      final finalUrl= queryParams!.isEmpty ? Uri.parse(url!)   : Uri.parse(url!).replace(queryParameters: queryParams );
      apiStartTime=DateTime.now().millisecondsSinceEpoch.toString();
      dynamic response = await http.delete(finalUrl,headers: headers as Map<String,String>).timeout(Duration(milliseconds: apiTimeOut));
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (response.statusCode==200) {
        onSuccess?.call(response,apiStartTime,apiEndTime);
      } else {
        switch (response.statusCode) {
          case 400:
            onError?.call('Bad request',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 401:
            onError?.call('Unauthorized',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 403:
            onError?.call('Forbidden',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 404:
            onError?.call('Not found',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 500:
            onError?.call('Internal server error',response.statusCode,apiStartTime,apiEndTime);
            return null;
          default:
            onError?.call('An error occurred',response.statusCode,apiStartTime,apiEndTime);
            return null;
        }

      }
      return response;
    } on TimeoutException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Connection timeout');
      onError?.call("Connection timeout", e.message,apiStartTime,apiEndTime);
      return null;
    } on SocketException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Network error: ${e.message}');
      onError?.call("Network error",e.message,apiStartTime,apiEndTime);
      return null;
    } on HttpException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('HTTP error: $e');
      onError?.call('HTTP error',e.message,apiStartTime,apiEndTime);
    }on FormatException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Invalid format: ${e.message}');
      onError?.call("Invalid format",e.message,apiStartTime,apiEndTime);
      return null;
    } catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Uncaught exception: ${e.toString()}');
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
    //  print("PUT:$data");

      final finalUrl= queryParams!.isEmpty ? Uri.parse(url!)   : Uri.parse(url!).replace(queryParameters: queryParams );
      apiStartTime=DateTime.now().millisecondsSinceEpoch.toString();
      dynamic response = await http.put(finalUrl,body: data ,headers: headers as Map<String,String>).timeout(Duration(milliseconds: apiTimeOut));
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      if (response.statusCode==200 || response.statusCode==201) {
        onSuccess?.call(response,apiStartTime,apiEndTime);
      } else {
        switch (response.statusCode) {
          case 400:
            onError?.call('Bad request',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 401:
            onError?.call('Unauthorized',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 403:
            onError?.call('Forbidden',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 404:
            onError?.call('Not found',response.statusCode,apiStartTime,apiEndTime);
            return null;
          case 500:
            onError?.call('Internal server error',response.statusCode,apiStartTime,apiEndTime);
            return null;
          default:
            onError?.call('An error occurred',response.statusCode,apiStartTime,apiEndTime);
            return null;
        }

      }
      return response;
    } on TimeoutException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Connection timeout');
      onError?.call("Connection timeout", e.message,apiStartTime,apiEndTime);
      return null;
    } on SocketException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Network error: ${e.message}');
      onError?.call("Network error",e.message,apiStartTime,apiEndTime);
      return null;
    } on HttpException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('HTTP error: $e');
      onError?.call('HTTP error',e.message,apiStartTime,apiEndTime);
    }on FormatException catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Invalid format: ${e.message}');
      onError?.call("Invalid format",e.message,apiStartTime,apiEndTime);
      return null;
    } catch (e) {
      apiEndTime =DateTime.now().millisecondsSinceEpoch.toString();
      print('Uncaught  exception: ${e.toString()}');
      onError?.call(e,"",apiStartTime,apiEndTime);
      return null;
    }
    return null;
  }


}
