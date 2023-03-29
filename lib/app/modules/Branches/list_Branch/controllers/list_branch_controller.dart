import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListBranchController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    role = sharedPreferences.getString('role');
  }

  String? role;
  final SharedPreferences sharedPreferences;
  ListBranchController({required this.sharedPreferences});
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> branch() async* {
    String? userId = sharedPreferences.getString('userId');
    if (role == 'SuperAdmin') {
      yield* firestore.collection('branch').snapshots();
    } else {
      yield* firestore
          .collection('branch')
          .where('branchAdminId', isEqualTo: userId)
          .snapshots();
    }
  }
}
