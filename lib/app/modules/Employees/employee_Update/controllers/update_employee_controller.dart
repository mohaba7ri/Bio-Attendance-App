import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../../../widgets/toast/custom_toast.dart';

class UpdateEmployeeController extends GetxController {
  RxBool isLoading = false.obs;
  String? branchName;
  dynamic EmpDetail = Get.arguments;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> employee() async* {
    //  yield* firestore.collection('branch').where('branchId', isEqualTo: branchId).snapshots();
  }

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController adminPassC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController salaryPerHour = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBranch();
    print('branchName$branchName');
    bindData();
  }

  Future getBranch() async {
    await firestore
        .collection('branch')
        .where('branchId', isEqualTo: EmpDetail['branchId'])
        .get()
        .then((QuerySnapshot query) {
      query.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        branchName = data['name'];
        update();
        print('the name${data['name']}');
      });
    });
  }

  void bindData() {
    nameC.text = EmpDetail['name'];
    emailC.text = EmpDetail['email'];
    jobC.text = EmpDetail['job'];
    addressC.text = EmpDetail['address'];
    phoneC.text = EmpDetail['phone'];
    salaryPerHour.text = EmpDetail['salary'];
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    yield* firestore.collection("user").doc(EmpDetail['userId']).snapshots();
  }

  Future<void> updateEmployee() async {
    if (nameC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
        };

        await firestore
            .collection("user")
            .doc(EmpDetail['userId'])
            .update(data);

        Get.back();
        CustomToast.successToast('Success');
      } catch (e) {
        CustomToast.errorToast('Error');
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomToast.errorToast('Error');
    }
  }
}










  // Future<void> updateEmployee() async {
  //   String uid = sharedPreferences.getString('userId')!;
  //   if (employeeAddressC.text.isNotEmpty &&
  //       nameC.text.isNotEmpty &&
  //       emailC.text.isNotEmpty) {
  //     isLoading.value = true;
  //     try {
  //       Map<String, dynamic> data = {
  //         "name": nameC.text,
  //       };
  //       if (image != null) {
  //         // upload avatar image to storage
  //         File file = File(image!.path);
  //         String ext = image!.name.split(".").last;
  //         String upDir = "${uid}/avatar.$ext";
  //         await storage.ref(upDir).putFile(file);
  //         String avatarUrl = await storage.ref(upDir).getDownloadURL();

  //         data.addAll({"avatar": "$avatarUrl"});
  //       }
  //       await firestore.collection("user").doc(uid).update(data);
  //       image = null;
  //       Get.back();
  //       CustomToast.successToast('Success', 'Success Update Profile');
  //     } catch (e) {
  //       CustomToast.errorToast(
  //           'Error', 'Cant Update Profile. Err : ${e.toString()}');
  //     } finally {
  //       isLoading.value = false;
  //     }
  //   } else {
  //     CustomToast.errorToast('Error', 'You must fill all form');
  //   }
  // }

  // void pickImage() async {
  //   image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     print(image!.path);
  //     print(image!.name.split(".").last);
  //   }
  //   update();
  // }

  // void deleteProfile() async {
  //   String uid = sharedPreferences.getString('userId')!;
  //   try {
  //     await firestore.collection("user").doc(uid).update({
  //       "avatar": FieldValue.delete(),
  //     });
  //     Get.back();

  //     Get.snackbar("Successfully", "Successfully deleted avatar profile");
  //   } catch (e) {
  //     Get.snackbar("There is an error",
  //         "Unable to delete avatar profile. Because ${e.toString()}");
  //   } finally {
  //     update();
  //   }
  // }
