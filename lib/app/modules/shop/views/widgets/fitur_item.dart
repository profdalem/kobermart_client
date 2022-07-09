import 'package:flutter/material.dart';

BoxDecoration FiturItemDecoration() {
  return new BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      //background color of box
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 5, // soften the shadow
        spreadRadius: 2, //extend the shadow
        offset: Offset(
          1, // Move to right 10  horizontally
          3, // Move to bottom 10 Vertically
        ),
      )
    ],
  );
}

class FiturItem extends StatelessWidget {
  const FiturItem({
    Key? key,
    required this.imgUrl,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final String imgUrl;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onTap: () {
          print(context);
        },
        child: Container(
          decoration: FiturItemDecoration(),
          height: constraints.maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: constraints.maxWidth * 0.5,
                  height: constraints.maxWidth * 0.4,
                  child: Image.asset(
                    "assets/images/${imgUrl}.png",
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                height: 3,
              ),
              Text(
                text1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: constraints.maxWidth * 0.15),
              ),
              Text(
                text2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: constraints.maxWidth * 0.15),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
