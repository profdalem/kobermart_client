import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kobermart_client/app/models/Tokens.dart';

class Member extends Tokens {
  late String name;
  late String imgrul;

  Member.fromFirebase(QueryDocumentSnapshot doc) : super.fromFirebaseSnapshot(doc) {
    dynamic docdata = doc.data();
    name = docdata["name"];
    imgrul = docdata["imgurl"];
  }

  Member.fromFirebaseSnapshot(DocumentSnapshot doc) : super.fromFirebaseSnapshot(doc) {
    dynamic docdata = doc.data();
    id = doc.id;
    name = docdata["name"];
    imgrul = docdata["imgurl"];
  }
}
