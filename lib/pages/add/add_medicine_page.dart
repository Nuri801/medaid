import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('어떤 약이예요?', style: Theme.of(context).textTheme.headline4,),
            CupertinoButton(
              onPressed: (){},
              child: Center(
                child: CircleAvatar(
                  radius: 40,
                  child: const Icon(
                    CupertinoIcons.photo_camera_solid,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text('약 이름', style: Theme.of(context).textTheme.subtitle1,),
            TextFormField(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            textStyle: Theme.of(context).textTheme.subtitle1,
          ),
          child: Text('다음'),
        ),
      ),
    );
  }
}
