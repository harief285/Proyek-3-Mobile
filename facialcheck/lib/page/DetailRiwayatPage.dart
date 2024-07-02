import 'package:flutter/material.dart';
import 'package:facialcheck/model/riwayat.dart';

class DetailRiwayatPage extends StatelessWidget {
  final Riwayat riwayat;

  const DetailRiwayatPage({Key? key, required this.riwayat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://facialcek.istoree.my.id/public/images/${riwayat.gambar}';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Riwayat",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Image.network(
            imageUrl,
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
                  DataCell(Text(riwayat.prediksi ?? 'No prediction')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text("Persentase: ")),
                  DataCell(Text(riwayat.presentase ?? 'No percentage')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
