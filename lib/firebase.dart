import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> Members = db.collection("members");
final storageRef = FirebaseStorage.instance.ref();
final profileRef = storageRef.child("profile/");
