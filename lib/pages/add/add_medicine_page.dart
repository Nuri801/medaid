import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medaid/components/dory_constants.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _nameController = TextEditingController();

  var _pickedImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
        ),
        body: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: largeSpace),
              Text(
                '어떤 약이예요?',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: largeSpace),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  child: CupertinoButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SafeArea(
                              child: Padding(
                                padding: pagePadding,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.maybePop(context);
                                        ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera)
                                            .then((xfile) {
                                          if (xfile != null) {
                                            setState(() {
                                              _pickedImage = File(xfile.path);
                                            });
                                          }
                                        });
                                      },
                                      child: const Text('카메라로 활영'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.maybePop(context);
                                        ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery)
                                            .then((xfile) {
                                          if (xfile != null) {
                                            setState(() {
                                              _pickedImage = File(xfile.path);
                                            });
                                          }
                                        });
                                      },
                                      child: const Text('앨범에서 가져오기'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    padding: _pickedImage == null ? null : EdgeInsets.zero,
                    child: _pickedImage == null
                        ? const Icon(
                            CupertinoIcons.photo_camera_solid,
                            size: 30,
                            color: Colors.white,
                          )
                        : CircleAvatar(
                            radius: 40,
                            foregroundImage: FileImage(_pickedImage!),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: largeSpace + regularSpace),
              Text(
                '약 이름',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextFormField(
                controller: _nameController,
                maxLength: 20,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: '복용할 약 이름을 기억해 주세요.',
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                  contentPadding: textFieldContentPadding,
                ),
              ),
            ],
          ),
        ),
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
                child: const Text('다음'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
