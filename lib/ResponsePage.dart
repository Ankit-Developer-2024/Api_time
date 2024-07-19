import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_view/json_view.dart';
class ResponsePage extends StatelessWidget {
   ResponsePage({super.key,this.response,this.mp});
   dynamic response;
   dynamic mp;

    bool htmlHave=false;
    bool exception=false;
  @override
  Widget build(BuildContext context) {
    if(response.contains("<!DOCTYPE html>")){
      htmlHave=true;

    }else{
     try{
       response=jsonDecode(response);
     }catch(e){
       exception=true;
     }
    }

    return Scaffold(
      body:   Column(
        children: [
          Container(
            height: 100,
            width: Get.width,
            color: Colors.black,
            padding: EdgeInsets.only(left: 8,top: 5,bottom: 5,right: 5),
            child: ListView(
              children: [
                Text('URL: ${mp['url']}',style: const TextStyle(color: Colors.white,fontSize: 13)),
                mp['headers'].toString().length==2 ?const SizedBox() : Text("Headers: ${mp['headers'].toString()} ",style: const TextStyle(color: Colors.white,fontSize:13)),
                mp['queryParameter'].toString().length==2 ? const SizedBox() : Text("QueryParameter: ${mp['queryParameter'].toString()} ",style: const TextStyle(color: Colors.white,fontSize:13)),
                mp['data']==null ? const SizedBox() : Text("Data: ${mp['data'].toString()}",style: const TextStyle(color: Colors.white,fontSize: 13)),

              ],
            ),
          ),
          const SizedBox(height: 1,),
          Container(
            height: Get.height-105,
            width: Get.width,
            color: Colors.black,
            child:exception ? Text(response,style: const TextStyle(color: Colors.white,fontSize: 13))   :  response==null ? const Text('No response get' ,style: TextStyle(color: Colors.white),)
                :  htmlHave ? ListView(children:[Text(response,style: const TextStyle(color: Colors.white,fontSize: 13),)]) :JsonConfig(
                 data: JsonConfigData(
                 gap: 100,
                 style: const JsonStyleScheme(
                  quotation: JsonQuotation.same('"'),
                  // set this to true to open all nodes at start
                  // use with caution, it will cause performance issue when json items is too large
                  openAtStart: false,
                  arrow: Icon(Icons.arrow_forward),
                  // too large depth will cause performance issue
                  depth: 2,
                ),
                color: const JsonColorScheme(
                  stringColor: Colors.white
                ),
                ),
                child: JsonView(json: response),

            ),
          ),
        ],
      ),
    );
  }
}
