import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:facialcheck/model/deteksi_model.dart';
import 'package:facialcheck/event/event_db.dart';
import 'package:facialcheck/event/event_pref.dart';
import 'package:path/path.dart' as path;

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture, required this.apiResponse}) : super(key: key);

  final XFile picture;
  final ApiResponse apiResponse;

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    userId = (await EventPref.getUser())?.id;
    setState(() {});
  }

  Future<void> uploadImage() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://facialcek.istoree.my.id/api/upload-image'),
      );

      request.files.add(await http.MultipartFile.fromPath('image', widget.picture.path));

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
    String fileName = path.basename(widget.picture.path);

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
            File(widget.picture.path),
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
                  DataCell(Text(widget.apiResponse.prediction)),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text("Persentase: ")),
                  DataCell(Text(widget.apiResponse.percentage)),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await uploadImage();
          if (userId != null) {
            EventDB.addRiwayat(
              userId!,
              widget.apiResponse.prediction,
              widget.apiResponse.percentage,
              fileName,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Riwayat berhasil disimpan')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal mendapatkan userId')),
            );
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}