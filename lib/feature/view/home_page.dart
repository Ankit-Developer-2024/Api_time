import 'package:api_time/feature/controller/HomePageController.dart';
import 'package:api_time/feature/view/widgets/left_side_curl_url.dart';
import 'package:api_time/feature/view/widgets/notification_for_user.dart';
import 'package:api_time/feature/view/widgets/right_side_api_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
    HomePage({super.key});

  HomePageController controller=Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
     return screenWidth<700 ?const NotificationForUser() : Scaffold(
       body: SizedBox(
         height: double.infinity,
         child: Row(
           children: [
             
             //Left side api
             LeftSideCurlUrl(),
             const SizedBox(width: 5,),
             //Right side  details
             RightSideApiDetails(),

           ],
         ),
       ),
     );
  }
}











