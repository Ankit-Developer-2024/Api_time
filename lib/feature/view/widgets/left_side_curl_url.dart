import 'package:api_time/constant/AppColors.dart';
import 'package:api_time/constant/AppCustomDimension.dart';
import 'package:api_time/constant/widgets/CommonUIComponent.dart';
import 'package:api_time/feature/view/widgets/add_curl.dart';
import 'package:api_time/feature/view/widgets/add_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:api_time/feature/controller/HomePageController.dart';

class LeftSideCurlUrl extends StatelessWidget {
  LeftSideCurlUrl({super.key});
   final HomePageController controller = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
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
                          padding: const EdgeInsets.only(
                              left: px_5, top: px_7, bottom: px_7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(px_3),
                            border:
                                Border.all(width: 0.1, color: AppColors.white),
                            color: Colors.blue,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: controller.apiMethod.value,
                              dropdownColor:
                                  const Color.fromRGBO(211, 211, 211, 1),
                              iconEnabledColor: AppColors.white,
                              items: controller.requestMethod.map((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val,
                                      style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: textSize_13)),
                                );
                              }).toList(),
                              isDense: true,
                              padding: const EdgeInsets.only(left: px_5),
                              onChanged: (val) {
                                controller.apiMethod.value = val!;
                              },
                            ),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      ConstrainedBox(
                          constraints:
                              const BoxConstraints(minWidth: 65, minHeight: 40),
                          child: CommonUiComponent().button(
                              btnName: 'Add cURL/URL',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        scrollable: true,
                                        title: const Text(
                                            'Choose cURL or Api Detail',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: textSize_20)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(px_3),
                                        ),
                                        titlePadding:
                                            const EdgeInsets.only(top: px_10),
                                        contentPadding:
                                            const EdgeInsets.all(px_10),
                                        content: Obx(() {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        child: InkWell(
                                                      onTap: () {
                                                        controller.extractData
                                                            .value = 'cURL';
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: controller
                                                                      .extractData
                                                                      .value ==
                                                                  'cURL'
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .lightGrey,
                                                          border: Border(
                                                            top:
                                                                const BorderSide(
                                                              color: AppColors
                                                                  .grey,
                                                              width:
                                                                  borderWidth_1,
                                                            ),
                                                            right:
                                                                const BorderSide(
                                                              color: AppColors
                                                                  .grey,
                                                              width:
                                                                  borderWidth_1,
                                                            ),
                                                            left:
                                                                const BorderSide(
                                                              color: AppColors
                                                                  .grey,
                                                              width:
                                                                  borderWidth_1,
                                                            ),
                                                            bottom: controller
                                                                        .extractData
                                                                        .value ==
                                                                    'cURL'
                                                                ? BorderSide
                                                                    .none
                                                                : const BorderSide(
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                    width:
                                                                        borderWidth_1,
                                                                  ),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'cURL',
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontSize:
                                                                textSize_13,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                    Expanded(
                                                        child: InkWell(
                                                      onTap: () {
                                                        controller.extractData
                                                            .value = 'URL';
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: controller
                                                                      .extractData
                                                                      .value ==
                                                                  'URL'
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .lightGrey,
                                                          border: Border(
                                                            top:
                                                                const BorderSide(
                                                              color: AppColors
                                                                  .grey,
                                                              width:
                                                                  borderWidth_1,
                                                            ),
                                                            right:
                                                                const BorderSide(
                                                              color: AppColors
                                                                  .grey,
                                                              width:
                                                                  borderWidth_1,
                                                            ),
                                                            bottom: controller
                                                                        .extractData
                                                                        .value ==
                                                                    'URL'
                                                                ? BorderSide
                                                                    .none
                                                                : const BorderSide(
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                    width:
                                                                        borderWidth_1),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Api Detail',
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontSize:
                                                                textSize_13,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                  ]),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              controller.extractData.value ==
                                                      'URL'
                                                  ? AddUrl()
                                                  : AddCurl(),
                                            ],
                                          );
                                        }));
                                  },
                                );
                              })),
                      const SizedBox(
                        width: 5,
                      ),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 50, maxWidth: 100, minHeight: 40),
                          child: CommonUiComponent().button(
                              btnName: 'Clear',
                              onTap: () {
                                controller.urls?.clear();
                                controller.apiDetails?.clear();
                                controller.successRequest.value = 0;
                                controller.failedRequest.value = 0;
                              })),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    color: AppColors.grey,
                    height: MediaQuery.sizeOf(context).height - 95,
                    child: controller.urls == null
                        ? Container()
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: controller.urls?.length,
                            itemBuilder: (context, index) {
                              dynamic mp = controller.urls![index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(px_2),
                                ),
                                child: ListTile(
                                    leading: Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: textSize_13),
                                    ),
                                    title: Text(mp['url'],
                                        style: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: textSize_13)),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        mp['queryParameter']
                                                    .toString()
                                                    .length ==
                                                2
                                            ? const SizedBox()
                                            : Text(
                                                "QueryParameter: ${mp['queryParameter'].toString()} ",
                                                style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: textSize_11)),
                                        mp['data'] == null
                                            ? const SizedBox()
                                            : Text(
                                                "Data: ${mp['data'].toString()}",
                                                style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: textSize_11),
                                              )
                                      ],
                                    )),
                              );
                            }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: controller.apiCallCountController,
                          style: const TextStyle(
                              color: AppColors.textFieldTextColor,
                              fontSize: textFieldTextSize),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: "Api count ",
                            labelStyle: TextStyle(
                                color: AppColors.textFieldLabel,
                                fontSize: textFieldLabelSize),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldEnableColor,
                                  width: textFieldBorderWidth),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(textFieldBorderRadius)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldFocusedColor,
                                  width: textFieldBorderWidth),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(textFieldBorderRadius)),
                            ),
                            isDense: true,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              controller.apiCallCount.value = int.parse(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: controller.timeOutController,
                          style: const TextStyle(
                              color: AppColors.textFieldTextColor,
                              fontSize: textFieldTextSize),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: "Api timeout(millisec)",
                            labelStyle: TextStyle(
                                color: AppColors.textFieldLabel,
                                fontSize: textFieldLabelSize),
                            focusColor: Colors.black,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldEnableColor,
                                  width: textFieldBorderWidth),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(textFieldBorderRadius)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldFocusedColor,
                                  width: textFieldBorderWidth),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(textFieldBorderRadius)),
                            ),
                            isDense: true,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              controller.apiTimeOut.value = int.parse(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: controller.apiIntervalController,
                          style: const TextStyle(
                              color: AppColors.textFieldTextColor,
                              fontSize: textFieldTextSize),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: "Interval (millisec)",
                            labelStyle: TextStyle(
                                color: AppColors.textFieldLabel,
                                fontSize: textFieldLabelSize),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldEnableColor,
                                  width: textFieldBorderWidth),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(textFieldBorderRadius)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldFocusedColor,
                                  width: textFieldBorderWidth),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(textFieldBorderRadius)),
                            ),
                            isDense: true,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              controller.apiInterval.value = int.parse(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                          flex: 1,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 40),
                            child: CommonUiComponent().button(
                                btnName: 'Submit',
                                onTap: () {
                                  controller.apiDetails?.clear();
                                  controller.successRequest.value = 0;
                                  controller.failedRequest.value = 0;
                                  if (controller.urls != null &&
                                      controller.urls!.isNotEmpty) {
                                    controller.startCallingApi();
                                  } else {
                                    CommonUiComponent().snackBar(
                                        firstTitle:
                                            'Please add at least one cURL or URL',
                                        secondTitle: "");
                                  }
                                }),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
