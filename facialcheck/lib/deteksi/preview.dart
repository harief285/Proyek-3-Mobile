import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:facialcheck/model/deteksi_model.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture, required this.apiResponse}) : super(key: key);

  final XFile picture;
  final ApiResponse apiResponse;

  Future<void> uploadImage() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://facialcek.istoree.my.id/api/upload-image'),  // Pastikan URL ini benar
      );

      request.files.add(await http.MultipartFile.fromPath('image', picture.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Gambar berhasil diunggah');
      } else {
        print('Gambar gagal diunggah');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preview Deteksi",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Image.file(
            File(picture.path),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 24),
          DataTable(
            columns: [
              DataColumn(
                label: Text(
                  "Deteksi",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              DataColumn(
                label: Text(
                  "Hasil",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text("Prediksi: ")),
                  DataCell(Text(apiResponse.prediction)),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text("Persentase: ")),
                  DataCell(Text(apiResponse.percentage)),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await uploadImage();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gambar berhasil diunggah')),
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
