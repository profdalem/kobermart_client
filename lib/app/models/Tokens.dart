import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kobermart_client/firebase.dart';

class Tokens {
  late String id;
  late String tokenCode;
  late String tokenReg;
  late String tokenCreator;
  late String upline;
  late bool tokenUsed;
  late bool opened;
  late DateTime tokenCreatedAt;
  late int level;
  final uplineMaps = [];
  var uplineData;

  Tokens.fromFirebase(QueryDocumentSnapshot doc) {
    dynamic docdata = doc.data();
    id = doc.id;
    tokenCode = docdata["tokenCode"];
    tokenReg = docdata["tokenReg"];
    tokenCreator = docdata["tokenCreator"];
    upline = docdata["upline"];
    tokenUsed = docdata["tokenUsed"];
    opened = docdata["opened"];
    tokenCreatedAt = (docdata["tokenCreatedAt"] as Timestamp).toDate();
    level = docdata["level"];
    (doc["uplineMaps"] as List).forEach((element) {
      uplineMaps.add(element);
    });
    getUplineData();
  }

  Tokens.fromFirebaseSnapshot(DocumentSnapshot doc) {
    dynamic docdata = doc.data();
    id = doc.id;
    tokenCode = docdata["tokenCode"];
    tokenReg = docdata["tokenReg"];
    tokenCreator = docdata["tokenCreator"];
    upline = docdata["upline"];
    tokenUsed = docdata["tokenUsed"];
    opened = docdata["opened"];
    tokenCreatedAt = (docdata["tokenCreatedAt"] as Timestamp).toDate();
    level = docdata["level"];
    (doc["uplineMaps"] as List).forEach((element) {
      uplineMaps.add(element);
    });
    getUplineData();
  }

  getUplineData() async {
    uplineData = await Members.doc(upline).get().then((value) => value.data());
  }

  getCreatorData() async {
    return await Members.doc(tokenCreator).get().then((value) => value.data());
  }
}
