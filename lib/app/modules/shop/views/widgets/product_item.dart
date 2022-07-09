import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/style.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.name,
    required this.price,
    required this.cashback,
    required this.stock,
  }) : super(key: key);

  final String name;
  final int price;
  final int cashback;
  final int stock;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 3,
          child: GestureDetector(
            onTap: () => print("product"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: Image.asset(
                    "assets/images/coffee.jpeg",
                    fit: BoxFit.cover,
                    height: constraints.maxWidth,
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kopi Sachet 3in1 Instant Coffee Mocca",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            sb10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp ${NumberFormat("#,##0", "id_ID").format(price)}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Chip(
                                      visualDensity: VisualDensity.compact,
                                      padding: EdgeInsets.all(0),
                                      backgroundColor: Color(0xFFFF9800),
                                      label: Text('+${cashback.toString()}%',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Sisa: ${stock.toInt()}"),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
