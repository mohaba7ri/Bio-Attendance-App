import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presence/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';
import 'package:presence/company_data.dart';

class AddEmployeeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBranches();
  }

  @override
  onClose() {
    idC.dispose();
    nameC.dispose();
    emailC.dispose();
    adminPassC.dispose();
  }

  GetStorage store = new GetStorage();

  RxString roleValue = 'Please Select'.obs;
  RxString branchValue = 'Please Select'.obs;
  var roleList = ['Please Select', 'Admin', 'Employee'];
  RxBool isLoading = false.obs;
  RxBool isLoadingCreatePegawai = false.obs;
  RxBool isSelectedPolicy = false.obs;
  RxString newUserId = ''.obs;
  RxString branchId = '123'.obs;
  //this list to store the roles in firebase for each user
  final List<RxString> listSelectedPolicy = [];
  final branchesList = <DropdownMenuItem<String>>[].obs;
  TextEditingController idC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController adminPassC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore role = FirebaseFirestore.instance;
  var rolesValues = {};
  final List<RxString> roles = [
    'Add Branch'.obs,
    'Stop Branch'.obs,
    'Modify Branch Setting'.obs,
    'Add Employee'.obs,
    'Stop Employee'.obs,
    'Modify Employee'.obs,
    'Employee Reports'.obs,
    'Attendance Report'.obs,
    'Manage Vacation'.obs,
  ];
//this list of all roles  from type bool
  List<RxBool>? selectedPolicyValue;
  //this function to fill the selectedPolicyValue list with false value  and when you check any checkbox the
  //value will change to true
  rolesValue() {
    selectedPolicyValue = List.filled(roles.length, false.obs);
  }

  changePolicyValue(bool value, int index) {
    selectedPolicyValue![index].value = value;
    for (var i = 0; i < roles.length; i++) {
      rolesValues[roles[i].value] = selectedPolicyValue![i].value;
    }
    print('roles${rolesValues}');
    print(selectedPolicyValue![index].value);
    // print(
    //     'roles${rolesValues[roles[index].value] = selectedPolicyValue![index].value}');
  }

  String getDefaultPassword() {
    return CompanyData.defaultPassword;
  }

  changeRoleValue(value) {
    roleValue.value = value;
  }

  changeBranchValue(value) async {
    branchValue.value = value;
    await firestore
        .collection('branch')
        .where('name', isEqualTo: branchValue.value)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        branchId.value = data['branchId'];
      });
    });
  }

  String getDefaultRole() {
    return CompanyData.defaultRole;
  }

  void getBranches() {
    final branches = FirebaseFirestore.instance.collection('branch');
    try {
      branches.get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data();

          branchesList.add(
            DropdownMenuItem(
              child: Text(data['name']),
              value: data['name'],
            ),
          );
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
  storePolicyValue(int index, bool value) {
    if (value) {
      listSelectedPolicy.add(roles[index].obs.value);
    } else {
      listSelectedPolicy.remove(roles[index].obs.value);
    }
    // Get.defaultDialog(title: 'hello');

    print(listSelectedPolicy.toList());
  }

  Future<void> addEmployee() async {
    if (idC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        jobC.text.isNotEmpty &&
        phoneC.text.isNotEmpty &&
        addressC.text.isNotEmpty) {
      if (listSelectedPolicy.isEmpty) {
        isLoading.value = true;
        CustomAlertDialog.confirmAdmin(
          title: 'Admin confirmation',
          message:
              'you need to confirm that you are an administrator by inputting your password',
          onCancel: () {
            isLoading.value = false;
            Get.back();
          },
          onConfirm: () async {
            if (isLoadingCreatePegawai.isFalse) {
              await createEmployeeData();
              isLoading.value = false;
            }
          },
          controller: adminPassC,
        );
      }
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'you need to fill all form');
    }
  }

  changeid() async {
    print('object');
    if (selectedPolicyValue != null && selectedPolicyValue!.length > 0) {
      print('hi');
      try {
        print('hi');
        await role.collection('policy').doc('555').set({'roles': rolesValues});
      } catch (e) {
        print('error${e.toString()}');
      }
    }
  }

  Future<void> createEmployeeData() async {
    isSelectedPolicy.value = true;
    isSelectedPolicy.update((val) {
      isSelectedPolicy.value = true;
    });
    selectedPolicyValue = List.filled(roles.length, false.obs);
    if (adminPassC.text.isNotEmpty) {
      isLoadingCreatePegawai.value = true;
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
            "usrId": idC.text,
            "name": nameC.text,
            "email": emailC.text,
            "role": roleValue.value,
            "job": jobC.text,
            "phone": phoneC.text,
            "address": addressC.text,
            "status": "Active",
            "createdAt": DateTime.now().toIso8601String(),
            "branchId": branchId.value,
          }).whenComplete(() {
            if (isSelectedPolicy.value == true) {
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
            for (var i = 0; i < roles.length; i++) {
              rolesValues[roles[i].value] = selectedPolicyValue![i].value;
            }
            await role
                .collection('policy')
                .doc(uid.value)
                .set({'roles': rolesValues});
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
          CustomToast.successToast('Success', 'success adding employee');

          isLoadingCreatePegawai.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingCreatePegawai.value = false;
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          CustomToast.errorToast('Error', 'default password too short');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          CustomToast.errorToast('Error', 'Employee already exist');
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast('Error', 'wrong passowrd');
        } else {
          CustomToast.errorToast('Error', 'error : ${e.code}');
          print("the problem is ${e.code}");
        }
      } catch (e) {
        isLoadingCreatePegawai.value = false;
        CustomToast.errorToast('Error', 'error : ${e}');
        print('the error is ${e}');
      }
    } else {
      CustomToast.errorToast('Error', 'you need to input password');
    }
  }
}
