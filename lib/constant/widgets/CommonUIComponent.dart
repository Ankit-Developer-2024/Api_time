

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonUiComponent{


    Widget textFormField({
      required TextEditingController controller,
       required String fieldLabel ,
      required Function(String val) onValidate,
    }){
      return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(color: Colors.black,fontSize: 10),
        decoration:  InputDecoration(
          labelText: fieldLabel,
          alignLabelWithHint: true,
          labelStyle: const TextStyle(color: Colors.black,fontSize: 13),
          focusColor: Colors.black,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(1)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(1)),
          ),
          isDense: true,
        ),
        validator: (val){
          onValidate(val!);
          return null;
        },
      );
    }




  Widget  button({
    required String btnName,
    required VoidCallback onTap,
    double fontSize=13,
    Color textColor=Colors.white,
    Color bgColor=Colors.blue,
    Color borderColor=Colors.white,
    double borderWidth=0.1,
    double horizontalPadding=0,
    double verticalPadding=0,
    double borderRadius=3,

  }){
    return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(// Text color// Background color
          backgroundColor: bgColor,
          side:  BorderSide(color: borderColor, width: borderWidth), // Border color and width
          padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding), // Padding inside the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 5,right:5),
          child: Text(
            btnName,
            style: TextStyle(color: textColor, fontSize: fontSize),
          ),
        ));
  }

  SnackbarController snackBar({
          required String firstTitle,
          required String secondTitle,
          double maxWidth = 400,
          Color bgColor=Colors.white,
          Color textColor=Colors.black,
          int durationMilliseconds =800,
        }

      ){
      return  Get.snackbar(
          firstTitle,secondTitle,
          maxWidth:maxWidth,
          backgroundColor: bgColor,
          colorText: textColor,
          snackPosition:SnackPosition.BOTTOM,
          borderRadius:2,
          margin:const EdgeInsets.only(bottom: 10),
          duration: Duration(milliseconds: durationMilliseconds)
      );
  }





}