import 'package:get_storage/get_storage.dart';

final mainUrl = "https://us-central1-kobermart2022.cloudfunctions.net/server/";
final mainUrlv2 = "https://us-central1-kobermart2022.cloudfunctions.net/serverv2/";
// final mainUrl = "http://192.168.1.19:4000/";
// final mainUrlv2 = "http://192.168.1.19:4000/";
// final mainUrl = "http://10.0.2.2:5001/kobermart2022/us-central1/server/";

final iakSignPricelist = "5b5e24672a33f29449dd5064cc2f45bc";

final devMode = false;
final preFilled = false;

void devLog(Object? text) {
  if (devMode) print(text);
}

GetStorage boxStorage = GetStorage();
