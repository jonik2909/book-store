// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Book list',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Visibility(
        // visible: items.isNotEmpty,
        replacement: Center(
          child: Text(
            'No Items',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        child: ListView.builder(
            itemCount: 10,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text("item['title']"),
                  subtitle: Text("item['description']"),
                  trailing: Icon(Icons.delete),
                ),
              );
            }),
      ),
    );
  }
}
