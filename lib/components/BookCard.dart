// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Function() onTap;
  final String bookName;
  final String bookAuthor;
  final int bookPrice;
  final int bookViews;
  final double width;
  final double height;
  final String imageNetwork;
  final String bookCategory; // Added category parameter

  const BookCard({
    super.key,
    required this.onTap,
    required this.bookName,
    required this.bookAuthor,
    required this.bookPrice,
    required this.bookViews,
    required this.width,
    required this.height,
    required this.imageNetwork,
    required this.bookCategory, // Added to constructor
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
            // Image container with view count overlay
            Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
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
                    child: imageNetwork.isNotEmpty
                        ? Image.network(
                            imageNetwork,
                            width: double.infinity,
                            height: 194,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            "lib/assets/book.jpg",
                            width: double.infinity,
                            height: 194,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                // Category badge overlay
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      bookCategory,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // View count overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          size: 16,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${bookViews.toString()} views',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Book title with max lines
            Text(
              bookName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff151E47),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 7),
            // Author name
            Text(
              bookAuthor,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff151E47),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 7),
            // Price and View Details button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$ $bookPrice",
                  style: TextStyle(
                    color: Color(0xffEB5757),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
