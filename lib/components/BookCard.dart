// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Function() onTap;
  final String imagePath;
  final String bookName;
  final String bookAuthor;
  final int bookPrice;
  final double width;
  final double height;

  const BookCard({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.bookName,
    required this.bookAuthor,
    required this.bookPrice,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 194,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 15,
                  color: Color(0xffFF9E00),
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: Color(0xffFF9E00),
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: Color(0xffFF9E00),
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: Color(0xffFF9E00),
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: Color(0xffCED4DA),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              bookName,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff151E47),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 7),
            Text(
              bookAuthor,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff151E47),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 7),
            Text(
              "\$ ${bookPrice}",
              style: TextStyle(
                color: Color(0xffEB5757),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Container(
//       width: 130,
//       margin: EdgeInsets.only(right: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 130,
//             height: 194,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromRGBO(0, 0, 0, 0.04),
//                   spreadRadius: 0,
//                   blurRadius: 1,
//                   offset: Offset(0, 0),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Image.asset(
//                 'lib/assets/book.jpg',
//                 width: double.infinity,
//                 height: 194,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           SizedBox(height: 15),
//           Row(
//             children: [
//               Icon(
//                 Icons.star,
//                 size: 15,
//                 color: Color(0xffFF9E00),
//               ),
//               Icon(
//                 Icons.star,
//                 size: 15,
//                 color: Color(0xffFF9E00),
//               ),
//               Icon(
//                 Icons.star,
//                 size: 15,
//                 color: Color(0xffFF9E00),
//               ),
//               Icon(
//                 Icons.star,
//                 size: 15,
//                 color: Color(0xffFF9E00),
//               ),
//               Icon(
//                 Icons.star,
//                 size: 15,
//                 color: Color(0xffCED4DA),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(
//             "Displacement",
//             style: TextStyle(
//               fontSize: 16,
//               color: Color(0xff151E47),
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           SizedBox(height: 7),
//           Text(
//             "Kiku Hughes",
//             style: TextStyle(
//               fontSize: 12,
//               color: Color(0xff151E47),
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           SizedBox(height: 7),
//           Text(
//             "\$ 16.55",
//             style: TextStyle(
//               color: Color(0xffEB5757),
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
