import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


class PrintScreen extends StatelessWidget {
  final Uint8List? qrImageBytes;
  final String? qrData;
  final String userName;

  // Constructor harus menerima parameter ini agar bisa dipanggil dari Generator
  const PrintScreen({
    super.key,
    this.qrImageBytes,
    this.qrData,
    this.userName = "Ghifari", // Memberikan default agar tidak error jika tidak diisi
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview & Print PDF')),
      body: qrImageBytes == null
          ? const Center(child: Text("Data QR tidak ditemukan."))
          : PdfPreview(
              build: (format) => _generatePdf(format),
            ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text('QR CODE REPORT', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Image(pw.MemoryImage(qrImageBytes!), width: 200, height: 200),
                pw.SizedBox(height: 20),
                pw.Text('Data: ${qrData ?? "-"}'),
                pw.SizedBox(height: 40),
                pw.Text('Dibuat oleh: $userName'),
              ],
            ),
          );
        },
      ),
    );
    return pdf.save();
  }
}