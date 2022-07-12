import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              child: Text('null'),
              onPressed: () => getPdfPath(),
            ),
          ),
        ),
      ),
    );
  }

  Future getPdfPath() async {
    Directory docDir = await getApplicationDocumentsDirectory();  
    print(docDir);
  }
}
