import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:math';
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
  late String randomFileName;
  late String newPath;

  @override
  void initState() {
    super.initState();
    _getUserId();
    randomFileName = generateRandomFileName() + '.jpg';
    print('Generated random filename: $randomFileName');
    newPath = path.join(path.dirname(widget.picture.path), randomFileName);
    _renameFile();
  }

  Future<void> _renameFile() async {
    await File(widget.picture.path).rename(newPath);
    setState(() {});
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

      request.files.add(await http.MultipartFile.fromPath('image', newPath));

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

  String generateRandomFileName() {
    var rand = Random();
    return List.generate(10, (_) => rand.nextInt(10).toString()).join();
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
            File(newPath),
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
              randomFileName,
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
