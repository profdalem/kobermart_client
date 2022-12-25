import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

final UpdateRef = db.collection("update");

final storageRef = FirebaseStorage.instance.ref();
final profileRef = storageRef.child("profile/");

final Auth = FirebaseAuth.instance;
final Members = db.collection("members");
final MembersInfo = db.collection("membersInfo");
final GlobalTrx = db.collection("globaltrx");
final AppSettings = db.collection("settings");
final Prepaid = db.collection("prepaid_pricelist");
final PrepaidPricelist = db.collection("iak_prepaid");
