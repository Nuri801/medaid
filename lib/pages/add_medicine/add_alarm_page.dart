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

    return Scaffold(
      appBar: AppBar(),
      body: Container(),
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
}
