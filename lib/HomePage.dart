

import 'package:api_time/HomePageController.dart';
import 'package:api_time/ResponsePage.dart';
import 'package:api_time/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  HomePageController controller=Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SizedBox(
         height: double.infinity,
         child: Row(
           children: [
             //Left side api
             leftSideApi(controller,context),

             const SizedBox(width: 5,),
             //Right side  details
             rightSideApiDetails(controller,context),

           ],
         ),
       ),
     );
  }
}


 Widget leftSideApi(HomePageController controller,BuildContext context){

  return Expanded(
       flex: 2,
       child: Obx(() {
         return Container(
           color: Colors.white,
           padding: const EdgeInsets.only(right: 5,left: 5),
           child: Container(
             color: const Color.fromRGBO(211, 211, 211, 1),
             child: Column(
               children: [
                 Row(
                   children: [
                     Container(
                       height: 38,
                       padding: const EdgeInsets.only(left:5),
                       color: Colors.blue,
                       child: DropdownButtonHideUnderline(
                         child: DropdownButton(
                           value:controller.apiMethod.value,
                           style: const TextStyle(fontSize: 20),
                           dropdownColor: Colors.grey,
                           iconEnabledColor: Colors.white,
                           items:controller.requestMethod.map((String val) {
                             return DropdownMenuItem<String>(
                               value: val,
                               child: Text(val,style: const TextStyle(color: Colors.white,fontSize: 13)),
                             );
                           }).toList(),
                           isDense: true,
                           padding: const EdgeInsets.only(left: 5),
                           onChanged: (val){
                             controller.apiMethod.value=val!;
                             print(controller.apiMethod.value);
                           },),
                       )
                     ),
                     const SizedBox(width: 5,),
                     ConstrainedBox(
                       constraints: const BoxConstraints(minWidth:65,maxWidth:100 ,minHeight: 40),
                       child: AppUtils().button(btnName: 'Add cURL/URL', onTap: (){
                         showDialog(context: context, builder: (context) {
                           return AlertDialog(
                             scrollable:true ,
                             title: const Text('Choose cURL or Api Detail',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20)),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),),
                             titlePadding: const EdgeInsets.only(top: 10),
                             contentPadding: const EdgeInsets.all(10),
                             content: Obx((){
                               return Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.start,

                                       children: [
                                         Expanded(child:  InkWell(
                                           onTap: () {
                                             controller.extractData.value='cURL';
                                           },
                                           child: Container(
                                             alignment: Alignment.center,
                                             decoration: BoxDecoration(
                                               borderRadius: const BorderRadius.only(topRight: Radius.circular(2),topLeft: Radius.circular(2)),
                                               border: BorderDirectional(
                                                   top: const BorderSide(color: Colors.grey,width: 1,),
                                                   end:const BorderSide(color: Colors.grey,width: 1),
                                                   start: const BorderSide(color: Colors.grey,width: 1),
                                                   bottom:  controller.extractData.value=='cURL' ?  const BorderSide(color: Colors.grey,width: 0): const BorderSide(color: Colors.grey,width: 1)
                                               ),
                                             ),
                                             child: const Padding(
                                               padding: EdgeInsets.all(12.0),
                                               child: Text(
                                                 'cURL',
                                                 style: TextStyle(color: Colors.black, fontSize: 13,),
                                               ),
                                             ),
                                           ),
                                         )),
                                         Expanded(child:  InkWell(
                                           onTap: () {
                                             controller.extractData.value='URL';
                                           },
                                           child: Container(
                                             alignment: Alignment.center,
                                             decoration: BoxDecoration(
                                               borderRadius:  const BorderRadius.only(topRight: Radius.circular(2),topLeft: Radius.circular(2)),
                                               border: BorderDirectional(
                                                   top: const BorderSide(color: Colors.grey,width: 1),
                                                   end:const BorderSide(color: Colors.grey,width: 1),
                                                   start: const BorderSide(color: Colors.grey,width: 1),
                                                   bottom:  controller.extractData.value=='URL' ?  const BorderSide(color: Colors.grey,width: 0): const BorderSide(color: Colors.grey,width: 1)
                                               ),
                                             ),
                                             child: const Padding(
                                               padding: EdgeInsets.all(12.0),
                                               child: Text(
                                                 'Api Detail',
                                                 style: TextStyle(color: Colors.black, fontSize: 13,),
                                               ),
                                             ),
                                           ),
                                         )),

                                       ]
                                   ),
                                   const SizedBox(height: 10,),
                                    controller.extractData.value=='URL'? addUrl(controller,context): addCurl(controller,context),
                                 ],
                               );
                             })

                           );
                         },);
                       })

                     ),
                     const SizedBox(width: 5,),
                     ConstrainedBox(
                       constraints: const BoxConstraints(minWidth:50,maxWidth:100 ,minHeight: 40),
                       child:AppUtils().button(btnName: 'Clear', onTap: (){
                         controller.urls?.clear();
                         controller.apiDetails?.clear();
                       })

                     ),

                   ],
                 ),
                 const SizedBox(height: 3,),
                 Container(
                   color: Colors.grey,
                   height: MediaQuery.sizeOf(context).height-105,
                   child: controller.urls == null ? Container() :   ListView.builder(
                       scrollDirection: Axis.vertical,
                       itemCount: controller.urls?.length,
                       itemBuilder: (context,index){
                         dynamic mp=controller.urls![index];
                         return Card(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(2),
                           ),
                           child: ListTile(
                             leading: Text((index+1).toString(),style: const TextStyle(color: Colors.black,fontSize: 12),),
                             title: Text(mp['url'],style: const TextStyle(color: Colors.black,fontSize: 12)),
                             subtitle:Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 mp['queryParameter'].toString().length==2 ? const SizedBox() : Text("QueryParameter: ${mp['queryParameter'].toString()} ",style: const TextStyle()),
                                 mp['data']==null ? const SizedBox() : Text("Data: ${mp['data'].toString()}",style: const TextStyle())

                             ],)
                           ),
                         );
                       }),
                 ),
                 const SizedBox(height: 10,),
                 Row(
                   children: [
                     Expanded(
                       flex: 1,
                         child:  TextField(
                           controller: controller.apiCallCountController,
                           style: const TextStyle(color: Colors.black,fontSize: 10),
                           decoration: const InputDecoration(
                             labelText: "Api count ",
                             labelStyle: TextStyle(color: Colors.black,fontSize: 13),
                             focusColor: Colors.black,
                             enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.black,width: 1),
                               borderRadius: BorderRadius.all(Radius.circular(1)),

                             ),
                             focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.black,width: 1),
                               borderRadius: BorderRadius.all(Radius.circular(1)),
                             ),
                             isDense: true,
                           ),
                           onChanged: (value){
                             if(value.isNotEmpty){
                               controller.apiCallCount.value=int.parse(value);
                             }
                           },
                         ),
                     ),
                     const SizedBox(width: 3,),
                     Expanded(
                       flex: 1,
                       child: TextField(
                       controller: controller.timeOutController,
                       style: const TextStyle(color: Colors.black,fontSize: 10),
                       decoration: const InputDecoration(
                         labelText: "Api timeout(millisec)",
                         labelStyle: TextStyle(color: Colors.black,fontSize: 13),
                         focusColor: Colors.black,
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.black,width: 1),
                           borderRadius: BorderRadius.all(Radius.circular(1)),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.black,width: 1),
                           borderRadius: BorderRadius.all(Radius.circular(1)),
                         ),
                         isDense: true,
                       ),
                     ),),
                     const SizedBox(width: 3,),
                     Expanded(
                       flex: 1,
                       child: TextField(
                       controller: controller.apiIntervalController,
                       style: const TextStyle(color: Colors.black,fontSize: 10),
                       decoration: const InputDecoration(
                         labelText: "Interval (millisec)",
                         labelStyle: TextStyle(color: Colors.black,fontSize: 13),
                         focusColor: Colors.black,
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.black,width: 1),
                           borderRadius: BorderRadius.all(Radius.circular(1)),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.black,width: 1),
                           borderRadius: BorderRadius.all(Radius.circular(1)),
                         ),
                         isDense: true,
                       ),
                       onChanged: (value){
                         if(value.isNotEmpty){
                           controller.apiInterval.value=int.parse(value);
                         }
                       },

                     ),),
                     const SizedBox(width: 3,),
                     Expanded(
                         flex: 1,
                         child: ConstrainedBox(
                           constraints: const BoxConstraints(minHeight: 40),
                           child: OutlinedButton(

                           onPressed: () async {



                             controller.apiDetails?.clear();
                             controller.successRequest.value=0;
                             controller.failedRequest.value=0;
                             if(controller.urls!= null && controller.urls!.isNotEmpty){
                               controller.api();
                             }
                             else{

                               AppUtils().snackBar(firstTitle: 'Please add at least one cURL or URL', secondTitle: "");

                             }
                           },
                           style: OutlinedButton.styleFrom(
                             backgroundColor: Colors.blue,
                             side: const BorderSide(color: Colors.white, width: 0.5), // Border color and width
                             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Padding inside the button
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(2), // Rounded corners
                             ),
                           ),
                           child: const Text("Submit",style: TextStyle(color: Colors.white,fontSize: 13),)),
                         )
                     )
                   ],
                 ),

               ],
             ),
           ),
         );
       })
   );

 }









Widget rightSideApiDetails(HomePageController controller,BuildContext context){
  return  Expanded(
    flex: 4,
    child:  Obx(() {
      return Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.black, width: 0), // Border color and width
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Padding inside the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2), // Rounded corners
                        ),
                      ),
                      child: Text('Total Request: ${controller.apiDetails!.length.toString()}',style: const TextStyle(color: Colors.white,fontSize: 13),),
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          side: const BorderSide(color: Colors.black, width: 0), // Border color and width
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Padding inside the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2), // Rounded corners
                          ),
                        ),
                        child: Text('Success Request: ${controller.successRequest.value}',style: const TextStyle(color: Colors.white,fontSize: 13))),
                    ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          side: const BorderSide(color: Colors.black, width: 0), // Border color and width
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Padding inside the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2), // Rounded corners
                          ),
                        ),
                        child: Text('Failed Request: ${controller.failedRequest.value}',style: const TextStyle(color: Colors.white,fontSize: 13))),
                    ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          side: const BorderSide(color: Colors.black, width: 0), // Border color and width
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Padding inside the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2), // Rounded corners
                          ),
                        ),
                        child: Text('Completed Request: ${controller.successRequest.value+controller.failedRequest.value}',style: const TextStyle(color: Colors.white,fontSize: 13))),
                  ],
                ),
                ElevatedButton(onPressed: (){
                  controller.apiDetails?.clear();
                  controller.successRequest.value=0;
                  controller.failedRequest.value=0;
                },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.black, width: 0), // Border color and width
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Padding inside the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2), // Rounded corners
                      ),
                    ),
                    child: const Text('Clear',style: TextStyle(color: Colors.white,fontSize: 13))),
              ],
            ),
            controller.apiDetails == null ? Container() : SizedBox(
              height: MediaQuery.sizeOf(context).height-35,
              child: ListView.builder(
                  itemCount: controller.apiDetails?.length,
                  itemBuilder: (context,index){
                    dynamic mp=controller.apiDetails![index];
                    dynamic input=controller.urls?[int.parse(mp['urlNumber'])-1];
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(3),
                      decoration:BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(2.0), // Uniform radius
                      ),
                      child: Column(

                        children: [
                          Row(
                            mainAxisAlignment:  MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Index: ${mp['urlNumber']} | Api Index: ${mp['apiIndex']} |',style: const TextStyle(color: Colors.white,fontSize: 13),),
                              Text('RequestType: ${mp['requestType']} | ',style: const TextStyle(color: Colors.white,fontSize: 13),),
                              Row(
                                children: [
                                  const Text('Total Time: ',style: TextStyle(color: Colors.white,fontSize: 13),),
                                  mp['duration']=='Loader' ?
                                     Container(
                                      width: 10,
                                      height: 10,
                                      margin: const EdgeInsets.only(top:4,left: 4),
                                      child: const CircularProgressIndicator(strokeWidth: 2,))
                                      :Text('${mp['duration']} millisec',style: const TextStyle(color: Colors.white,fontSize: 13),),
                                      const Text(' | ',style: TextStyle(color: Colors.white,fontSize: 13),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Status: ",style: TextStyle(color: mp['statusCode']=='Loader' ? Colors.white : mp['statusCode']==200 ? Colors.green : mp['statusCode']==201 ? Colors.green  : Colors.red,fontSize: 13)),
                                  mp['statusCode']=='Loader' ?
                                      Container(
                                      width: 10,
                                      height: 10,
                                      margin: const EdgeInsets.only(top:4,left: 4),
                                      child: const CircularProgressIndicator(strokeWidth: 2,))
                                      :Text('${mp['statusCode']} ',style: TextStyle(color: mp['statusCode']==200 ? Colors.green : mp['statusCode']==201 ? Colors.green : Colors.red,fontSize: 13,),),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment:  MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('URL: ${mp['url']}',style: const TextStyle(color: Colors.white,fontSize: 13),),
                              const SizedBox(width: 5,),
                              GestureDetector(
                                  onTap: (){

                                    mp['resBody']=='Loader' ? AppUtils().snackBar(firstTitle:'Try to Fetch data',secondTitle: '' )
                                                            : Get.to(duration: const Duration(seconds: 1), ResponsePage(response:mp['resBody'],mp: input,));
                                  },
                                  child:  mp['resBody']=='Loader' ?
                                                      Container(
                                                          width: 10,
                                                          height: 10,
                                                          margin: const EdgeInsets.only(top:4,left: 4),
                                                          child: const CircularProgressIndicator(strokeWidth: 2,))
                                                      :  const Text('View Response ',style: TextStyle(fontSize: 13,color: Colors.blue)),
                              ),

                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),

          ],
        ),
      );
    }),
  );
}






Widget addCurl(HomePageController controller,BuildContext context){

  return Obx(() {
    return Column(
      children: [
        SizedBox(
          width: Get.width/3,
          child: TextField(
            controller: controller.cURLController,
            minLines: 10,
            maxLines: 10,
            style: const TextStyle(color: Colors.black,fontSize: 10),
            decoration: const InputDecoration(
              labelText: "Your cURL here ",
              hintText: "More than one cURL must be separated by @@%",
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: Colors.black,fontSize: 13),
              focusColor: Colors.black,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black,width: 1),
                borderRadius: BorderRadius.all(Radius.circular(1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black,width: 1),
                borderRadius: BorderRadius.all(Radius.circular(1)),
              ),
              isDense: true,
            ),
            onChanged: (val){
              if (val.isNotEmpty){
                controller.cURLError.value=false;
              }
            },

          ),
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppUtils().button(btnName: 'Add' ,bgColor:   controller.cURLError.value ? Colors.grey : Colors.blue ,  onTap: (){

              if(controller.cURLController.text.isNotEmpty ){
                controller.setData();
              }else{
                controller.cURLError.value=true;
              }

            }),
            const SizedBox(width: 5,),
            AppUtils().button(btnName: 'Close'  ,  onTap: (){
              Navigator.pop(context);
            })
          ],)
      ],
    );
  });

}




Widget addUrl(HomePageController controller,BuildContext context){
  dynamic formKey = GlobalKey<FormState>();
  return Obx(() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width/3+30,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Request Type:',style: TextStyle(fontSize: 13,color: Colors.black),),
                      const SizedBox(width: 5,),
                      Container(
                        color: Colors.grey,
                        child: DropdownButton(
                          value:controller.apiRequestType.value,
                          items:controller.requestType.map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val,style: const TextStyle(color: Colors.black,fontSize: 13)),
                            );
                          }).toList(),
                          isDense: true,
                          padding: const EdgeInsets.only(left: 5),
                          onChanged: (val){
                            controller.apiRequestType.value=val!;
                            controller.apiBodyType.value='';
                            controller.urlController.clear();
                            controller.headersController.clear();
                            controller.queryParamsController.clear();
                            controller.bodyController.clear();
                          },),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  TextFormField(
                    controller: controller.urlController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(color: Colors.black,fontSize: 10),
                    decoration:  const InputDecoration(
                      labelText: 'URL',
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: Colors.black,fontSize: 13),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      errorBorder:OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      isDense: true,
                    ),
                    validator: (val){
                      if(val!.isEmpty || !val.startsWith('http') ){
                        return 'Please give proper URL';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5,),
                  TextFormField(
                    controller: controller.headersController,
                    autovalidateMode: AutovalidateMode.always,
                    minLines: 3,
                    maxLines: 5,
                    style: const TextStyle(color: Colors.black,fontSize: 10),
                    decoration:  const InputDecoration(
                      labelText: 'Header',
                      hintText: "Please give header \nkey: value\nkey2: value2",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: Colors.black,fontSize: 13),
                      focusColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      errorBorder:OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      isDense: true,
                    ),
                    validator: (val){
                      if(val!.isNotEmpty){
                        if((controller.apiBodyType.value=="JSON"&&!val.contains('Content-Type: application/json'))||(controller.apiBodyType.value=="JSON"&&val.isEmpty)) {
                          return "Your body is JSON ,So you also need to give  Content-Type: application/json  header";
                        }
                      }
                      return null;
                    },
                    onChanged: (val){
                      if(val.contains('Content-Type: application/json')){
                        controller.putPostHeaderError.value=false;
                      }
                    },
                  ),
                  const SizedBox(height: 5,),
                controller.putPostHeaderError.value ? const Text("Your body is JSON ,So you also need to give  Content-Type: application/json  header",style: TextStyle(color: Colors.red,fontSize: 13),)  : const SizedBox(),
                  controller.apiRequestType.value=='POST' ?  Container() :  TextFormField(
                    controller: controller.queryParamsController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(color: Colors.black,fontSize: 10),
                    minLines: 3,
                    maxLines: 5,
                    decoration:  const InputDecoration(
                      labelText: 'Query Parameters',
                      hintText: "Please give Query Parameters \nkey=value\nkey2=value2",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: Colors.black,fontSize: 13),
                      focusColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      isDense: true,
                    ),
                      onChanged: (val){
                        if(val.isNotEmpty){
                          controller.putRequestError.value=false;
                        }
                      }
                  ),
                  const SizedBox(height: 5,),
                  controller.apiRequestType.value=='GET'|| controller.apiRequestType.value=='DELETE' ? Container(): Row(children: [
                    AppUtils().button(btnName: 'Form-Data', textColor: controller.apiBodyType.value=='Form-Data'? Colors.white  : Colors.black , bgColor:controller.apiBodyType.value=='Form-Data'? Colors.green  : Colors.transparent ,borderColor:controller.apiBodyType.value=='Form-Data'? Colors.white : Colors.black,onTap: (){
                      controller.apiBodyType.value='Form-Data';
                      controller.postRequestError.value=false;
                      controller.putRequestError.value=false;
                      controller.putPostHeaderError.value=false;
                    }),
                    const SizedBox(width: 5,),
                    AppUtils().button(btnName: 'JSON', textColor: controller.apiBodyType.value=='JSON'? Colors.white  : Colors.black,bgColor:controller.apiBodyType.value=='JSON'? Colors.green  : Colors.transparent ,borderColor: controller.apiBodyType.value=='JSON'? Colors.white : Colors.black,  onTap: (){
                      controller.apiBodyType.value='JSON';
                      controller.postRequestError.value=false;
                      controller.putRequestError.value=false;
                    })
                  ],),
                  const SizedBox(height: 5,),
                  controller.postRequestError.value ? const Text('Body type is required',textAlign: TextAlign.left,style: TextStyle(color: Colors.red,fontSize: 13,),):const SizedBox(),
                  controller.putRequestError.value ? const Text('Please give QueryParams or Body',textAlign: TextAlign.left,style: TextStyle(color: Colors.red,fontSize: 13,),):const SizedBox(),
                  controller.apiBodyType.value.isEmpty? const SizedBox() :  controller.apiRequestType.value=='GET'||controller.apiRequestType.value=='DELETE' ? Container() :TextFormField(
                    controller: controller.bodyController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(color: Colors.black,fontSize: 10),
                    minLines: 3,
                    maxLines: 10,
                    decoration:  const InputDecoration(
                      labelText: 'Body',
                      hintText: "Please give Body \n{ \n key:value,\n key:value \n}",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: Colors.black,fontSize: 13),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      errorBorder:OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      isDense: true,
                    ),
                    validator: (val){
                      if(controller.apiRequestType.value=='POST' && val!.isEmpty){
                        return 'Body is required ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5,),
                ],
              ),
            ),
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppUtils().button(btnName: 'Add' , onTap: (){
              if(!formKey.currentState!.validate()){
                return;

              }
              else if((controller.apiRequestType.value=='POST'||controller.apiRequestType.value=='PUT') && (controller.apiBodyType.value=='JSON') && !controller.headersController.text.contains('Content-Type: application/json') ){
                controller.putPostHeaderError.value=true;
              }
              else if(controller.apiRequestType.value=='POST'&& controller.apiBodyType.value.isEmpty ){
                controller.postRequestError.value=true;
              }
              else if(controller.apiRequestType.value=='PUT'&& controller.bodyController.text.isEmpty && controller.queryParamsController.text.isEmpty){
                controller.putRequestError.value=true;
              }
              else{
                if(controller.urlController.text.isNotEmpty && controller.urlController.text.startsWith('http') ){
                  controller.setData2();
                }
              }
            }),
            const SizedBox(width: 5,),
            AppUtils().button(btnName: 'Close'  ,  onTap: (){
              Navigator.pop(context);
            })
          ],
        )
      ],

    );
  });

}

