import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfDialog extends StatelessWidget {
  const PdfDialog({super.key, required this.pdfSource});
  final String pdfSource;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 350,
        height: 400,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: SfPdfViewer.network(pdfSource),
        ),
      ),
    );
  }
}
