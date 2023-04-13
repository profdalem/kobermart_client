import 'package:get_storage/get_storage.dart';

final mainUrl = "https://us-central1-kobermart2022.cloudfunctions.net/server/";
// final mainUrl = "http://34.136.231.191/";
// final mainUrl = "http://192.168.8.116:4000/";
// final mainUrl = "http://localhost:4000/";

final iakSignPricelist = "5b5e24672a33f29449dd5064cc2f45bc";
final devMode = false;
final preFilled = false;

void devLog(Object? text) {
  if (devMode) print(text);
}

GetStorage boxStorage = GetStorage();
