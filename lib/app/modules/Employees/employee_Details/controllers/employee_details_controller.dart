import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class employeeDetailController extends GetxController {
  
    dynamic EmpList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> employee() async* {
  //  yield* firestore.collection('branch').where('branchId', isEqualTo: branchId).snapshots();
  }

   void onInit() {
    // TODO: implement onInit
    super.onInit();
  

    branchInfo;
  }

RxMap branchInfo = {}.obs;

   Stream<QuerySnapshot<Map<String, dynamic>>> getBranchName() async* {
    yield* firestore
        .collection('branch')
        .where('name', isEqualTo: EmpList['branchId'])
        .snapshots();
  } 
}
