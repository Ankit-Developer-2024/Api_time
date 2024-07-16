
import 'dart:convert';

import 'package:api_time/ApiRequestDio.dart';
import 'package:api_time/ApiRequestHttp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HomePageController extends GetxController {


  TextEditingController cURLController = TextEditingController();
  TextEditingController timeOutController = TextEditingController(text: '30000');
  TextEditingController apiCallCountController = TextEditingController(
      text: '1');
  TextEditingController apiIntervalController = TextEditingController(
      text: '0');

  RxList cURL = [].obs;
  RxString token = ''.obs;
  RxInt apiTimeOut = 30000.obs;
  RxString apiMethod="Dio".obs;

  RxInt apiCallCount = 1.obs;
  RxInt apiInterval = 0.obs;


  RxString apiStartTime = ''.obs;
  RxString apiEndTime = ''.obs;
  RxInt totalDuration = 0.obs;

  RxInt successRequest = 0.obs;
  RxInt failedRequest = 0.obs;

  RxList<Map<String, dynamic>>? urls;

  RxList<Map<String, dynamic>>? apiDetails;

  @override
  void onInit() {
    super.onInit();
    apiDetails = <Map<String, dynamic>>[].obs;
    urls = <Map<String, dynamic>>[].obs;
  }

  void setData() {
    if (cURLController.text.isNotEmpty) {
      cURL.value = cURLController.text
          .replaceAll(']', "")
          .replaceAll('[', "")
          .split('@@%')
          .map((item) => item.trim())
          .toList();
           print('in setData  as list:  $cURL');
    }

    if (timeOutController.text.isNotEmpty) {
      apiTimeOut.value = int.parse(timeOutController.text);
    }

    for (int i = 0; i <cURL.length;i++){
        callApiFromCurl(cURL[i]);
       }


  }

  void api() async {
    int index=0;
    for (int j = 0; j < apiCallCount.value; j++) {
      for (int i = 0; i < urls!.length; i++) {

        apiMethod.value=='Dio' ? apiCall(i,index,j): apiCallhttp(i,index,j);
        index++;
      }
      await Future.delayed(Duration(milliseconds: apiInterval.value));
    }
  }


  void apiCall(int i,int index,int j) async {
    dynamic apiData=urls?[i];
  //  print("aptData: $apiData");
    switch(apiData["requestType"]){
      case "GET":
        try{
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "apiIndex": (j + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );
          apiStartTime.value = DateTime.now().millisecondsSinceEpoch.toString();
           ApiRequest(url: apiData["url"],queryParams: apiData["queryParameter"],apiTimeOut: apiData["timeOut"],headers: apiData["headers"]).get(
            onSuccess: (res) {
              String responseString = res.toString();
              apiEndTime.value = DateTime.now().millisecondsSinceEpoch.toString();
              totalDuration.value = int.parse(apiEndTime.value) - int.parse(apiStartTime.value);
               apiDetails?[index]={
                 "urlNumber": (i + 1).toString(),
                 "apiIndex": (j + 1).toString(),
                 "url": apiData['url'],
                 "requestType":apiData['requestType'],
                 "startTime": apiStartTime.value,
                 "endTime": apiEndTime.value,
                 "duration": totalDuration.value,
                 "resBody": responseString,
                 "statusCode": res.statusCode,
               };
               successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val) {
              String responseString = val.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err ,$val");
            },
          );
        }catch (e) {
          print('pp$e');
        }

        break;
      case "POST":
        try {
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );
          apiStartTime.value = DateTime.now().millisecondsSinceEpoch.toString();
          await ApiRequest(url: apiData["url"],data: apiData["data"],apiTimeOut: apiData["timeOut"],headers: apiData["headers"]).post(
            onSuccess: (res) {
            String responseString = res.toString();
            apiEndTime.value = DateTime.now().millisecondsSinceEpoch.toString();
            totalDuration.value = int.parse(apiEndTime.value) - int.parse(apiStartTime.value);
            apiDetails?[index]={
              "urlNumber": (i + 1).toString(),
              "url": apiData['url'],
              "requestType":apiData['requestType'],
              "startTime": apiStartTime.value,
              "endTime": apiEndTime.value,
              "duration": totalDuration.value,
              "resBody": responseString,
              "statusCode": res.statusCode,
            };
            successRequest.value+=1;
            print('api Success');
          },
            onError: (err,val) {
              String responseString = val.toString();
              //print("=99${val.statusCode}");
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err");
            },
          );
        }catch (e) {
          print('$e');
        }
        break;
      case "PUT":
      try {
        apiDetails?.add(
            {
              "urlNumber": (i + 1).toString(),
              "url": apiData['url'],
              "requestType":apiData['requestType'],
              "startTime": apiStartTime.value,
              "endTime": apiEndTime.value,
              "duration": "Loader",
              "resBody": "Loader",
              "statusCode": "Loader"
            }
        );
        apiStartTime.value = DateTime.now().millisecondsSinceEpoch.toString();
        await ApiRequest(url: apiData["url"],queryParams: apiData["queryParameter"],data: apiData["data"],apiTimeOut: apiData["timeOut"],headers: apiData["headers"]).put(
          onSuccess: (res) {
            String responseString = res.toString();
            apiEndTime.value = DateTime.now().millisecondsSinceEpoch.toString();
            totalDuration.value = int.parse(apiEndTime.value) - int.parse(apiStartTime.value);
            apiDetails?[index]={
              "urlNumber": (i + 1).toString(),
              "url": apiData['url'],
              "requestType":apiData['requestType'],
              "startTime": apiStartTime.value,
              "endTime": apiEndTime.value,
              "duration": totalDuration.value,
              "resBody": responseString,
              "statusCode": res.statusCode,
            };
            successRequest.value+=1;
            print('api Success');
          },
          onError: (err,val) {
            String responseString = val.toString();
          //  print("=99${val.statusCode}");
            apiDetails?[index]={
              "urlNumber": (i + 1).toString(),
              "url": apiData['url'],
              "requestType":apiData['requestType'],
              "startTime": apiStartTime.value,
              "endTime": apiEndTime.value,
              "duration": totalDuration.value,
              "resBody": responseString,
              "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
            };
            failedRequest.value+=1;
            print("-----$err");
          },
        );
       }catch (e) {
        print('$e');
       }
        break;
      case "DELETE":
         try{
           apiDetails?.add(
               {
                 "urlNumber": (i + 1).toString(),
                 "url": apiData['url'],
                 "requestType":apiData['requestType'],
                 "startTime": apiStartTime.value,
                 "endTime": apiEndTime.value,
                 "duration": "Loader",
                 "resBody": "Loader",
                 "statusCode": "Loader"
               }
           );
           apiStartTime.value = DateTime.now().millisecondsSinceEpoch.toString();
           await ApiRequest(url: apiData["url"],queryParams: apiData["queryParameter"],apiTimeOut: apiData["timeOut"], headers: apiData["headers"]).delete(
             onSuccess: (res) {
               String responseString = res.toString();
               apiEndTime.value = DateTime.now().millisecondsSinceEpoch.toString();
               totalDuration.value = int.parse(apiEndTime.value) - int.parse(apiStartTime.value);
               apiDetails?[index]={
                 "urlNumber": (i + 1).toString(),
                 "url": apiData['url'],
                 "requestType":apiData['requestType'],
                 "startTime": apiStartTime.value,
                 "endTime": apiEndTime.value,
                 "duration": totalDuration.value,
                 "resBody": responseString,
                 "statusCode": res.statusCode,
               };
               successRequest.value+=1;
               print('api Success');
             },
             onError: (err,val) {
               String responseString = val.toString();
              // print("=99${val.statusCode}");
               apiDetails?[index]={
                 "urlNumber": (i + 1).toString(),
                 "url": apiData['url'],
                 "requestType":apiData['requestType'],
                 "startTime": apiStartTime.value,
                 "endTime": apiEndTime.value,
                 "duration": totalDuration.value,
                 "resBody": responseString,
                 "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
               };
               failedRequest.value+=1;
               print("-----$err");
             },
           );
         }catch (e) {
          print(e);
         }
        break;
        default:
          print('Invalid request type');
          break;
    }

  }



  void callApiFromCurl(String curlCommand) async {
    try{
      RegExp urlRegex = RegExp(
        r"""curl\s+(?:--location\s+)?(?:-[LX]|--location|--location\s+--request|--request|\s+(GET|POST|PUT|DELETE))?\s*(GET|POST|PUT|DELETE)?\s*['"]?([^'"\s]+)['"]?""",
        caseSensitive: true,
      );
      String? url;
      String? requestType;
      List l=[];
      l.add(curlCommand);
      for (var curlCommand in l) {
        var match = urlRegex.firstMatch(curlCommand);
        if (match != null) {
        //  print('Extracted URL : ${match.group(3)}');
          requestType = match.group(1)?.toUpperCase() ?? match.group(2)?.toUpperCase() ?? '';
          url = match.group(3);
        } else {
       //   print('No URL found in: $curlCommand');
        }
      }

      if (url == null || url.contains('http')==false) {
        throw Exception('Invalid curl command: could not extract URL.');
      }

      final uri = Uri.parse(url);

      // Extract base URL (without query parameters)
      final baseUrl = uri.replace(query: '').toString();

      // Extract query parameters
      final queryParams = uri.queryParameters;





      // Extracting headers (-H or --header)
      RegExp headerPattern = RegExp(r"""--header\s+(["\'][^"\']*["\'])|-H\s+(["\'][^"\']*["\'])""");

      Iterable<Match> matches = headerPattern.allMatches(curlCommand);

      Map<String, String> headers = {};

      for (Match match in matches) {
        // Extract the header from either group 1 or group 2
        String? header = match.group(1) ?? match.group(2);

        if (header != null) {
          // Split header into key-value pair
          List<String> parts = header.split(': ');
          if (parts.length == 2) {
            if(parts[0].startsWith('"') || parts[0].startsWith("'")){
              parts[0]=parts[0].substring(1,parts[0].length);
            }
            if(parts[1].endsWith('"') || parts[1].endsWith("'")){
              parts[1]=parts[1].substring(0,parts[1].length-1);
            }
            headers[parts[0]] = parts[1]; // Add header to map
          }
        }
      }

      // Extracting data (-d or --data)
      String? data;
      dynamic jsonData;
      try{
        RegExp dataRegex = RegExp(r"""--data\s+(["\'][\s\S]+[^"\']*[\s\S]+["\'])|-d\s+(["\'][\s\S]+[^"\']*[\s\S]+["\'])""");
        data = dataRegex.allMatches(curlCommand).first.group(1) ?? dataRegex.allMatches(curlCommand).first.group(2);
      }
      catch(e) {
        print(e);
      }

      if(requestType!.isEmpty && data.runtimeType==Null){
        requestType='GET';
      }

      if(data.runtimeType!=Null && requestType.isEmpty ){
        requestType='POST';
      }

      if(data.runtimeType!=Null){

        if(data!.startsWith("'")||data.startsWith("'")){
          data=data.substring(1,data.length);
        }

        if(data.endsWith("'")||data.endsWith('"')){
          data=data.substring(0,data.length-1);
        }

        jsonData=jsonDecode(data);
      }




      urls?.add({'url':baseUrl,'queryParameter':queryParams,'data':jsonData,'requestType':requestType, 'headers':headers,"timeOut":apiTimeOut.value});
      print(urls);
    }catch(e){
      //print(e);
      Get.snackbar(e.toString(), '',
        maxWidth:Get.width/4,
          backgroundColor: Colors.black26,
          colorText: Colors.white,
          snackPosition:SnackPosition.BOTTOM,

      );
    }



  }



  void apiCallhttp(int i,int index,int j) async {
    dynamic apiData=urls?[i];
    //  print("aptData: $apiData");
    switch(apiData["requestType"]){
      case "GET":
        try{
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "apiIndex": (j + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );
          apiStartTime.value = DateTime.now().millisecondsSinceEpoch.toString();
          ApiRequestHttp(url: apiData["url"],queryParams: apiData["queryParameter"],apiTimeOut: apiData["timeOut"],headers: apiData["headers"]).get(
            onSuccess: (res) {
              String responseString = res.body.toString();
              apiEndTime.value = DateTime.now().millisecondsSinceEpoch.toString();
              totalDuration.value = int.parse(apiEndTime.value) - int.parse(apiStartTime.value);
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "apiIndex": (j + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": res.statusCode,
              };
              successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val) {
              String responseString = val.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err ,$val");
            },
          );
        }catch (e) {
          print('pp$e');
        }

        break;
      case "POST":
        try {
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );
          apiStartTime.value = DateTime.now().millisecondsSinceEpoch.toString();
           ApiRequest(url: apiData["url"],data: apiData["data"],apiTimeOut: apiData["timeOut"],headers: apiData["headers"]).post(
            onSuccess: (res) {
              String responseString = res.body.toString();
              apiEndTime.value = DateTime.now().millisecondsSinceEpoch.toString();
              totalDuration.value = int.parse(apiEndTime.value) - int.parse(apiStartTime.value);
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": res.statusCode,
              };
              successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val) {
              String responseString = val.toString();
              //print("=99${val.statusCode}");
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err");
            },
          );
        }catch (e) {
          print('$e');
        }
        break;
      case "PUT":
        try {
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );
          apiStartTime.value = DateTime.now().millisecondsSinceEpoch.toString();
           ApiRequest(url: apiData["url"],queryParams: apiData["queryParameter"],data: apiData["data"],apiTimeOut: apiData["timeOut"],headers: apiData["headers"]).put(
            onSuccess: (res) {
              String responseString = res.body.toString();
              apiEndTime.value = DateTime.now().millisecondsSinceEpoch.toString();
              totalDuration.value = int.parse(apiEndTime.value) - int.parse(apiStartTime.value);
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": res.statusCode,
              };
              successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val) {
              String responseString = val.toString();
              //  print("=99${val.statusCode}");
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err");
            },
          );
        }catch (e) {
          print('$e');
        }
        break;
      case "DELETE":
        try{
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );
          apiStartTime.value = DateTime.now().millisecondsSinceEpoch.toString();
           ApiRequest(url: apiData["url"],queryParams: apiData["queryParameter"],apiTimeOut: apiData["timeOut"], headers: apiData["headers"]).delete(
            onSuccess: (res) {
              String responseString = res.body.toString();
              apiEndTime.value = DateTime.now().millisecondsSinceEpoch.toString();
              totalDuration.value = int.parse(apiEndTime.value) - int.parse(apiStartTime.value);
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": res.statusCode,
              };
              successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val) {
              String responseString = val.toString();
              // print("=99${val.statusCode}");
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err");
            },
          );
        }catch (e) {
          print(e);
        }
        break;
      default:
        print('Invalid request type');
        break;
    }

  }



}


