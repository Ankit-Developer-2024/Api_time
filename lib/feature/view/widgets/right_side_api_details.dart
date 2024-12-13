import 'package:api_time/feature/view/api_response_page.dart';
import 'package:api_time/constant/AppColors.dart';
import 'package:api_time/constant/AppCustomDimension.dart';
import 'package:api_time/constant/widgets/CommonUIComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:api_time/feature/controller/HomePageController.dart';

class RightSideApiDetails extends StatelessWidget {
  RightSideApiDetails({super.key});

  final HomePageController controller = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Obx(() {
        return Container(
          color: AppColors.black,
          height: double.infinity,
          child: Wrap(
            children: [
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: px_5, vertical: px_6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(px_3),
                            border:
                                Border.all(color: AppColors.black, width: px_1),
                            color: AppColors.blue,
                          ),
                          child: Text(
                            'Total Request: ${controller.apiDetails!.length.toString()}',
                            style: const TextStyle(
                                color: AppColors.white, fontSize: textSize_13),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: px_5, vertical: px_6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(px_3),
                            border:
                                Border.all(color: AppColors.black, width: px_1),
                            color: AppColors.green,
                          ),
                          child: Text(
                            'Success Request: ${controller.successRequest.value}',
                            style: const TextStyle(
                                color: AppColors.white, fontSize: textSize_13),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: px_5, vertical: px_6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(px_3),
                            border:
                                Border.all(color: AppColors.black, width: px_1),
                            color: AppColors.red,
                          ),
                          child: Text(
                            'Failed Request: ${controller.failedRequest.value}',
                            style: const TextStyle(
                                color: AppColors.white, fontSize: textSize_13),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: px_5, vertical: px_6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(px_3),
                            border:
                                Border.all(color: AppColors.black, width: px_1),
                            color: AppColors.orangeAccent,
                          ),
                          child: Text(
                            'Completed Request: ${controller.successRequest.value + controller.failedRequest.value}',
                            style: const TextStyle(
                                color: AppColors.white, fontSize: textSize_13),
                          ),
                        ),
                      ],
                    ),
                    CommonUiComponent().button(
                        btnName: 'Clear',
                        textColor: AppColors.white,
                        fontSize: textSize_13,
                        borderColor: AppColors.black,
                        onTap: () {
                          controller.apiDetails?.clear();
                          controller.successRequest.value = 0;
                          controller.failedRequest.value = 0;
                        }),
                  ],
                ),
              ),
              controller.apiDetails == null
                  ? Container()
                  : SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: ListView.builder(
                          itemCount: controller.apiDetails?.length,
                          itemBuilder: (context, index) {
                            dynamic mp = controller.apiDetails![index];
                            dynamic input = controller
                                .urls?[int.parse(mp['urlNumber']) - 1];

                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(px_5),
                              padding: const EdgeInsets.all(px_3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: px_1, color: AppColors.white),
                                borderRadius: BorderRadius.circular(
                                    px_2), // Uniform radius
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      Text(
                                        'Index: ${mp['urlNumber']} | Api Index: ${mp['apiIndex']} |',
                                        style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: textSize_13),
                                      ),
                                      Text(
                                        'RequestType: ${mp['requestType']} | ',
                                        style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 13),
                                      ),
                                      const Text(
                                        'Total Time: ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: textSize_13),
                                      ),
                                      mp['duration'] == 'Loader'
                                          ? Container(
                                              width: 10,
                                              height: 10,
                                              margin: const EdgeInsets.only(
                                                  top: px_4, left: px_4),
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ))
                                          : Text(
                                              '${mp['duration']} millisec',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: textSize_13),
                                            ),
                                      const Text(
                                        ' | ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: textSize_13),
                                      ),
                                      Text("Status: ",
                                          style: TextStyle(
                                              color: mp['statusCode'] ==
                                                      'Loader'
                                                  ? Colors.white
                                                  : mp['statusCode'] == 200
                                                      ? AppColors.green
                                                      : mp['statusCode'] == 201
                                                          ? AppColors.green
                                                          : AppColors.red,
                                              fontSize: textSize_13)),
                                      mp['statusCode'] == 'Loader'
                                          ? Container(
                                              width: px_10,
                                              height: px_10,
                                              margin: const EdgeInsets.only(
                                                  top: 4, left: 4),
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ))
                                          : Text(
                                              '${mp['statusCode']} ',
                                              style: TextStyle(
                                                color: mp['statusCode'] == 200
                                                    ? AppColors.green
                                                    : mp['statusCode'] == 201
                                                        ? AppColors.green
                                                        : AppColors.red,
                                                fontSize: textSize_13,
                                              ),
                                            ),
                                    ],
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    spacing: 5,
                                    children: [
                                      Text(
                                        'URL: ${mp['url']}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: textSize_13),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          mp['resBody'] == 'Loader'
                                              ? CommonUiComponent().snackBar(
                                                  firstTitle:
                                                      'Try to Fetch data',
                                                  secondTitle: '')
                                              : Get.to(() => ResponsePage(
                                                    response: mp['resBody'],
                                                    mp: input,
                                                  ));
                                        },
                                        child: mp['resBody'] == 'Loader'
                                            ? Container(
                                                width: px_10,
                                                height: px_10,
                                                margin: const EdgeInsets.only(
                                                    top: px_4, left: px_4),
                                                child:
                                                    const CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ))
                                            : const Text('View Response ',
                                                style: TextStyle(
                                                    fontSize: textSize_13,
                                                    color: AppColors.blue)),
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
}
