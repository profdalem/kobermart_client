import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  const InfoItem(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.content})
      : super(key: key);

  final String imgUrl;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.06,
          width: MediaQuery.of(context).size.width * 0.06,
          child: Image.asset(
            "assets/images/${imgUrl}.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 14)),
            Text(
              content,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
