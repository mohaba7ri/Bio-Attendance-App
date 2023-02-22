import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeDetailController extends GetxController {
  dynamic EmpList = Get.arguments;
  String? branchName;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> employee() async* {
    //  yield* firestore.collection('branch').where('branchId', isEqualTo: branchId).snapshots();
  }

  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBranch();
    print('branchName$branchName');
  }

  Future getBranch() async {
    await firestore
        .collection('branch')
        .where('branchId', isEqualTo: EmpList['branchId'])
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    yield* firestore.collection("user").doc(EmpList['userId']).snapshots();
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTodayPresence() async* {
    String uid =  EmpList['userId'];
   
    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    yield* firestore
        .collection("user")
        .doc(uid)
        .collection("presence")
        .doc(todayDocId)
        .snapshots();
  }
}
