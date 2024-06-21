// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

class PDFScreen extends StatefulWidget {
  final String path;
  final String title;

  const PDFScreen({super.key, required this.path, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  int _totalPages = 0;
  int _currentPage = 0;
  late PDFViewController _pdfViewController;

  void _onRender(int pages) {
    setState(() {
      _totalPages = pages;
    });
  }

  void _onPageChanged(int? currentPage, int? totalPages) {
    setState(() {
      _currentPage = currentPage!;
      _totalPages = totalPages!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PDF(
              swipeHorizontal: false,
              onPageChanged: _onPageChanged,
              onRender: (pages) => _onRender(pages!),
            ).cachedFromUrl(
              widget.path,
              placeholder: (double progress) => Center(
                child: reuseText("${progress.toStringAsFixed(0)}%", 18,
                    FontWeight.normal, Colors.white),
              ),
              errorWidget: (dynamic error) => Center(
                child: Text(
                  'Failed to load PDF: ${error.toString()}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.black54,
              child: Text(
                'Page ${_currentPage + 1} of $_totalPages',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
