import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  late String id;
  late String userId;
  late int nominal;
  late String status;
  late String type;
  late Map data;
  late DateTime createdAt;

  Transaction(this.id, this.userId, this.createdAt, this.nominal, this.status, this.type);

  Transaction.fromFirebase(QueryDocumentSnapshot doc) {
    dynamic docdata = doc.data();
    id = doc.id;
    userId = docdata["id"];
    nominal = docdata["nominal"];
    status = docdata["status"];
    type = docdata["type"];
    data = docdata["data"];
    createdAt = (docdata["createdAt"] as Timestamp).toDate();
  }

  int getStatus() {
    final int code;
    List history = data["transactionData"]["history"] as List;
    code = history.last["code"];
    return code;
  }

  String getMethod() {
    return data["transactionData"]["method"];
  }
}
