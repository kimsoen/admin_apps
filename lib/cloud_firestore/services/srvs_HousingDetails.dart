import 'package:admin_apps/cloud_firestore/class/clsHousingDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String collectionName = "test";

class Srvshousingdetails {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference _housingRef;

  Srvshousingdetails() {
    _housingRef = _firestore
        .collection(collectionName)
        .withConverter<Clshousingdetails>(
            fromFirestore: (snapshot, _) =>
                Clshousingdetails.fromJson(snapshot.data()!),
            toFirestore: (testTest, _) => testTest.toJson());
  }

  // Services

  // Add data
  void addData(Clshousingdetails housings) async {
    await _housingRef.add(housings);
  }
}
