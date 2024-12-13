import 'package:flutter/material.dart';
import 'package:get/get.dart';

  void applictionInfoForUser() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "APT Load Testing Time",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: MediaQuery.sizeOf(context).width / 2,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    '• Here, you can test the total time taken by the API to get a response from the server.'),
                Text(
                    '• Please use only those APIs whose responses are in JSON format.'),
                Text(
                    '• If you put the **cURL** command in the cURL box, it should follow the format typically generated by Postman. Ensure the cURL command is compatible because not all cURL formats or types may be supported.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text(
                "Ok",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }
