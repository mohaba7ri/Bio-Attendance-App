import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CompanyDetailsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    companyInfo;
    getUsers();
    getBranches();
    companySettings;
  }

  int? userNumbers;
  int? branchNumbers;

  RxBool isloading = false.obs;
  dynamic companyInfo = Get.arguments;
  RxMap companySettings = {}.obs;
  //dynamic EmpList;
  FirebaseAuth auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getCompanySettings() async* {
    yield* firestore
        .collection('companySettings')
        .where('companyId', isEqualTo: companyInfo['companyId'])
        .snapshots();
  }

  Future getUsers() async {
    await firestore.collection('user').get().then((QuerySnapshot query) {
      userNumbers = query.size;

      print('number of users$userNumbers');
      update();
    });
  }

  Future getBranches() async {
    await firestore.collection('branch').get().then((QuerySnapshot query) {
      branchNumbers = query.size;
      update();
    });
  }
}
