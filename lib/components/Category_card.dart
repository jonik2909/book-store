// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final bool selected;
  const CategoryCard({super.key, required this.name, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Color(selected ? 0xffEB5757 : 0xffFFF),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color(0xffE9ECEF),
          )),
      child: Center(
        child: Text(
          name,
          style: TextStyle(color: selected ? Colors.white : Color(0xff151E47)),
        ),
      ),
    );
  }
}
