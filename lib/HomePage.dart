

import 'package:api_time/HomePageController.dart';
import 'package:api_time/ResponsePage.dart';
import 'package:api_time/CommonUIComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'AppColors.dart';
import 'AppCustomDimension.dart';

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
             leftSideCurlUrl(controller,context),
             const SizedBox(width: 5,),
             //Right side  details
             rightSideApiDetails(controller,context),

           ],
         ),
       ),
     );
  }
}


 Widget leftSideCurlUrl(HomePageController controller,BuildContext context){

  return Expanded(
       flex: 2,
       child: Obx(() {
         return Container(
           color: Colors.white,
           padding: const EdgeInsets.only(right: px_5),
           child: Container(
             color: const Color.fromRGBO(211, 211, 211, 1),
             padding: const EdgeInsets.only(left: 3),
             child: Column(
               children: [
                 Row(
                   children: [
                     Container(
                       padding: const EdgeInsets.only(left:px_5,top: px_7,bottom:px_7),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(px_3),
                           border: Border.all(width: 0.5,color: AppColors.white),
                           color: Colors.blue,
                       ),
                       child: DropdownButtonHideUnderline(
                         child: DropdownButton(
                           value:controller.apiMethod.value,
                           dropdownColor: const Color.fromRGBO(211, 211, 211, 1),
                           iconEnabledColor: AppColors.white,
                           items:controller.requestMethod.map((String val) {
                             return DropdownMenuItem<String>(
                               value: val,
                               child: Text(val,style: const TextStyle(color: AppColors.white,fontSize: textSize_13)),
                             );
                           }).toList(),
                           isDense: true,
                           padding: const EdgeInsets.only(left: px_5),
                           onChanged: (val){
                             controller.apiMethod.value=val!;

                           },),
                       )
                     ),
                     const SizedBox(width: 5,),
                     ConstrainedBox(
                       constraints: const BoxConstraints(minWidth:65 ,minHeight: 40),
                       child: CommonUiComponent().button(btnName: 'Add cURL/URL', onTap: (){
                         showDialog(context: context, builder: (context) {
                           return AlertDialog(
                              backgroundColor:Colors.white ,
                             surfaceTintColor: Colors.white,
                             scrollable:true ,
                             title: const Text('Choose cURL or Api Detail',textAlign: TextAlign.center,style: TextStyle(color: AppColors.black,fontSize: textSize_20)),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(px_3),),
                             titlePadding: const EdgeInsets.only(top: px_10),
                             contentPadding: const EdgeInsets.all(px_10),
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
                                             padding: const EdgeInsets.all(12.0),
                                             alignment: Alignment.center,
                                             decoration:BoxDecoration(
                                               color:  controller.extractData.value=='cURL' ? AppColors.white : AppColors.lightGrey,
                                               border: Border(
                                                 top: const BorderSide(color: AppColors.grey, width: borderWidth_1,),
                                                 right: const BorderSide(color: AppColors.grey, width: borderWidth_1,),
                                                 left:const BorderSide(color: AppColors.grey, width: borderWidth_1,),
                                                 bottom: controller.extractData.value=='cURL' ? BorderSide.none:const BorderSide(color: AppColors.grey, width: borderWidth_1,),
                                               ),
                                             ),
                                             child: const Text(
                                               'cURL',
                                               style: TextStyle(color: AppColors.black, fontSize: textSize_13,),
                                             ),
                                           ),
                                         )),
                                         Expanded(child:  InkWell(
                                           onTap: () {
                                             controller.extractData.value='URL';
                                           },
                                           child: Container(
                                             padding: const EdgeInsets.all(12.0),
                                             alignment: Alignment.center,
                                             decoration:  BoxDecoration(
                                               color:  controller.extractData.value=='URL' ? AppColors.white : AppColors.lightGrey,
                                              border: Border(
                                                top: const BorderSide(color: AppColors.grey, width: borderWidth_1,),
                                                right: const BorderSide(color: AppColors.grey, width: borderWidth_1,),
                                                bottom: controller.extractData.value=='URL' ? BorderSide.none:const BorderSide(color: AppColors.grey, width: borderWidth_1),
                                                ),
                                                ),
                                             child: const Text(
                                               'Api Detail',
                                               style: TextStyle(color: AppColors.black, fontSize: textSize_13,),
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
                       child:CommonUiComponent().button(btnName: 'Clear', onTap: (){
                         controller.urls?.clear();
                         controller.apiDetails?.clear();
                         controller.successRequest.value=0;
                         controller.failedRequest.value=0;
                       })

                     ),

                   ],
                 ),
                 const SizedBox(height: 3,),
                 Container(
                   color: AppColors.grey,
                   height: MediaQuery.sizeOf(context).height-105,
                   child: controller.urls == null ? Container() :   ListView.builder(
                       scrollDirection: Axis.vertical,
                       itemCount: controller.urls?.length,
                       itemBuilder: (context,index){
                         dynamic mp=controller.urls![index];
                         return Card(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(px_2),
                           ),
                           child: ListTile(
                             leading: Text((index+1).toString(),style: const TextStyle(color:AppColors.black,fontSize: textSize_13),),
                             title: Text(mp['url'],style: const TextStyle(color:AppColors.black,fontSize: textSize_13)),
                             subtitle:Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 mp['queryParameter'].toString().length==2 ? const SizedBox() : Text("QueryParameter: ${mp['queryParameter'].toString()} ",style: const TextStyle(color:AppColors.black,fontSize: textSize_11)),
                                 mp['data']==null ? const SizedBox() : Text("Data: ${mp['data'].toString()}",style: const TextStyle(color:AppColors.black,fontSize: textSize_11),)

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
                           style: const TextStyle(color: AppColors.textFieldTextColor,fontSize: textFieldTextSize),
                           keyboardType: TextInputType.number,
                           inputFormatters:<TextInputFormatter> [
                             FilteringTextInputFormatter.digitsOnly
                           ],
                           decoration: const InputDecoration(
                             labelText: "Api count ",
                             labelStyle: TextStyle(color: AppColors.textFieldLabel,fontSize: textFieldLabelSize),
                             enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: AppColors.textFieldEnableColor,width: textFieldBorderWidth),
                               borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: AppColors.textFieldFocusedColor,width: textFieldBorderWidth),
                               borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
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
                       style: const TextStyle(color:AppColors.textFieldTextColor,fontSize: textFieldTextSize),
                       keyboardType: TextInputType.number,
                       inputFormatters:<TextInputFormatter> [
                           FilteringTextInputFormatter.digitsOnly
                         ],
                       decoration: const InputDecoration(
                         labelText: "Api timeout(millisec)",
                         labelStyle: TextStyle(color: AppColors.textFieldLabel,fontSize: textFieldLabelSize),
                         focusColor: Colors.black,
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: AppColors.textFieldEnableColor,width: textFieldBorderWidth),
                           borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: AppColors.textFieldFocusedColor,width: textFieldBorderWidth),
                           borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                         ),
                         isDense: true,
                       ),
                       onChanged: (value){
                           if(value.isNotEmpty){
                             controller.apiTimeOut.value = int.parse(value);
                           }
                         },
                     ),),
                     const SizedBox(width: 3,),
                     Expanded(
                       flex: 1,
                       child: TextField(
                       controller: controller.apiIntervalController,
                       style: const TextStyle(color: AppColors.textFieldTextColor,fontSize: textFieldTextSize),
                       keyboardType: TextInputType.number,
                       inputFormatters:<TextInputFormatter> [
                           FilteringTextInputFormatter.digitsOnly
                         ],
                       decoration: const InputDecoration(
                         labelText: "Interval (millisec)",
                         labelStyle: TextStyle(color: AppColors.textFieldLabel,fontSize: textFieldLabelSize),
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: AppColors.textFieldEnableColor,width: textFieldBorderWidth),
                           borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: AppColors.textFieldFocusedColor,width: textFieldBorderWidth),
                           borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
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
                           child:CommonUiComponent().button(btnName: 'Submit',
                               onTap: (){
                                 controller.apiDetails?.clear();
                                 controller.successRequest.value=0;
                                 controller.failedRequest.value=0;
                                 if(controller.urls!= null && controller.urls!.isNotEmpty){
                                   controller.startCallingApi();
                                 }
                                 else{

                                   CommonUiComponent().snackBar(firstTitle: 'Please add at least one cURL or URL', secondTitle: "");

                                 }
                           }),

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
        color: AppColors.black,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: px_5,vertical:px_6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(px_3),
                        border: Border.all(color: AppColors.black, width: px_1),
                        color: AppColors.blue,
                      ),

                      child: Text('Total Request: ${controller.apiDetails!.length.toString()}', style: const TextStyle(color: AppColors.white, fontSize: textSize_13),),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: px_5,vertical:px_6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(px_3),
                        border: Border.all(color: AppColors.black, width: px_1),
                        color: AppColors.green,
                      ),

                      child: Text('Success Request: ${controller.successRequest.value}', style: const TextStyle(color: AppColors.white, fontSize: textSize_13),),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: px_5,vertical:px_6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(px_3),
                        border: Border.all(color: AppColors.black, width: px_1),
                        color: AppColors.red,
                      ),

                      child: Text('Failed Request: ${controller.failedRequest.value}', style: const TextStyle(color: AppColors.white, fontSize: textSize_13),),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: px_5,vertical:px_6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(px_3),
                        border: Border.all(color: AppColors.black, width: px_1),
                        color: AppColors.orangeAccent,
                      ),

                      child: Text('Completed Request: ${controller.successRequest.value+controller.failedRequest.value}', style: const TextStyle(color: AppColors.white, fontSize: textSize_13),),
                    ),

                  ],
                ),
                   CommonUiComponent().button(btnName: 'Clear', textColor: AppColors.white ,fontSize: textSize_13,borderColor: AppColors.black ,
                    onTap: (){
                      controller.apiDetails?.clear();
                      controller.successRequest.value=0;
                      controller.failedRequest.value=0;
                    }),

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
                      margin: const EdgeInsets.all(px_5),
                      padding: const EdgeInsets.all(px_3),
                      decoration:BoxDecoration(
                        border: Border.all(
                          width: px_1,
                          color: AppColors.white
                        ),
                        borderRadius: BorderRadius.circular(px_2), // Uniform radius
                      ),
                      child: Column(

                        children: [
                          Row(
                            mainAxisAlignment:  MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Index: ${mp['urlNumber']} | Api Index: ${mp['apiIndex']} |',style: const TextStyle(color: AppColors.white,fontSize: textSize_13),),
                              Text('RequestType: ${mp['requestType']} | ',style: const TextStyle(color: AppColors.white,fontSize: 13),),
                              Row(
                                children: [
                                  const Text('Total Time: ',style: TextStyle(color: Colors.white,fontSize: textSize_13),),
                                  mp['duration']=='Loader' ?
                                     Container(
                                      width: 10,
                                      height: 10,
                                      margin: const EdgeInsets.only(top:px_4,left: px_4),
                                      child: const CircularProgressIndicator(strokeWidth: 2,))
                                      :Text('${mp['duration']} millisec',style: const TextStyle(color: Colors.white,fontSize: textSize_13),),
                                      const Text(' | ',style: TextStyle(color: Colors.white,fontSize: textSize_13),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Status: ",style: TextStyle(color: mp['statusCode']=='Loader' ? Colors.white : mp['statusCode']==200 ? AppColors.green : mp['statusCode']==201 ? AppColors.green  : AppColors.red,fontSize: textSize_13)),
                                  mp['statusCode']=='Loader' ?
                                      Container(
                                      width: px_10,
                                      height: px_10,
                                      margin: const EdgeInsets.only(top:4,left: 4),
                                      child: const CircularProgressIndicator(strokeWidth: 2,))
                                      :Text('${mp['statusCode']} ',style: TextStyle(color: mp['statusCode']==200 ? AppColors.green : mp['statusCode']==201 ? AppColors.green : AppColors.red,fontSize: textSize_13,),),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment:  MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('URL: ${mp['url']}',style: const TextStyle(color: Colors.white,fontSize: textSize_13),),
                              const SizedBox(width: 5,),
                              GestureDetector(
                                  onTap: (){

                                    mp['resBody']=='Loader' ? CommonUiComponent().snackBar(firstTitle:'Try to Fetch data',secondTitle: '' )
                                                            : Get.to(duration: const Duration(seconds: 1), ResponsePage(response:mp['resBody'],mp: input,));
                                  },
                                  child:  mp['resBody']=='Loader' ?
                                                      Container(
                                                          width: px_10,
                                                          height: px_10,
                                                          margin: const EdgeInsets.only(top:px_4,left: px_4),
                                                          child: const CircularProgressIndicator(strokeWidth: 2,))
                                                      :  const Text('View Response ',style: TextStyle(fontSize: textSize_13,color: AppColors.blue)),
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
          width: Get.width/3+30,
          child: TextField(
            controller: controller.cURLController,
            minLines: 10,
            maxLines: 10,
            style: const TextStyle(color:AppColors.textFieldTextColor,fontSize: textFieldTextSize),
            decoration: const InputDecoration(
              labelText: "Your cURL here ",
              hintText: "More than one cURL must be separated by @@%",
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: AppColors.textFieldLabel,fontSize: textFieldLabelSize),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldEnableColor,width: textFieldBorderWidth),
                borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldFocusedColor,width: textFieldBorderWidth),
                borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
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
            CommonUiComponent().button(btnName: 'Add' ,bgColor:   controller.cURLError.value ? AppColors.grey : AppColors.blue ,  onTap: (){

              if(controller.cURLController.text.isNotEmpty ){
                controller.setDataByCurl();
              }else{
                controller.cURLError.value=true;
              }

            }),
            const SizedBox(width: 5,),
             CommonUiComponent().button(btnName: 'Close'  ,  onTap: (){
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
                      const Text('Request Type:',style: TextStyle(fontSize: textSize_13,color: AppColors.black),),
                      const SizedBox(width: 5,),
                      Container(

                        decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                          border: Border.all(color: AppColors.white,width: 0.5)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value:controller.apiRequestType.value,
                            items:controller.requestType.map((String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val,style: const TextStyle(color: AppColors.black,fontSize: textSize_13)),
                              );
                            }).toList(),
                            isDense: true,
                            padding: const EdgeInsets.only(left: 5),
                            iconEnabledColor: AppColors.black,
                            onChanged: (val){
                              controller.apiRequestType.value=val!;
                              controller.apiBodyType.value='';
                              controller.urlController.clear();
                              controller.headersController.clear();
                              controller.queryParamsController.clear();
                              controller.bodyController.clear();
                              controller.postRequestError.value=false;
                              controller.putRequestError.value=false;
                              controller.putPostHeaderError.value=false;
                            },),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  TextFormField(
                    controller: controller.urlController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(color: AppColors.textFieldTextColor,fontSize: textFieldTextSize),
                    decoration:  const InputDecoration(
                      labelText: 'URL',
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: AppColors.textFieldLabel,fontSize: textFieldLabelSize),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldEnableColor,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide( color: AppColors.textFieldFocusedColor,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldFocusedErrorBorder,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      errorBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldErrorBorder,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      errorStyle: TextStyle(color: AppColors.textFieldErrorText,fontSize: textFieldErrorTextSize),
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
                    minLines: 5,
                    maxLines: 10,
                    style: const TextStyle(color: AppColors.textFieldTextColor,fontSize: textFieldTextSize),
                    decoration:  const InputDecoration(
                      labelText: 'Header',
                      hintText: "Please give header \nkey: value\nkey2: value2",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: AppColors.textFieldLabel,fontSize: textFieldLabelSize),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldEnableColor,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldFocusedColor,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldFocusedErrorBorder,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      errorBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldErrorBorder,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      errorStyle: TextStyle(color: AppColors.textFieldErrorText,fontSize: textFieldErrorTextSize,),
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
                controller.putPostHeaderError.value ? const SelectableText("Your body is JSON ,So you also need to give  Content-Type: application/json  header",style: TextStyle(color: AppColors.textFieldErrorText,fontSize: textFieldErrorTextSize),)  : const SizedBox(),
                  controller.apiRequestType.value=='POST' ?  Container() :  TextFormField(
                    controller: controller.queryParamsController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(color: AppColors.textFieldTextColor,fontSize: textFieldTextSize),
                    minLines: 5,
                    maxLines: 10,
                    decoration:  const InputDecoration(
                      labelText: 'Query Parameters',
                      hintText: "Please give Query Parameters \nkey=value\nkey2=value2",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: AppColors.textFieldLabel,fontSize: textFieldLabelSize),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldEnableColor,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldFocusedColor,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldFocusedErrorBorder,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      errorStyle: TextStyle(color: AppColors.textFieldErrorText,fontSize: textFieldErrorTextSize),
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
                    CommonUiComponent().button(btnName: 'Form-Data', textColor: controller.apiBodyType.value=='Form-Data'? AppColors.white  : AppColors.black , bgColor:controller.apiBodyType.value=='Form-Data'? AppColors.green  : AppColors.transparent ,borderColor:controller.apiBodyType.value=='Form-Data'? AppColors.white : AppColors.black,onTap: (){
                      controller.apiBodyType.value='Form-Data';
                      controller.postRequestError.value=false;
                      controller.putRequestError.value=false;
                      controller.putPostHeaderError.value=false;
                    }),
                    const SizedBox(width: 5,),
                    CommonUiComponent().button(btnName: 'JSON', textColor: controller.apiBodyType.value=='JSON'? AppColors.white  : AppColors.black,bgColor:controller.apiBodyType.value=='JSON'? AppColors.green  : AppColors.transparent ,borderColor: controller.apiBodyType.value=='JSON'? AppColors.white : AppColors.black,  onTap: (){
                      controller.apiBodyType.value='JSON';
                      controller.postRequestError.value=false;
                      controller.putRequestError.value=false;
                    })
                  ],),
                  const SizedBox(height: 5,),
                  controller.postRequestError.value ? const Text('Body type is required',textAlign: TextAlign.left,style: TextStyle(color: AppColors.textFieldErrorText,fontSize: textFieldErrorTextSize,),):const SizedBox(),
                  controller.putRequestError.value ? const Text('Please give QueryParams or Body',textAlign: TextAlign.left,style: TextStyle(color: AppColors.textFieldErrorText,fontSize: textFieldErrorTextSize,),):const SizedBox(),
                  controller.apiBodyType.value.isEmpty? const SizedBox() :  controller.apiRequestType.value=='GET'||controller.apiRequestType.value=='DELETE' ? Container() :TextFormField(
                    controller: controller.bodyController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(color: AppColors.textFieldTextColor,fontSize: textFieldTextSize),
                    minLines: 5,
                    maxLines: 10,
                    decoration:  const InputDecoration(
                      labelText: 'Body',
                      hintText: "Please give Body \n{ \n key:value,\n key:value \n}",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: AppColors.textFieldLabel,fontSize: textFieldLabelSize),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:AppColors.textFieldEnableColor, width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldFocusedColor,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldFocusedErrorBorder,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      errorBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldErrorBorder,width: textFieldBorderWidth),
                        borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                      ),
                      errorStyle: TextStyle(color: AppColors.textFieldErrorText,fontSize: textFieldErrorTextSize),
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
            CommonUiComponent().button(btnName: 'Add' , onTap: (){
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
                  controller.setDataByUrl();
                }
              }
            }),
            const SizedBox(width: 5,),
            CommonUiComponent().button(btnName: 'Close'  ,  onTap: (){
              Navigator.pop(context);
            })
          ],
        )
      ],

    );
  });

}

