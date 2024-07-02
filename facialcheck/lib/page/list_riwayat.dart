import 'package:flutter/material.dart';
import 'package:facialcheck/model/riwayat.dart';
import 'package:facialcheck/event/event_db.dart';
import 'package:confirm_dialog/confirm_dialog.dart' as confirm;
import 'package:facialcheck/page/DetailRiwayatPage.dart';

class ListRiwayat extends StatefulWidget {
  const ListRiwayat({super.key, required this.setid});

  final String setid;

  @override
  _ListRiwayatState createState() => _ListRiwayatState();
}

class _ListRiwayatState extends State<ListRiwayat> {
  List<Riwayat> listRiwayat = [];
  bool _isLoading = true;

  void getRiwayat() async {
    listRiwayat = await EventDB.getRiwayat(widget.setid);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getRiwayat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat History'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: listRiwayat.length,
              itemBuilder: (context, index) {
                Riwayat riwayat = listRiwayat[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailRiwayatPage(riwayat: riwayat),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.history, color: Color(0xff408CFF)),
                          ),
                          title: Text(riwayat.prediksi ?? 'No prediction', style: TextStyle(fontSize: 12)),
                          subtitle: Text(riwayat.createdAt ?? 'No date', style: TextStyle(fontSize: 9)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
