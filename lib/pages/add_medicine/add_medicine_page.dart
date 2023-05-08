import 'dart:io';
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

  // void _onAddAlarmPage() {
  //   Navigator.push(
  //     context,
  //     FadePageRoute(
  //       page: AddAlarmPage(
  //         medicineImage: _medicineImage,
  //         medicineName: _nameController.text,
  //       ),
  //     ),
  //   );
  // }
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

/// ShowErr old methods

// showErrorMsg(int errCode, String? errTitle) {
//   if (kDebugMode) {
//     print('+++ showErrorMsg:context : $context');
//   }
//
//   if (context == null) {
//     showErrorToast(getErrTitle(errCode, errTitle ?? 'err_err_in_process_title'.tr()), getErrMsg(errCode));
//     if (errCode == 4190) {
//       if (logOut != null) {
//         logOut!();
//       } else {
//         mainControllerOnLogOut();
//         Get.offAll(() => const LogInPage());
//       }
//     }
//     return;
//   }
//
//   CommonPopUp(
//     dragDismissible: errCode != 4190,
//     outsideTouchDismissible: errCode != 4190,
//     context: context!,
//     mainText: getErrTitle(errCode, errTitle ?? 'err_err_in_process_title'.tr()),
//     secondaryText: getErrMsg(errCode),
//     onTapConfirm: () {
//       Navigator.pop(context!);
//       if (errCode == 4190) {
//         // 로그 아웃 상황
//         if (logOut != null) {
//           logOut!();
//         } else {
//           mainControllerOnLogOut();
//           Get.offAll(() => const LogInPage());
//         }
//       }
//     },
//   ).pop();
// }
//
// String getErrTitle(int errCode, errTitle) {
//   switch (errCode) {
//     case 4000:
//       errTitle = 'err_parameter_not_matched_title'.tr();
//       break;
//     case 4010:
//       errTitle = 'err_api_auth_fail_title'.tr();
//       break;
//     case 4011:
//       errTitle = 'err_trace_id_missed_title'.tr();
//       break;
//     case 4012:
//       errTitle = 'err_session_key_missed_title'.tr();
//       break;
//     case 4190:
//       errTitle = 'err_session_timeout_title'.tr();
//       break;
//     case 5000:
//       errTitle = 'err_err_in_process_title'.tr();
//       break;
//     case 5040:
//       errTitle = 'err_destination_timeout_title'.tr();
//       break;
//     case 5041:
//       errTitle = 'err_user_response_timeout_title'.tr();
//       break;
//     case 5042:
//       errTitle = 'err_device_response_timeout_title'.tr();
//       break;
//     case 9000:
//       errTitle = 'err_system_check_title'.tr();
//       break;
//     case 5130:
//       errTitle = 'device_id_mismatch_while_using'.tr();
//       break;
//   }
//   return errTitle;
// }
//
// String getErrMsg(int errCode) {
//   String errMsg = '';
//
//   switch (errCode) {
//     case 4000:
//     case 4010:
//     case 4011:
//     case 4012:
//     case 5000:
//     case 5041:
//     case 5042:
//     case 5040:
//       errMsg = 'try_function_contents'.tr(); // 다시 시도
//       break;
//     case 4190:
//     case 5130:
//       errMsg = 'app_session_timeout_contents'.tr(); // 다시 로그인
//       break;
//     case 9000:
//       errMsg = 'system_check_time_contents'.tr(); // 서버 점검 시간
//       break;
//   }
//
//   return errMsg;
// }
//
// void showErrorToast(String errorTitle, String errorMessage) {
//   Fluttertoast.showToast(
//     backgroundColor: kToastBackGroundColor,
//     textColor: kBlackColor,
//     msg: "$errorTitle $errorMessage",
//     fontSize: 14.0,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 2,
//   );
// }