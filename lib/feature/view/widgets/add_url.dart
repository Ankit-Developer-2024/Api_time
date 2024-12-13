
import 'package:api_time/constant/AppColors.dart';
import 'package:api_time/constant/AppCustomDimension.dart';
import 'package:api_time/constant/widgets/CommonUIComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:api_time/feature/controller/HomePageController.dart';


class AddUrl extends StatelessWidget {
   AddUrl({super.key});

  final HomePageController controller=Get.put(HomePageController());
  final dynamic formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
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
}