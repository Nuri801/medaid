import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medaid/components/dory_constants.dart';
import 'package:medaid/components/dory_page_route.dart';
import 'package:medaid/pages/add_medicine/add_alarm_page.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({Key? key}) : super(key: key);

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {

  final _nameController = TextEditingController();
  File? _medicineImage;

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
        print('keyboard down');
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
                '어떤 약이예요 ?',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: largeSpace),
              Center(
                child: MedicineImageButton(
                  changedImageFile: (File? value) {
                    _medicineImage = value;
                  },
                ),
              ),

              const SizedBox(height: largeSpace + regularSpace),
              Text(
                '약 이름 ',
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
                onChanged: (_) => setState(() {}),

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
                onPressed:
                    _nameController.text.isEmpty ? null : _onAddAlarmPage,
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

  void _onAddAlarmPage() {
    Navigator.push(
      context,
      FadePageRoute(
        page: AddAlarmPage(
          medicineImage: _medicineImage,
          medicineName: _nameController.text,
        ),
      ),
    );
  }
}

class MedicineImageButton extends StatefulWidget {

  const MedicineImageButton({Key? key, required this.changedImageFile})
      : super(key: key);

  final ValueChanged<File?> changedImageFile;

  @override
  State<MedicineImageButton> createState() => _MedicineImageButtonState();
}

class _MedicineImageButtonState extends State<MedicineImageButton> {
  var _pickedImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: CupertinoButton(
        onPressed: _showModelBottomSheet,
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
    );
  }

  void _showModelBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return PickImageBottomSheet(
          onPressedCamera: () => _onPressed(ImageSource.camera),
          onPressedGallery: () => _onPressed(ImageSource.gallery),
        );
      },
    );
  }

  void _onPressed(ImageSource source) {
    Navigator.maybePop(context);
    ImagePicker().pickImage(source: source).then(
      (xfile) {
        if (xfile != null) {
          setState(
            () {
              _pickedImage = File(xfile.path);
              widget.changedImageFile(_pickedImage);
            },
          );
        }
      },
    );
  }

}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet(
      {Key? key, required this.onPressedCamera, required this.onPressedGallery})
      : super(key: key);
  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: onPressedCamera,
              child: const Text('카메라로 활영'),
            ),
            TextButton(
              onPressed: onPressedGallery,
              child: const Text('앨범에서 가져오기'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Auth key old methods:

// Future<void> getAuthKey() async {
//   String facilityNumb = equipmentList[curSelectedEquipIndex.value]['facilityNum'];
//   setAuthKeyButtonInUse(true);
//   var curTime = DateTime.now();
//   if (kDebugMode) {
//     print('+++ curTime : $curTime, authTime : $authTime');
//   }
//   if (authTime != null) {
//     Duration diff = curTime.difference(authTime!);
//     var diffMinutes = diff.inMinutes;
//
//     if (kDebugMode) {
//       print('+++ diffMinutes : $diffMinutes');
//     }
//
//     if (authKey.value != '--------' && diffMinutes <= 60) {
//       if (kDebugMode) {
//         print('+++ under 1 hour');
//       }
//
//       setShowIndicator(true);
//
//       Fluttertoast.showToast(
//         msg: 'auth_key_inform'.tr(),
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 2,
//         backgroundColor: Colors.white,
//         textColor: kBlackColor,
//         fontSize: 14,
//       );
//     }
//   }
//   if (kDebugMode) {
//     print('+++ getAuthKey:selectedEquipmentFacilityNumber : $selectedEquipmentFacilityNumber.value');
//   }
//
//   final response = await dioHTTPService.post(
//     path: '/equip/issue_reg_key',
//     body: {
//       "facilityNum": facilityNumb,
//     },
//   );
//
//   if (kDebugMode) {
//     print('+++ auth key response : $response');
//   }
//
//   if (response == null) {
//     setAuthKeyButtonInUse(false);
//     return;
//   }
//
//   var responseCode = response.data['code'];
//
//   if (responseCode == successCode) {
//     var regKey = response.data['regKey'];
//
//     if (kDebugMode) {
//       print('+++ auth key : $regKey');
//     }
//
//     setAuthKey(regKey);
//
//     authTime = DateTime.now();
//
//     setShowIndicator(true);
//
//     //====== 장비인증 진행상태 확인 API call=================
//     checkAuthStatus();
//     //=================================================
//   } else {
//     showErrorMsg(int.parse(responseCode), response.data['msg']);
//     setAuthKeyButtonInUse(false);
//   }
// }
//
// Future<void> checkAuthStatus() async {
//   String facilityNumb = equipmentList[curSelectedEquipIndex.value]['facilityNum'];
//   if (kDebugMode) {
//     print('+++ checkAuthStatus:selectedEquipmentFacilityNumber : $facilityNumb');
//   }
//
//   final response = await dioHTTPService.post(
//     path: '/equip/check_reg_status',
//     body: {
//       "facilityNum": facilityNumb,
//       "regKey": authKey.value,
//     },
//   );
//
//   if (kDebugMode) {
//     print('+++ checkAuthStatus response : $response');
//   }
//
//   var responseCode = response?.data['code'];
//
//   if (responseCode == successCode) {
//     // 등록 완료
//     var facilityNum = response?.data['data']['facilityNum'];
//     var regAuthYn = response?.data['data']['regAuthYn'];
//     var notiMsgAgreeYn = response?.data['data']['notiMsgAgreeYn'];
//
//     if (kDebugMode) {
//       print(
//           '+++ auth key result:facilityNum : $facilityNum, regAuthYn : $regAuthYn, notiMsgAgreeYn : $notiMsgAgreeYn');
//     }
//
//     setNUpdateSelectedEquipment(facilityNum, regAuthYn, notiMsgAgreeYn);
//     showAuthSuccessPopup();
//   } else {
//     // Fail
//     showAuthFailPopup();
//   }
//
//   setShowIndicator(false);
//   setAuthKeyButtonInUse(false);
// }
