

import 'package:api_time/HomePageController.dart';
import 'package:api_time/ResponsePage.dart';
import 'package:api_time/Utils.dart';
import 'package:api_time/cURL.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
           padding: const EdgeInsets.only(top: 5,right: 5,left: 5),
           child: Container(
             color: const Color.fromRGBO(211, 211, 211, 1),
             child: Column(
               children: [
                 const SizedBox(height: 6,),
                 Row(
                   children: [
                     Container(
                       height: 38,
                       padding: EdgeInsets.only(left:5),
                       color: Colors.blue,
                       child: DropdownButtonHideUnderline(
                         child: DropdownButton(
                           value:controller.apiMethod.value,
                           style: const TextStyle(fontSize: 20),
                           dropdownColor: Colors.grey,
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
                           },),
                       )
                     ),
                     const SizedBox(width: 5,),
                     ConstrainedBox(
                       constraints: const BoxConstraints(minWidth:50,maxWidth:100 ,minHeight: 40),
                       child: OutlinedButton(
                           onPressed: (){
                             showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Choose cURL or URL',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20)),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3),),
                                        titlePadding: const EdgeInsets.only(top: 10),
                                        contentPadding: const EdgeInsets.only(top: 5),
                                        actionsPadding: const EdgeInsets.only(bottom: 5),
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                              AppUtils().button(btnName: "cURL", onTap: (){
                                                Navigator.pop(context);
                                                showDialog(context: context, builder: (context) {
                                                  return addCurl(controller,context);
                                                },);
                                              }),
                                              const SizedBox(width: 10 ,),
                                              AppUtils().button(btnName: 'URL', onTap: (){
                                                Navigator.pop(context);
                                                showDialog(context: context, builder: (context) {
                                                  return addUrl(controller,context);
                                                },);
                                              })
                                            ]
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Close',style: TextStyle(color: Colors.black,fontSize: 13),),
                                          ),
                                        ],

                                      );
                               },);
                           },
                           style: OutlinedButton.styleFrom(// Text color// Background color
                             backgroundColor: Colors.blue,
                             side: const BorderSide(color: Colors.white, width: 0.5), // Border color and width
                             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15), // Padding inside the button
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(2), // Rounded corners
                             ),
                           ),
                           child: const Text('Add cUrl/URL',style: TextStyle(color: Colors.white,fontSize: 13),)),
                     ),
                     const SizedBox(width: 5,),
                     ConstrainedBox(
                       constraints: const BoxConstraints(minWidth:50,maxWidth:100 ,minHeight: 40),
                       child: OutlinedButton(
                           onPressed: (){
                             controller.urls?.clear();
                             controller.apiDetails?.clear();
                           },
                           style: OutlinedButton.styleFrom(// Text color// Background color
                             backgroundColor: Colors.blue,
                             side: const BorderSide(color: Colors.white, width: 0.5), // Border color and width
                             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15), // Padding inside the button
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(2), // Rounded corners
                             ),
                           ),
                           child: const Text('Clear',style: TextStyle(color: Colors.white,fontSize: 13),)),
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
                             subtitle: Text("QueryParameter: ${mp['queryParameter'].toString()} \nData: ${mp['data'].toString()}",style: const TextStyle())
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
                               Get.snackbar(
                                   'Api call Successfully','' ,
                                   maxWidth:Get.width/4,
                                   backgroundColor: Colors.black26,
                                   colorText: Colors.white,
                                   snackPosition:SnackPosition.BOTTOM,
                                   duration:const Duration(milliseconds: 800)
                               );
                               controller.api();
                             }
                             else{
                               Get.snackbar(
                                   'Please add  at least one cURL','' ,
                                   maxWidth:Get.width/4,
                                   backgroundColor: Colors.black26,
                                   colorText: Colors.white,
                                   snackPosition:SnackPosition.BOTTOM,
                                   duration:const Duration(milliseconds: 800)
                               );
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

                                    mp['resBody']=='Loader' ?
                                    Get.snackbar('Try to Fetch data', '',
                                        maxWidth:Get.width/4,
                                        backgroundColor: Colors.black26,
                                        colorText: Colors.white,
                                        snackPosition:SnackPosition.BOTTOM,
                                        duration:const Duration(milliseconds: 800)
                                    )  : Get.to(duration: const Duration(seconds: 1), ResponsePage(response:mp['resBody']));
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

  return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
         title: SizedBox(
           width: Get.width/3,
           child: TextField(
             controller: controller.cURLController,
             minLines: 10,
             maxLines: 10,
             style: const TextStyle(color: Colors.black,fontSize: 10),
             decoration: const InputDecoration(
               labelText: "Your cURL here ",
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

           ),
         ),
        titlePadding: const EdgeInsets.all(10),
         actions: <Widget>[
           AppUtils().button(btnName: 'Add' ,  onTap: (){
             if(controller.cURLController.text.isNotEmpty ){
               controller.setData();
               controller.cURLController.text='';
             }
             else{
               Get.snackbar(
                   titleText: const Text('Please add cURL ',style: TextStyle(color: Colors.white),),"","",
                   maxWidth:Get.width/4,
                   backgroundColor: Colors.black26,
                   colorText: Colors.white,
                   snackPosition:SnackPosition.BOTTOM,
                   duration:const Duration(milliseconds: 800)
               );
             }
           }),
          AppUtils().button(btnName: 'Close'  ,  onTap: (){
            Navigator.pop(context);
          })
        ]
  );

}

Widget addUrl(HomePageController controller,BuildContext context){

  return Obx(() {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        title: SizedBox(
          width: Get.width/2,
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Row(
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
                  validator: (val){
                    if(val!.isEmpty || !val.startsWith('http') ){
                      return 'Please give valid URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: controller.headersController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 5,),
                controller.apiRequestType=='POST' ?  Container() :  TextFormField(
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
                ),
                const SizedBox(height: 5,),
                controller.apiRequestType.value=='GET'||controller.apiRequestType.value=='DELETE' ? Container() :TextFormField(
                  controller: controller.bodyController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.black,fontSize: 10),
                  minLines: 3,
                  maxLines: 10,
                  decoration:  const InputDecoration(
                    labelText: 'Body',
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
                ),
                const SizedBox(height: 5,),
              ],
            ),
          ),
        ),
        titlePadding: const EdgeInsets.all(10),
        actions: <Widget>[
          AppUtils().button(btnName: 'Add' ,  onTap: (){
            if(controller.urlController.text.isNotEmpty ){
              controller.setData2();
               controller.urlController.text='';
               controller.headersController.text='';
               controller.queryParamsController.text='';
               controller.bodyController.text='';
            }
            else{
              Get.snackbar(
                  titleText: const Text('Please add URL ',style: TextStyle(color: Colors.white),),"","",
                  maxWidth:Get.width/4,
                  backgroundColor: Colors.black26,
                  colorText: Colors.white,
                  snackPosition:SnackPosition.BOTTOM,
                  duration:const Duration(milliseconds: 800)
              );
            }
          }),
          AppUtils().button(btnName: 'Close'  ,  onTap: (){
            Navigator.pop(context);
          })
        ]
    );
  });

}

