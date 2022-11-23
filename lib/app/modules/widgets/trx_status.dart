import 'package:flutter/material.dart';

class TrxStatus extends StatelessWidget {
  const TrxStatus({Key? key, required this.statusCode}) : super(key: key);
  final int statusCode;

  @override
  Widget build(BuildContext context) {
    var status = statusCode;
    double fontsize = 12;
    var padding = EdgeInsets.symmetric(horizontal: 8, vertical: 5);
    var borderRadius = BorderRadius.all(Radius.circular(15));

    switch (status) {
      case 1:
        return pillShape("belum dibayar", Colors.grey.shade200,
            Colors.grey.shade300, borderRadius, padding, fontsize);
      case 2:
        return pillShape("diproses", Colors.orange.shade200,
            Colors.orange.shade300, borderRadius, padding, fontsize);
      case 3:
        return pillShape("dalam perjalanan", Colors.blue.shade200,
            Colors.blue.shade300, borderRadius, padding, fontsize);
      case 4:
        return pillShape("selesai", Colors.green.shade200,
            Colors.green.shade300, borderRadius, padding, fontsize);
      case 5:
        return pillShape("ditangguhkan", Colors.orange.shade500,
            Colors.orange.shade700, borderRadius, padding, fontsize);
      case 6:
        return pillShape("batal", Colors.red.shade300, Colors.red.shade500,
            borderRadius, padding, fontsize);
      default:
        return pillShape("belum dibayar", Colors.grey.shade200,
            Colors.grey.shade300, borderRadius, padding, fontsize);
    }
  }

  Container pillShape(String text, Color color1, Color color2,
      BorderRadius borderRadius, EdgeInsets padding, double fontsize) {
    return Container(
      decoration: BoxDecoration(
          color: color1,
          borderRadius: borderRadius,
          border: Border.all(color: color2)),
      padding: padding,
      child: Text(text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: fontsize, color: Colors.black)),
    );
  }
}
