

import 'package:api_time/HomePageController.dart';
import 'package:flutter/material.dart';

class AppUtils{


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
    Color borderColor=Colors.black,
    double borderWidth=1,
    double horizontalPadding=15,
    double verticalPadding=5,
    double borderRadius=3,

  }){
    return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(// Text color// Background color
          backgroundColor: bgColor,
          side: const BorderSide(color: Colors.white, width: 0.5), // Border color and width
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0), // Padding inside the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2), // Rounded corners
          ),
        ),
        child: Text(
          btnName,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ));
  }


}