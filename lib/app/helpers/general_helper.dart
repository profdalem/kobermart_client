import 'dart:math';

int nominalOnly(String text) {
  return int.parse(text.toString().replaceAll(new RegExp(r'[^0-9]'), ''));
}

String generateRandomString(int len, String code) {
  var r = Random();
  const _chars = 'ABCDEFGHJKMNOPQRSTUVWXYZ1234567890';
  var _time = DateTime.now().year.toString().substring(2, 4) + DateTime.now().month.toString() + DateTime.now().day.toString();
  return code + _time + List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

String segmentPower(String text) {
  var temp = text.split("/");
  var startSubtrim = 0;
  for (var i = 0; i < temp[1].length; i++) {
    if (temp[1][i] != "0") {
      startSubtrim = i;
      i = temp[1].length;
    }
  }
  return temp[0].trimLeft().trimRight() + "/" + temp[1].substring(startSubtrim, temp[1].length);
}

String censorHalf(String text) {
  var result = [];
  for (var i = 0; i < text.length; i++) {
    if (i < (text.length / 1.5).floor()) {
      result.add(text[i]);
    } else {
      result.add("*");
    }
  }
  return result.join();
}

String getPeriod(String text) {
  var year = text.substring(0, 4);
  var month = text.substring(4, 6);
  switch (month) {
    case "01":
      month = "Jan";
      break;
    case "02":
      month = "Feb";
      break;
    case "03":
      month = "Mar";
      break;
    case "04":
      month = "Apr";
      break;
    case "05":
      month = "Mei";
      break;
    case "06":
      month = "Jun";
      break;
    case "07":
      month = "Jul";
      break;
    case "08":
      month = "Ags";
      break;
    case "09":
      month = "Sept";
      break;
    case "10":
      month = "Okt";
      break;
    case "11":
      month = "Nov";
      break;
    default:
      month = "Des";
  }
  return month.toUpperCase() + " " +year;
}
