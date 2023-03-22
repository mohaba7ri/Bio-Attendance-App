import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../widgets/toast/custom_toast.dart';

class CompanyDetailsController extends GetxController {
  RxMap office = {}.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    companyInfo;
    getUsers();
    getBranches();
    companySettings;
  }

  Future getCompany() async {
    try {
      await firestore.collection('company').get().then((query) {
        query.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data();
          print('the latitude${data["position"][" latitude"]}');
          if (data["position"][" latitude"] != null &&
              data["position"]["longitude"] != null) {
            print('the latitude${data["position"][" latitude"]}');
            office["latitude"] = double.parse(data["position"][" latitude"]);
            office["longitude"] = double.parse(data["position"]["longitude"]);
            print(office["longitude"]);
          } else {
            print('true');
          }
        });
      });
    } catch (e) {
      print('something went wrong$e');
    }
  }

  launchOfficeOnMap() {
    try {
      MapsLauncher.launchCoordinates(
        office['latitude'],
        office['longitude'],
      );
    } catch (e) {
      CustomToast.errorToast('Error : ${e}');
    }
  }

  int? userNumbers;
  int? branchNumbers;

  RxBool isloading = false.obs;
  dynamic companyInfo = Get.arguments;
  RxMap companySettings = {}.obs;

  //dynamic EmpList;
  FirebaseAuth auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getBranchSettings() async* {
    yield* firestore
        .collection('branchSettings')
        .where('branchId', isEqualTo: companyInfo['companyId'])
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
