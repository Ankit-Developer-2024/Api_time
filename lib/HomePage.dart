

import 'package:api_time/HomePageController.dart';
import 'package:api_time/ResponsePage.dart';
import 'package:api_time/cURL.dart';
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
           padding: const EdgeInsets.only(top: 5,right: 5,left: 5),
           child: Container(
             color: const Color.fromRGBO(211, 211, 211, 1),
             child: Column(
               children: [
                 TextField(
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
                 const SizedBox(height: 6,),
                 Row(
                   children: [
                     SizedBox(
                       width:150,
                       child: TextField(
                         controller: controller.timeOutController,
                         style: const TextStyle(color: Colors.black,fontSize: 10),
                         decoration: const InputDecoration(
                           labelText: "Api timeout(milliseconds)",
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
                     const SizedBox(width: 5,),
                     Column(
                       children: [
                         ConstrainedBox(
                              constraints: BoxConstraints(minHeight: 20, maxHeight: 20,minWidth:50,maxWidth:100),
                             child: OutlinedButton(
                                 onPressed: (){
                                   controller.apiMethod.value='Dio';
                                 },
                                 style: OutlinedButton.styleFrom(// Text color// Background color
                                   backgroundColor: controller.apiMethod=='Dio' ? Colors.green : Colors.blue,
                                   side: const BorderSide(color: Colors.white, width: 0.5), // Border color and width
                                    padding: const EdgeInsets.symmetric(horizontal: 5,), // Padding inside the button
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(2), // Rounded corners
                                   ),
                                 ),
                                 child: Text('Dio',style: TextStyle(color: Colors.white,fontSize: 13)))),
                         ConstrainedBox(
                             constraints: BoxConstraints(minHeight: 20,maxHeight: 20,minWidth:50,maxWidth:100),
                             child: OutlinedButton(
                                 onPressed: (){
                                   controller.apiMethod.value='Http';
                                 },
                                 style: OutlinedButton.styleFrom(// Text color// Background color
                                   backgroundColor: controller.apiMethod =='Http' ? Colors.green : Colors.blue,
                                   side: const BorderSide(color: Colors.white, width: 0.5), // Border color and width
                                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0), // Padding inside the button
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(2), // Rounded corners
                                   ),
                                 ),
                                 child: Text('Http ',style: TextStyle(color: Colors.white,fontSize: 13)))),
                       ],
                     ),
                     const SizedBox(width: 5,),
                     ConstrainedBox(
                       constraints: const BoxConstraints(minWidth:50,maxWidth:100 ,minHeight: 40),
                       child: OutlinedButton(
                           onPressed: (){


                             if(controller.cURLController.text.isNotEmpty ){
                               // Get.snackbar(
                               //     'Added Successfully ','' ,
                               //     maxWidth:Get.width/2,
                               //     backgroundColor: Colors.black26,
                               //     colorText: Colors.white,
                               //     snackPosition:SnackPosition.BOTTOM,
                               //     duration:const Duration(milliseconds: 500)
                               // );
                               controller.setData();
                               controller.cURLController.text='';
                             }
                             else{
                               Get.snackbar(
                                   titleText: const Text('Please add cURL',style: TextStyle(color: Colors.white),),"","",
                                   maxWidth:Get.width/4,
                                   backgroundColor: Colors.black26,
                                   colorText: Colors.white,
                                   snackPosition:SnackPosition.BOTTOM,
                                   duration:const Duration(milliseconds: 800)
                               );
                             }
                           },
                           style: OutlinedButton.styleFrom(// Text color// Background color
                             backgroundColor: Colors.blue,
                             side: const BorderSide(color: Colors.white, width: 0.5), // Border color and width
                             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15), // Padding inside the button
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(2), // Rounded corners
                             ),
                           ),
                           child: const Text('Add',style: TextStyle(color: Colors.white,fontSize: 13),)),
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
                   height: MediaQuery.sizeOf(context).height-280,
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
                             subtitle: Text("QueryParameter: ${mp['queryParameter'].toString()} \n Data: ${mp['data'].toString()}",style: const TextStyle())
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
                       controller: controller.apiIntervalController,
                       style: const TextStyle(color: Colors.black,fontSize: 10),
                       decoration: const InputDecoration(
                         labelText: "Interval (milliseconds)",
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
