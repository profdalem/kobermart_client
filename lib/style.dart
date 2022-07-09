import 'package:flutter/material.dart';

final TextStyle header1 =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

final TextStyle panelTitle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

final SizedBox sb5 = SizedBox(
  height: 5,
);

final SizedBox sb10 = SizedBox(
  height: 10,
);

final SizedBox sb15 = SizedBox(
  height: 15,
);

final SizedBox sb20 = SizedBox(
  height: 20,
);

class PanelTitle extends StatelessWidget {
  const PanelTitle({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: panelTitle,
    );
  }
}

BoxDecoration Shadow1() {
  return new BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [
      //background color of box
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 2, // soften the shadow
        spreadRadius: 2, //extend the shadow
        offset: Offset(
          1, // Move to right 10  horizontally
          2, // Move to bottom 10 Vertically
        ),
      )
    ],
  );
}

BoxDecoration ShadowBottom() {
  return new BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [
      //background color of box
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 2, // soften the shadow
        spreadRadius: 2, //extend the shadow
        offset: Offset(
          1, // Move to right 10  horizontally
          -2, // Move to bottom 10 Vertically
        ),
      )
    ],
  );
}
