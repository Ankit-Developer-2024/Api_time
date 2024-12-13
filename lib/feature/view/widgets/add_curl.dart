import 'package:api_time/constant/AppColors.dart';
import 'package:api_time/constant/AppCustomDimension.dart';
import 'package:api_time/constant/widgets/CommonUIComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:api_time/feature/controller/HomePageController.dart';


class AddCurl extends StatelessWidget {
   AddCurl({super.key});

 final HomePageController controller=Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
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
}