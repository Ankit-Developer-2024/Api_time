import 'package:api_time/constant/AppColors.dart';
import 'package:flutter/material.dart';

class NotificationForUser extends StatelessWidget {
  const NotificationForUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
            heightFactor: MediaQuery.of(context).size.height,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Optimized Viewing Experience Recommended",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "If your screen width is less than 700 pixels, the experience may be limited. Please open the website on a desktop or a tablet with a screen width greater than 700 pixels for the best experience.",
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            )));
  }
}
