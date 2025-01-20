import 'dart:io';
import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';

class EpubReaderPage extends StatefulWidget {
  final String epubPath;

  const EpubReaderPage({Key? key, required this.epubPath}) : super(key: key);

  @override
  State<EpubReaderPage> createState() => _EpubReaderPageState();
}

class _EpubReaderPageState extends State<EpubReaderPage> {
  late EpubController _epubController;

  @override
  void initState() {
    super.initState();
    _epubController = EpubController(
      document: EpubDocument.openFile(File(widget.epubPath)),
    );
  }

  @override
  void dispose() {
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: EpubViewActualChapter(
          controller: _epubController,
          builder: (chapter) {
            return Text(
              chapter?.chapter?.Title?.replaceAll('\n', '').trim() ??
                  'Loading...',
              textAlign: TextAlign.start,
            );
          },
        ),
      ),
      body: EpubView(
        controller: _epubController,
      ),
    );
  }
}
