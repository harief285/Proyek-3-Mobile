import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:facialcheck/deteksi/camera.dart';
import 'package:facialcheck/page/list_riwayat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:facialcheck/model/user.dart';
import 'package:facialcheck/page/login.dart';
import 'package:facialcheck/event/event_db.dart';
import 'package:facialcheck/event/event_pref.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  List<User> totalUser = [];
  String userName = "";
  String setid = "";
   // Initialize with a default value

  void getUser() async {
    totalUser = await EventDB.getUser();
    userName = (await EventPref.getUser())?.name ?? "";
    setid = (await EventPref.getUser())?.id ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Color(0xff545454)),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/img/profile.png",
                        width: MediaQuery.of(context).size.width * 0.08,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hi, $userName",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      PopupMenuButton(
                        child: Image.asset("assets/img/menu.png",
                            width: MediaQuery.of(context).size.width * 0.04),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.settings,
                                    size: 15,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Setting",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: 15,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "LogOut",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == 0) {
                            print("settings");
                          } else if (value == 1) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Icon(Icons.warning_amber),
                                      Text(
                                        "LogOut",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  content: Text(
                                    "Apakah anda yakin ingin keluar?",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Tidak"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        EventPref.clear();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      },
                                      child: Text("Ya"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Selamat datang di Aplikasi Facial Check",
                            style: GoogleFonts.roboto(
                                fontSize: 10, color: Color(0xff408CFF)),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.article, color: Color(0xff408CFF)),
                  SizedBox(width: 8),
                  Text(
                    "Artikel",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff545454),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: 4, // Ganti dengan jumlah artikel yang sebenarnya
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xffE0FFE0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        "Pola hidup sehat",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff545454),
                        ),
                      ),
                      subtitle: Text(
                        "Prof Dewi Dummy",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Color(0xff545454),
                        ),
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: <Widget>[
                          Icon(Icons.book, color: Color(0xff408CFF)),
                          Icon(Icons.auto_awesome, color: Color(0xff408CFF)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await availableCameras().then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
          },
          child: Icon(Icons.document_scanner_outlined),
          elevation: 4,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: Color(0xffCCCCCC), width: 1)),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: IconButton(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: IconButton(
                      icon: Icon(
                        Icons.history_edu,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ListRiwayat(setid: setid,)));
                      },
                    ),
                  ),
                  label: 'History'),
            ],
          ),
        ));
  }
}