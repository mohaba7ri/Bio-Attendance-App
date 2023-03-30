import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListEmployeeController extends GetxController {
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await getBranches();
  }

  //dynamic EmpList;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final branchesList = <DropdownMenuItem<String>>[].obs;
  String? branchValue;
  dynamic userIfon = Get.arguments;

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

  String? branchId;

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

  Stream<QuerySnapshot<Map<String, dynamic>>> Employee() async* {
    print("called");
    // String uid = sharedPreferences.getString('userId')!;
    if (userIfon['role'] == 'SuperAdmin') {
      if (branchId == null) {
        yield* firestore.collection("user").snapshots();
      } else {
        yield* firestore
            .collection("user")
            .where('branchId', isEqualTo: branchId)
            .snapshots();
      }
    } else {
      yield* firestore
          .collection("user")
          .where('branchId', isEqualTo: userIfon['branchId'])
          .snapshots();
    }
  }
}
