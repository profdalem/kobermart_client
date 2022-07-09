import 'package:flutter/material.dart';

class TrxStatus extends StatelessWidget {
  const TrxStatus({Key? key, required this.statusCode}) : super(key: key);
  final int statusCode;

  @override
  Widget build(BuildContext context) {
    var status = statusCode;
    double fontsize = 14;

    switch (status) {
      case 1:
        return Chip(
          label: Text(
            "menunggu pembayaran",
            style: TextStyle(fontSize: fontsize),
          ),
          visualDensity: VisualDensity.compact,
          backgroundColor: Colors.grey.shade300,
        );
      case 2:
        return Chip(
          label: Text(
            "sedang diproses",
            style: TextStyle(fontSize: fontsize),
          ),
          visualDensity: VisualDensity.compact,
          backgroundColor: Colors.orange.shade300,
        );
      case 3:
        return Chip(
          label: Text(
            "dalam perjalanan",
            style: TextStyle(fontSize: fontsize),
          ),
          visualDensity: VisualDensity.compact,
          backgroundColor: Colors.blue.shade300,
        );
      case 4:
        return Chip(
          label: Text(
            "selesai",
            style: TextStyle(fontSize: fontsize),
          ),
          visualDensity: VisualDensity.compact,
          backgroundColor: Colors.green.shade300,
        );
      case 5:
        return Chip(
          label: Text(
            "ditangguhkan",
            style: TextStyle(fontSize: fontsize),
          ),
          visualDensity: VisualDensity.compact,
          backgroundColor: Colors.orange.shade700,
        );
      case 6:
        return Chip(
          label: Text(
            "batal",
            style: TextStyle(fontSize: fontsize),
          ),
          visualDensity: VisualDensity.compact,
          backgroundColor: Colors.red.shade300,
        );
      default:
        return Chip(
          label: Text(
            "menunggu pembayaran",
            style: TextStyle(fontSize: fontsize),
          ),
          visualDensity: VisualDensity.compact,
          backgroundColor: Colors.grey.shade300,
        );
    }
  }
}
