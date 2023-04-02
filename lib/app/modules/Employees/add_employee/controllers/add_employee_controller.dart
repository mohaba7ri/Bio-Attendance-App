import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../company_data.dart';
import '../../../../widgets/dialog/custom_alert_dialog.dart';
import '../../../../widgets/toast/custom_toast.dart';

class AddEmployeeController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await getBranches();
  }

  @override
  onClose() {
    salaryPerHour.dispose();
    nameC.dispose();
    emailC.dispose();
    adminPassC.dispose();
  }

  final SharedPreferences sharedPreferences;
  AddEmployeeController({required this.sharedPreferences});
  GetStorage store = new GetStorage();

  String? roleValue;
  String? branchValue;

  var roleList = ['Employee', 'Admin'];

  bool isLoading = false;
  bool isLoadingCreatePegawai = false;
  bool isSelectedPolicy = false;

  String branchId = '123';
  dynamic userData = Get.arguments;
  //this list to store the roles in firebase for each user
  final List<RxString> listSelectedPolicy = [];
  final branchesList = <DropdownMenuItem<String>>[].obs;

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController adminPassC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController salaryPerHour = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var rolesValues = {};

//this list of all roles  from type bool
  List<RxBool>? selectedPolicyValue;
  //this function to fill the selectedPolicyValue list with false value  and when you check any checkbox the
  //value will change to true

  String getDefaultPassword() {
    return CompanyData.defaultPassword;
  }

  changeRoleValue(value) {
    update();
    roleValue = value;
  }

  changeBranchValue(value) async {
    branchValue = value;
    update();
    await firestore
        .collection('branch')
        .where('name', isEqualTo: branchValue)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        branchId = data['branchId'];
        update();
      });
    });
  }

  String getDefaultRole() {
    return CompanyData.defaultRole;
  }

  Future getBranches() async {
    final branches = FirebaseFirestore.instance.collection('branch');
    try {
      await branches.get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data();

          branchesList.add(
            DropdownMenuItem(
              child: Text(data['name']),
              value: data['name'],
            ),
          );
          update();
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

//this function to store the selected roles in the firebase

//this function to store the the selected roles base on the checked box
//will store the name of the check box base on the index and only if the value is true means the checkbox
//is being selected

  Future<void> addEmployee() async {
    if (salaryPerHour.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        jobC.text.isNotEmpty &&
        phoneC.text.isNotEmpty &&
        addressC.text.isNotEmpty) {
      if (listSelectedPolicy.isEmpty) {
        isLoading = true;
        update();
        CustomAlertDialog.confirmAdmin(
          title: 'Admin_confirmation'.tr,
          message: 'adminConfirm'.tr,
          onCancel: () {
            isLoading = false;
            update();
            Get.back();
          },
          onConfirm: () async {
            if (isLoadingCreatePegawai == false) {
              await createEmployeeData();
              isLoading = false;
              update();
            }
          },
          controller: adminPassC,
        );
      }
    } else {
      isLoading = false;
      CustomToast.errorToast('you need to fill all form');
      update();
    }
  }

  Future<void> createEmployeeData() async {
    isSelectedPolicy = true;
    update();

    if (adminPassC.text.isNotEmpty) {
      isLoadingCreatePegawai = true;
      String adminEmail = auth.currentUser!.email!;
      try {
        //checking if the pass is match
        await auth.signInWithEmailAndPassword(
            email: adminEmail, password: adminPassC.text);
        //get default password
        String defaultPassword = getDefaultPassword();
        String defaultRole = getDefaultRole();
        // if the password is match, then continue the create user process
        UserCredential employeeCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: defaultPassword,
        );

        if (employeeCredential.user != null) {
          RxString uid = employeeCredential.user!.uid.obs;
          //  newUserId!.value = uid.value;

          DocumentReference employee =
              firestore.collection("user").doc(uid.value);
          await employee.set({
            "salaryPerHour": salaryPerHour.text,
            "name": nameC.text,
            "email": emailC.text,
            "role": userData['role'] == 'SuperAdmin' ? roleValue : 'Employee',
            "job": jobC.text,
            "phone": phoneC.text,
            "address": addressC.text,
            "status": "Active",
            "userId": uid.value,
            "createdAt": DateTime.now().toIso8601String(),
            "branchId": userData['role'] == 'SuperAdmin'
                ? branchId
                : userData['branchId'],
          }).whenComplete(() {
            if (isSelectedPolicy == true) {
              store.write('userID', uid.value);
            }
          });

          // if (selectedPolicyValue != null && selectedPolicyValue!.length > 0) {
          //   await role.collection('policy').doc(uid.value).set({
          //     'roles': {
          //       'Add Branch': selectedPolicyValue![0].value,
          //       'Stop Branch': selectedPolicyValue![1].value,
          //       'Modify Branch ': selectedPolicyValue![2].value,
          //       'Add Employee': selectedPolicyValue![3].value,
          //       'Stop Employee': selectedPolicyValue![4].value,
          //       'Modify Employee': selectedPolicyValue![5].value,
          //       'Employee Reports': selectedPolicyValue![6].value,
          //       'Attendance Report': selectedPolicyValue![7].value,
          //       'Manage Vacation': selectedPolicyValue![8].value,
          //     }
          //   });
          // }
          if (selectedPolicyValue != null && selectedPolicyValue!.length > 0) {
            var rolesValues = {};
          }

          await employeeCredential.user!.sendEmailVerification();

          //need to logout because the current user is changed after adding new user
          auth.signOut();
          // need to relogin to admin account
          await auth.signInWithEmailAndPassword(
              email: adminEmail, password: adminPassC.text);

          // clear form

          Get.back(); //close dialog
          Get.back(); //close form screen
          CustomToast.successToast('success adding employee');

          isLoadingCreatePegawai = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingCreatePegawai = false;
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          CustomToast.errorToast('default password too short');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          CustomToast.errorToast('Employee already exist');
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast('wrong passowrd');
        } else {
          CustomToast.errorToast('error : ${e.code}');
          print("the problem is ${e.code}");
        }
      } catch (e) {
        isLoadingCreatePegawai = false;
        CustomToast.errorToast('error : ${e}');
        print('the error is ${e}');
      }
    } else {
      CustomToast.errorToast('you need to input password');
    }
  }
}
