import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  static final firestore = FirebaseFirestore.instance;
  static final CollectionReference usersCollection =
      firestore.collection('users');
  static final CollectionReference postJobCollection =
      firestore.collection('postJob');
}
