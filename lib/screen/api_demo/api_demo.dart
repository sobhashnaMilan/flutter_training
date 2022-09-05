import 'package:flutter/material.dart';
import 'package:flutter_training/utils/app_string.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../controller/api_demo_controller.dart';
import '../../utils/common/app_bar.dart';
import '../../utils/network_utils.dart';
import '../../utils/styles_utils.dart';

class ApiDemo extends StatefulWidget {
  const ApiDemo({Key? key}) : super(key: key);

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  ApiDemoController controller = ApiDemoController();

  @override
  void initState() {
    super.initState();
    userAPICall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(toolbarText: "Api Demo"),
      body: Padding(
          padding: EdgeInsets.only(
              top: setMediaQuery(context: context).longestSide * 0.02,
              left: setMediaQuery(context: context).longestSide * 0.02,
              right: setMediaQuery(context: context).longestSide * 0.02),
          child: userList(context)),
    );
  }

  /// list view builder

  Widget userList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Obx(
            () => ListView.builder(
                itemCount: controller.userList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: setMediaQuery(context: context).height * 0.09,
                    child: buildRowItem(controller.userList[index]),
                  );
                }),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                userAddAPICall();
              },
              child: Text(AppString().btnAddUser)),
        ),
      ],
    );
  }

  /// listview Row item

  Widget buildRowItem(userList) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: EdgeInsets.all(
          setMediaQuery(context: context).longestSide * 0.01,
        ),
        child: Text(
          userList["name"],
        ),
      ),
    );
  }

  /// get user list api call [Get Method]

  userAPICall() {
    isNetworkConnected().then(
      (connection) {
        if (connection) {
          controller.userListAPICall(
            onSuccess: (msg) {
              showSuccessToast(context, msg);
              flutterPrint(msg: '${controller.userList}');
            },
            onError: (msg) {
              showErrorToast(context, msg);
            },
            onRequestTimeOut: (msg) {
              showErrorToast(context, msg);
            },
          );
        } else {
          showErrorToast(context, controller.message.msgInternetMessage);
        }
      },
    );
  }

  /// add user list api call [Post Method]

  userAddAPICall() {
    isNetworkConnected().then(
      (connection) {
        if (connection) {
          controller.userAddAPICall(
            name: "agile",
            job: "dev",
            onSuccess: (msg) {
              showSuccessToast(context, msg);
            },
            onError: (msg) {
              showErrorToast(context, msg);
            },
            onRequestTimeOut: (msg) {
              showErrorToast(context, msg);
            },
          );
        } else {
          showErrorToast(context, controller.message.msgInternetMessage);
        }
      },
    );
  }
}
