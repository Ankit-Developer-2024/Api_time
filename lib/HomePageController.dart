import 'package:api_time/CommonUIComponent.dart';
import 'package:dio/dio.dart' as dio;

import 'dart:convert';

import 'package:api_time/ApiRequestDio.dart';
import 'package:api_time/ApiRequestHttp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HomePageController extends GetxController {

  TextEditingController urlController=TextEditingController();
  TextEditingController headersController = TextEditingController();
  TextEditingController queryParamsController = TextEditingController();
  TextEditingController bodyController = TextEditingController();


  TextEditingController cURLController = TextEditingController();
  TextEditingController timeOutController = TextEditingController(text: '30000');
  TextEditingController apiCallCountController = TextEditingController(
      text: '1');
  TextEditingController apiIntervalController = TextEditingController(
      text: '0');

  RxBool headerError=false.obs;
  RxBool queryParamsError=false.obs;
  RxBool bodyError=false.obs;

  RxBool cURLError=true.obs;
  RxBool postRequestError=false.obs;
  RxBool putRequestError=false.obs;
  RxBool putPostHeaderError=false.obs;


  List<String> requestMethod=['Dio','Http'];
  List<String> requestType=['GET','POST','DELETE','PUT'];


  RxList cURL = [].obs;
  RxString token = ''.obs;
  RxInt apiTimeOut = 30000.obs;
  RxString apiMethod="Dio".obs;
  RxString apiRequestType="GET".obs;
  RxString apiBodyType = ''.obs;
  RxString extractData='cURL'.obs;

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

  void setDataByCurl() {
    if (cURLController.text.isNotEmpty) {
      cURL.value = cURLController.text
          .replaceAll(']', "")
          .replaceAll('[', "")
          .split('@@%')
          .map((item) => item.trim())
          .toList();
           print('in setData  as list:  $cURL');
    }


    for (int i = 0; i <cURL.length;i++){
        callApiFromCurl(cURL[i]);
       }

  }

  void setDataByUrl(){
    final queryParams = parseQueryParams(queryParamsController.text);
    final headers = parseHeaders(headersController.text);
    bodyError.value =false;
    final body = bodyController.text;
    dynamic jsonBody ;
    if(body.isNotEmpty){
        try{
          jsonBody= json.decode(body);
          bodyError.value =false;
        }
        catch(e){
          bodyError.value =true;
          CommonUiComponent().snackBar(firstTitle:'Body Must be { key:value } and key Must be String ' , secondTitle: e.toString(),maxWidth: Get.width/2,durationMilliseconds: 2000);
        }
    }

    if(apiRequestType.value=='POST'){
      if(apiBodyType.value.isEmpty){
        CommonUiComponent().snackBar(firstTitle: 'API Body Type is required', secondTitle: '', durationMilliseconds: 2000);
        return;
      }
    }

    if(queryParamsError.value==false&&headerError.value==false&&bodyError.value==false){

      urls?.add({'url':urlController.text,'queryParameter':queryParams,'data':jsonBody,'bodyType':apiBodyType.value , 'requestType':apiRequestType.value, 'headers':headers,"extractData":extractData.value});
      Get.back();
      urlController.text='';
      headersController.text='';
      queryParamsController.text='';
      bodyController.text='';

    }else{

    }



  }

  Map<String, dynamic> parseQueryParams(String queryParamsString) {
    try{
      if (queryParamsString.isEmpty) return {};
      final queryParams = queryParamsString.split('\n').map((item) => item.split('=')).map((pair) => MapEntry(pair[0], pair[1])).toList();
      queryParamsError.value=false;
      return Map.fromEntries(queryParams);
    }catch(e){
      queryParamsError.value=true;
      CommonUiComponent().snackBar(firstTitle: 'Param Must be key=value' , secondTitle: e.toString(),maxWidth: Get.width/2 ,durationMilliseconds: 2000);
      return {};
    }
  }

  Map<String, String> parseHeaders(String headersString) {
     try{
       if (headersString.isEmpty) return {};
       final headers = headersString.split('\n').map((item) => item.split(':')).map((pair) => MapEntry(pair[0], pair[1])).toList();
       headerError.value=false;
       return Map.fromEntries(headers);
     }catch(e){
       headerError.value=true;
       CommonUiComponent().snackBar(firstTitle: 'Headers Must key: value', secondTitle:  e.toString() ,maxWidth: Get.width/2 ,durationMilliseconds: 2000);
       return {};
     }
  }



  void startCallingApi() async {
    int index=0;
    for (int j = 0; j < apiCallCount.value; j++) {
      for (int i = 0; i < urls!.length; i++) {
        apiMethod.value=='Dio' ? apiCallDio(i,index,j): apiCallHttp(i,index,j);
        index++;
      }
      await Future.delayed(Duration(milliseconds: apiInterval.value));
    }
  }


  void apiCallDio(int i,int index,int j) async {
    dynamic apiData=urls?[i];

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

           ApiRequestDio(url: apiData["url"],queryParams: apiData["queryParameter"],apiTimeOut: apiTimeOut.value,headers: apiData["headers"],apiStartTime: apiStartTime.value,apiEndTime: apiEndTime.value).get(
            onSuccess: (res,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = res.toString();
               apiDetails?[index]={
                 "urlNumber": (i + 1).toString(),
                 "apiIndex": (j + 1).toString(),
                 "url": apiData['url'],
                 "requestType":apiData['requestType'],
                 "startTime": apiStartTime,
                 "endTime": apiEndTime,
                 "duration": totalDuration.value,
                 "resBody": responseString,
                 "statusCode": res.statusCode,
               };
               successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val,apiStartTime,apiEndTime) {
              print('api Error$apiEndTime $apiEndTime ');
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = val.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err ,$val");
            },
          );
        }catch (e) {
          CommonUiComponent().snackBar(firstTitle: e.toString(), secondTitle: '');
          print('$e');
        }

        break;
      case "POST":
        try {
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );
          dynamic finalData= apiData['extractData']=='cURL'? apiData["data"] :  apiData['bodyType']=='JSON'? apiData["data"]  : dio.FormData.fromMap(apiData["data"]);
          finalData= apiData['extractData']=='cURL'? apiData['bodyType']=='JSON'? finalData : dio.FormData.fromMap(apiData["data"]) : finalData;
          print("final--$finalData ---");


           ApiRequestDio(url: apiData["url"],data: finalData,apiTimeOut: apiTimeOut.value,headers: apiData["headers"],apiStartTime: apiStartTime.value,apiEndTime: apiEndTime.value).post(
            onSuccess: (res,apiStartTime,apiEndTime) {
            totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
            String responseString = res.toString();
            apiDetails?[index]={
              "urlNumber": (i + 1).toString(),
              "url": apiData['url'],
              "apiIndex": (j + 1).toString(),
              "requestType":apiData['requestType'],
              "startTime": apiStartTime,
              "endTime": apiEndTime,
              "duration": totalDuration.value,
              "resBody": responseString,
              "statusCode": res.statusCode,
            };
            successRequest.value+=1;
            print('api Success');
          },
            onError: (err,val,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = val.toString();
              //print("=99${val.statusCode}");
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("------$err");
            },
          );
        }catch (e) {
          CommonUiComponent().snackBar(firstTitle: e.toString(), secondTitle: '');
          print('$e');
        }
        break;
      case "PUT":
      try {
        apiDetails?.add(
            {
              "urlNumber": (i + 1).toString(),
              "url": apiData['url'],
              "apiIndex": (j + 1).toString(),
              "requestType":apiData['requestType'],
              "startTime": apiStartTime.value,
              "endTime": apiEndTime.value,
              "duration": "Loader",
              "resBody": "Loader",
              "statusCode": "Loader"
            }
        );

        dynamic finalData ;
        if( apiData['data'] == null ){
           print("----data is null--");
        }else{
          finalData= apiData['extractData']=='cURL'? apiData["data"] :  apiData['bodyType']=='JSON'? apiData["data"]  : dio.FormData.fromMap(apiData["data"]);
          finalData= apiData['extractData']=='cURL'? apiData['bodyType']=='JSON'? finalData : dio.FormData.fromMap(apiData["data"]) : finalData;
          print("final--$finalData ---");
        }


         ApiRequestDio(url: apiData["url"],queryParams: apiData["queryParameter"],data: apiData["data"],apiTimeOut: apiTimeOut.value,headers: apiData["headers"],apiStartTime: apiStartTime.value,apiEndTime: apiEndTime.value).put(
          onSuccess: (res,apiStartTime,apiEndTime) {
            totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
            String responseString = res.toString();
            apiDetails?[index]={
              "urlNumber": (i + 1).toString(),
              "url": apiData['url'],
              "apiIndex": (j + 1).toString(),
              "requestType":apiData['requestType'],
              "startTime": apiStartTime,
              "endTime": apiEndTime,
              "duration": totalDuration.value,
              "resBody": responseString,
              "statusCode": res.statusCode,
            };
            successRequest.value+=1;
            print('api Success');
          },
          onError: (err,val,apiStartTime,apiEndTime) {
            totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
            String responseString = val.toString();
          //  print("=99${val.statusCode}");
            apiDetails?[index]={
              "urlNumber": (i + 1).toString(),
              "url": apiData['url'],
              "apiIndex": (j + 1).toString(),
              "requestType":apiData['requestType'],
              "startTime": apiStartTime,
              "endTime": apiEndTime,
              "duration": totalDuration.value,
              "resBody": responseString,
              "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
            };
            failedRequest.value+=1;
            print("-----$err");
          },
        );
       }catch (e) {
        CommonUiComponent().snackBar(firstTitle: e.toString(), secondTitle: '');
        print('$e');
       }
        break;
      case "DELETE":
         try{
           apiDetails?.add(
               {
                 "urlNumber": (i + 1).toString(),
                 "url": apiData['url'],
                 "apiIndex": (j + 1).toString(),
                 "requestType":apiData['requestType'],
                 "startTime": apiStartTime.value,
                 "endTime": apiEndTime.value,
                 "duration": "Loader",
                 "resBody": "Loader",
                 "statusCode": "Loader"
               }
           );

            ApiRequestDio(url: apiData["url"],queryParams: apiData["queryParameter"],apiTimeOut: apiTimeOut.value, headers: apiData["headers"],apiStartTime: apiStartTime.value,apiEndTime: apiEndTime.value).delete(
             onSuccess: (res,apiStartTime,apiEndTime) {
               totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
               String responseString = res.toString();
               apiDetails?[index]={
                 "urlNumber": (i + 1).toString(),
                 "url": apiData['url'],
                 "apiIndex": (j + 1).toString(),
                 "requestType":apiData['requestType'],
                 "startTime": apiStartTime,
                 "endTime": apiEndTime,
                 "duration": totalDuration.value,
                 "resBody": responseString,
                 "statusCode": res.statusCode,
               };
               successRequest.value+=1;
               print('api Success');
             },
             onError: (err,val,apiStartTime,apiEndTime) {
               totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
               String responseString = val.toString();
               apiDetails?[index]={
                 "urlNumber": (i + 1).toString(),
                 "url": apiData['url'],
                 "apiIndex": (j + 1).toString(),
                 "requestType":apiData['requestType'],
                 "startTime": apiStartTime,
                 "endTime": apiEndTime,
                 "duration": totalDuration.value,
                 "resBody": responseString,
                 "statusCode": err=="Response error" ? val.statusCode.toString() : err.toString(),
               };
               failedRequest.value+=1;
               print("-----$err");
             },
           );
         }catch (e) {
           CommonUiComponent().snackBar(firstTitle: e.toString(), secondTitle: '');
          print(e);
         }
        break;
        default:
          CommonUiComponent().snackBar(firstTitle: 'Invalid request type', secondTitle: '');
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


      RegExp dataRegex = RegExp(r"""(--form|-F)\s+(['"])([\s\S]*?)\2""");
      Iterable<RegExpMatch> matchesForm = dataRegex.allMatches(curlCommand);

      Map<String, dynamic> dataMap = {};
     // dynamic formData;
      for (var match in matchesForm) {

        String? data = match.group(3);
        if (data != null) {
          if (match.group(1) == '--form' || match.group(1) == '-F') {
            var keyValue = data.split('=');
            if (keyValue.length == 2) {
              String key = keyValue[0];
              String value = keyValue[1];
              dataMap[key] = value.replaceAll('"', '').replaceAll(
                  "'", ''); // Remove enclosing quotes
            }
          }
        }
        }


      // Extracting data (-d or --data)
      String? data;
      dynamic jsonData;
      String? dataType;
      try{
        RegExp dataRegex = RegExp(r"""--data\s+(["\'][\s\S]+[^"\']*[\s\S]+["\'])|-d\s+(["\'][\s\S]+[^"\']*[\s\S]+["\'])""");
        data = dataRegex.allMatches(curlCommand).first.group(1) ?? dataRegex.allMatches(curlCommand).first.group(2);

      }
      catch(e) {
        print(e);
      }

      if(requestType!.isEmpty && data.runtimeType==Null && dataMap.isEmpty){
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
        dataType='JSON';
      }



      if(dataMap.isNotEmpty && requestType.isEmpty ){
        requestType='POST';
      }

      if(dataMap.isNotEmpty){
        jsonData=dataMap;
        dataType='Form-Data';
      }


     // print("type- jsonData ${jsonData.runtimeType}");




      urls?.add({'url':baseUrl,'queryParameter':queryParams,'data':jsonData,"bodyType":dataType ,'requestType':requestType, 'headers':headers,"extractData":extractData.value});
      cURLController.clear();
      Get.back();
      print(urls);

    }catch(e) {
      //print(e);
      CommonUiComponent().snackBar(firstTitle: 'Please give valid Curl ', secondTitle: curlCommand,maxWidth: Get.width/2  ,durationMilliseconds: 1000);


    }



  }



  void apiCallHttp(int i,int index,int j) async {
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

          ApiRequestHttp(url: apiData["url"],queryParams: apiData["queryParameter"],apiTimeOut: apiTimeOut.value,headers: apiData["headers"],apiStartTime: apiStartTime.value,apiEndTime: apiEndTime.value).get(
            onSuccess: (res,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = res.body.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "apiIndex": (j + 1).toString(),
                "url": apiData['url'],
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": res.statusCode,
              };
              successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = err.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode":  val is int ? val.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err ,$val");
            },
          );
        }catch (e) {
          CommonUiComponent().snackBar(firstTitle: e.toString(), secondTitle: '');
          print('pp$e');
        }

        break;
      case "POST":
        try {
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );
          dynamic finalData= apiData['extractData']=='cURL'? apiData['bodyType']=='JSON'? apiData["data"]  :  dio.FormData.fromMap(apiData["data"]) :  apiData['bodyType']=='JSON'? apiData["data"]  :  dio.FormData.fromMap(apiData["data"]);
          print('final1:--$finalData  ---${json.runtimeType}  ');

          finalData = finalData.runtimeType==dio.FormData  ? Map.fromEntries(finalData.fields) : jsonEncode(finalData);

          print('final2:--$finalData');
          if(finalData.runtimeType==String){
            finalData= jsonDecode(finalData);
            finalData=finalData.map((key,value)=>MapEntry(key, value.toString()));
            finalData =jsonEncode(finalData);
          }
          print(finalData);


           ApiRequestHttp(url: apiData["url"],data:finalData ,apiTimeOut:apiTimeOut.value,headers: apiData["headers"],apiStartTime: apiStartTime.value,apiEndTime: apiEndTime.value).post(
            onSuccess: (res,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = res.body.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": res.statusCode,
              };
              successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = err.toString();
              //print("=99${val.statusCode}");
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": val is int ? val.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err");
            },
          );
        }catch (e) {
          CommonUiComponent().snackBar(firstTitle: e.toString(), secondTitle: '');
          print('$e');
        }
        break;
      case "PUT":
        try {
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );
          if(apiData['data'] == null){
            print('---data is null');
          }else{
            dynamic finalData= apiData['extractData']=='cURL'? apiData['bodyType']=='JSON'? apiData["data"]  :  dio.FormData.fromMap(apiData["data"]) :  apiData['bodyType']=='JSON'? apiData["data"]  :  dio.FormData.fromMap(apiData["data"]);
            print('final1:--$finalData  ---${json.runtimeType}  ');

            finalData = finalData.runtimeType==dio.FormData  ? Map.fromEntries(finalData.fields) : jsonEncode(finalData);

            print('final2:--$finalData');
            if(finalData.runtimeType==String){
              finalData= jsonDecode(finalData);
              finalData=finalData.map((key,value)=>MapEntry(key, value.toString()));
              finalData =jsonEncode(finalData);
            }
            print(finalData);
          }

           ApiRequestHttp(url: apiData["url"],queryParams: apiData["queryParameter"],data: apiData["data"],apiTimeOut: apiTimeOut.value,headers: apiData["headers"],apiStartTime: apiStartTime.value,apiEndTime: apiEndTime.value).put(
            onSuccess: (res,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = res.body.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": res.statusCode,
              };
              successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = err.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": val is int ? val.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err");
            },
          );
        }catch (e) {
          print('$e');
          CommonUiComponent().snackBar(firstTitle: e.toString(), secondTitle: '');
        }
        break;
      case "DELETE":
        try{
          apiDetails?.add(
              {
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime.value,
                "endTime": apiEndTime.value,
                "duration": "Loader",
                "resBody": "Loader",
                "statusCode": "Loader"
              }
          );

           ApiRequestHttp(url: apiData["url"],queryParams: apiData["queryParameter"],apiTimeOut: apiTimeOut.value, headers: apiData["headers"],apiStartTime: apiStartTime.value,apiEndTime: apiEndTime.value).delete(
            onSuccess: (res,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = res.body.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": res.statusCode,
              };
              successRequest.value+=1;
              print('api Success');
            },
            onError: (err,val,apiStartTime,apiEndTime) {
              totalDuration.value = int.parse(apiEndTime) - int.parse(apiStartTime);
              String responseString = err.toString();
              apiDetails?[index]={
                "urlNumber": (i + 1).toString(),
                "url": apiData['url'],
                "apiIndex": (j + 1).toString(),
                "requestType":apiData['requestType'],
                "startTime": apiStartTime,
                "endTime": apiEndTime,
                "duration": totalDuration.value,
                "resBody": responseString,
                "statusCode": val is int ? val.toString() : err.toString(),
              };
              failedRequest.value+=1;
              print("-----$err");
            },
          );
        }catch (e) {
          CommonUiComponent().snackBar(firstTitle: e.toString(), secondTitle: '');
          print('$e');
        }
        break;
      default:
        CommonUiComponent().snackBar(firstTitle: 'Invalid request type', secondTitle: '');
        break;
    }

  }



}


