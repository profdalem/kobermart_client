import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductItem extends StatelessWidget {
  ProductItem({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.cashback,
    required this.stock,
    required this.imgurl,
  }) : super(key: key);

  final String id;
  final String name;
  final String imgurl;
  final int price;
  final int cashback;
  final int stock;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 1,
          child: GestureDetector(
            onTap: () => Get.toNamed(Routes.PRODUCT, arguments: {"id": id}),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: CachedNetworkImage(
                        imageUrl: imgurl,
                        fit: BoxFit.cover,
                        height: constraints.maxWidth,
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3, right: 10),
                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
                      child: Text("Cashback ${cashback.toString()}%", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),)
                  ],
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
                              name,
                              style: TextStyle(height: 1.3,
                                fontSize: 14,
                                fontWeight: FontWeight.w300
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp${NumberFormat("#,##0", "id_ID").format(price)}",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sisa: ${stock.toInt()}",
                                      style: TextStyle(fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "4.8",
                                          style: TextStyle(fontSize: 12),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Icon(Icons.star_rate_rounded, size: 14, color: Colors.amber.shade600,)
                                      ],
                                    ),
                                    
                                    
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
