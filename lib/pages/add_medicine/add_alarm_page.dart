import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/dory_constants.dart';

class AddAlarmPage extends StatelessWidget {
  AddAlarmPage({
    Key? key,
    required this.medicineImage,
    required this.medicineName,
  }) : super(key: key);

  final File? medicineImage;
  final String medicineName;

  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: pageUI(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle1,
              ),
              child: const Text('완료'),
            ),
          ),
        ),
      ),
    );
  }

  // Widget pageUI() {
  //   return SafeArea(
  //     child: Column(
  //       children: [
  //         medicineImage == null ? Container() : Image.file(medicineImage!),
  //         Text(medicineName),
  //       ],
  //     ),
  //   );
  // }

  Widget pageUI() {
    return WillPopScope(
      onWillPop: () async {
        if (!mainController.firstPress) {
          firstPressTime = DateTime.now();

          print("first time press: $firstPressTime");

          var snackBar = const SnackBar(
            duration: Duration(seconds: 2),
            content: Center(
              child: Text('press another time to exit from app'),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          mainController.firstPress = true;
          mainController.secondPress = true;
          return Future.value(false);
        }

        if (mainController.secondPress) {
          secondPressTime = DateTime.now();
          if (kDebugMode) {
            print("secondTime press: $secondPressTime");
          }

          final difference = secondPressTime.difference(firstPressTime);
          if (kDebugMode) {
            print("time difference: $difference");
          }

          if (difference.inSeconds < 2) {
            mainController.firstPress = false;
            mainController.secondPress = false;
            return Future.value(true);
          } else {
            var snackBar = const SnackBar(
              duration: Duration(seconds: 2),
              content: Center(
                child: Text('press another time to exit from app'),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            mainController.firstPress = false;
            mainController.secondPress = false;
            return Future.value(false);
          }
        }
        mainController.secondPress = true;
        return Future.value(false);
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 19,
          ),
          child: Container(
            height: deviceHeight,
            width: deviceWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.deepOrange,
                  width: deviceWidth,
                  height: 20,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

}
