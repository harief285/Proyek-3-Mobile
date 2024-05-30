import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:facialcheck/model/deteksi_model.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture, required this.apiResponse}) : super(key: key);

  final XFile picture;
  final ApiResponse apiResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Deteksi", style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Image.file(File(picture.path), fit: BoxFit.cover,),
          SizedBox(height: 24),
          DataTable(
            columns: [
              DataColumn(
                label: Text("Deteksi", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              ),
              DataColumn(
                label: Text("Hasil", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              ),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text("Prediction: ")),
                  DataCell(Text(apiResponse.prediction)),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text("Percentage: ")),
                  DataCell(Text(apiResponse.percentage)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
