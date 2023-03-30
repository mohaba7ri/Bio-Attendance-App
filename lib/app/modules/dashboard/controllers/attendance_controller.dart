import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController {
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getUsers();
    getAllSubCollectionDocuments();
  }

  int? PresentNumber;

  var firestore = FirebaseFirestore.instance;

  String? username;
  // A list of months to display in the dropdown menu
  final months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  // The currently selected month (defaults to the current month)
  var selectedMonth = DateTime.now().month.obs;

  // The total number of hours worked for the selected month
  var totalHours = 0.obs;

  // The number of hours the user was late for the selected month
  var lateHours = 0.obs;

  // The user's hourly rate
  final hourlyRate = 10.0;

  // A function to calculate the user's salary based on the total hours worked
  double get salary => totalHours.value * hourlyRate;

  // Future getUsers() async {
  //   await firestore
  //       .collection('user')
  //       .doc()
  //       .collection('presence')
  //       .get()
  //       .then((QuerySnapshot query) {
  //     PresentNumber = query.size;

  //     print('number of presence$PresentNumber');
  //     update();
  //   });
  // }

  Future<void> getUsers() async {
    final querySnapshot = await firestore.collection('user').get();

    PresentNumber = querySnapshot.size;

    print('number of presence$PresentNumber');
    update();
  }

  Future<List<Map<String, dynamic>>> getAllSubCollectionDocuments() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? uid = sharedPreferences.getString('userId');
    List<Map<String, dynamic>> documents = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection("user")
          .doc(uid)
          .collection("presence")
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        QuerySnapshot<Map<String, dynamic>> subCollectionSnapshot =
            await firestore
                .collection("user")
                .doc(uid)
                .collection("presence")
                .get();

        // Process the sub-collection documents here
        for (QueryDocumentSnapshot<Map<String, dynamic>> subDocumentSnapshot
            in subCollectionSnapshot.docs) {
          // Access the sub-collection document data here
          Map<String, dynamic> data = subDocumentSnapshot.data();
          documents.add(data);
          print('result = $documents');
        }
        print('result = $documents');
      }
    } catch (e) {
      print('error $e');
    }
    print('result = $documents');
    return documents;
  }
}
