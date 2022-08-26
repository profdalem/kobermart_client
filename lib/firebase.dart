import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> Members = db.collection("members");
