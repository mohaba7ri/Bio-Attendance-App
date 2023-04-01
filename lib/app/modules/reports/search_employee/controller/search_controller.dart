import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  String searchValue = '';
  changeSearchValue(String value) {
    searchValue = value;
    update();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> employee() async* {
    yield* firestore.collection('user').snapshots();
  }
}
