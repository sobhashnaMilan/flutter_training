import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_training/controller/PlatformChannelsController.dart';
import 'package:flutter_training/utils/common/app_bar.dart';
import 'package:flutter_training/utils/styles_utils.dart';
import 'package:get/get.dart';

class PlatformChannelsScreen extends StatefulWidget {
  const PlatformChannelsScreen({Key? key}) : super(key: key);

  @override
  State<PlatformChannelsScreen> createState() => _PlatformChannelsScreenState();
}

class _PlatformChannelsScreenState extends State<PlatformChannelsScreen> {
  PlatformChannelsController controller =
      Get.find<PlatformChannelsController>();

  @override
  void initState() {
    super.initState();
    flutterPrint(msg: controller.name.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        toolbarText: 'Platform Channels',
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: controller.textField,
                      decoration: const InputDecoration(
                        labelText: 'Enter Value',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Obx(
                          () => Text(controller.namePlatformChannels.value)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: printLog,
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 2.0, color: Colors.blue)),
                          child: const Text("Print Log"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: openDialog,
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 2.0, color: Colors.blue)),
                          child: const Text("Show Dialog"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => getData(controller.textField.value),
                      child: const Text("Get Data"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getData(String value) async {
    try {
      final String result =
          await controller.platform.invokeMethod('getValue', {"text": value});
      controller.namePlatformChannels.value = result;
      flutterPrint(msg: result);
    } on PlatformException catch (e) {
      controller.namePlatformChannels.value =
          "Failed to Invoke: '${e.message}'.";
    }
  }

  void printLog() async {
    try {
      final String result = await controller.platform.invokeMethod('printLog');
      controller.namePlatformChannels.value = result;
      flutterPrint(msg: result);
    } on PlatformException catch (e) {
      controller.namePlatformChannels.value =
          "Failed to Invoke: '${e.message}'.";
    }
  }

  void openDialog() async {
    try {
      final String result =
          await controller.platform.invokeMethod('openDialog');
      controller.namePlatformChannels.value = result;
      flutterPrint(msg: result);
    } on PlatformException catch (e) {
      controller.namePlatformChannels.value =
          "Failed to Invoke: '${e.message}'.";
    }
  }
}
