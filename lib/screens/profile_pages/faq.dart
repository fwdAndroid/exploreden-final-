import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  final String pdfAssetPath = "assets/faq.pdf"; // Adjusted the variable name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: FutureBuilder<String>(
        future: _getPdfPathFromAssets(), // Load PDF path from assets
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PDFView(
              filePath: snapshot.data!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageSnap: true,
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page');
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<String> _getPdfPathFromAssets() async {
    // Load the PDF file from assets and return the file path
    final ByteData data = await rootBundle.load(pdfAssetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final String tempPath = (await getTemporaryDirectory()).path;
    final String pdfPath = '$tempPath/faq.pdf';
    await File(pdfPath).writeAsBytes(bytes);
    return pdfPath;
  }
}
