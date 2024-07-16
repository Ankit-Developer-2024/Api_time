import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_view/json_view.dart';
class ResponsePage extends StatelessWidget {
   ResponsePage({super.key,this.response});
   dynamic response;
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
      body:   Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
    );
  }
}
