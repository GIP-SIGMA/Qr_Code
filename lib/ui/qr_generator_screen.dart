import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_generator_and_scanner/ui/Print_screen.dart'; 

const Color primaryColor = Color(0xFF3A2EC3);

const List<Color> qrColors = [
  Colors.white,
  Colors.grey,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.cyan,
  Colors.purple,
];

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  String? _qrData;
  Color _qrColor = Colors.white;

  
  Future<void> _sendEmailFriendly() async {
    final Uint8List? imageBytes = await _screenshotController.capture();
    if (imageBytes != null) {
      await Share.shareXFiles(
        [XFile.fromData(imageBytes, name: 'qr_code.png', mimeType: 'image/png')],
        subject: 'QR Code dari QR S&G App',
        text: 'Ini QR Code untuk: ${_qrData ?? ""}\n\nDibuat menggunakan QR S&G oleh Ghifari',
      );
    }
  }

  
  void _navigateToPrint() async {
    final Uint8List? imageBytes = await _screenshotController.capture();
    if (imageBytes != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrintScreen(
            qrImageBytes: imageBytes,
            qrData: _qrData,
            userName: "Ghifari",
          ),
        ),
      );
    }
  }

  // Fungsi Share Biasa
  Future<void> _shareQr() async {
    final Uint8List? imageBytes = await _screenshotController.capture();
    if (imageBytes != null) {
      await Share.shareXFiles([
        XFile.fromData(imageBytes, name: 'qrcode.png', mimeType: 'image/png'),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create QR', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(height: 200, color: primaryColor),
              Expanded(child: Container(color: Colors.grey.shade50)),
            ],
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
                    ),
                    child: Column(
                      children: [
                        Screenshot(
                          controller: _screenshotController,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _qrColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: _qrData == null || _qrData!.isEmpty
                                ? const SizedBox(
                                    height: 200,
                                    child: Center(child: Text('Masukkan teks untuk generate QR')))
                                : PrettyQrView.data(
                                    data: _qrData!,
                                    decoration: const PrettyQrDecoration(
                                      shape: PrettyQrSmoothSymbol(),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Link atau Teks',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onChanged: (value) => setState(() => _qrData = value.trim().isEmpty ? null : value.trim()),
                        ),
                        const SizedBox(height: 24),
                        // Action Buttons
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _qrData == null ? null : _sendEmailFriendly,
                                icon: const Icon(Icons.send),
                                label: const Text('Send via Email'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade700,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _qrData == null ? null : _navigateToPrint,
                                    icon: const Icon(Icons.print),
                                    label: const Text('Print PDF'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange.shade800,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _qrData == null ? null : _shareQr,
                                    icon: const Icon(Icons.share),
                                    label: const Text('Share'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}