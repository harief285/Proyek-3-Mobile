import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:facialcheck/model/user.dart';
import 'package:facialcheck/page/login.dart';
import 'package:facialcheck/event/event_db.dart';
import 'package:facialcheck/event/event_pref.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {

  List<User> totalUser = [];

  late String userName ;

  void getUser() async{
    totalUser = await EventDB.getUser();
    userName = (await EventPref.getUser())?.name ?? "";
    setState(() {

    });
  }

  @override
  void initState(){
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
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    children: [
                      Image.asset("assets/img/profile.png", width: MediaQuery.of(context).size.width * 0.08,),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Hi, Dummy" , style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      PopupMenuButton(
                        child: Image.asset("assets/img/menu.png", width: MediaQuery.of(context).size.width * 0.04),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  Icon(Icons.settings, size: 15, color: Colors.black45,),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Setting", style: TextStyle(fontSize: 12),)
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.logout, size: 15, color: Colors.black45,),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("LogOut", style: TextStyle(fontSize: 12),)
                                ],
                              ),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if(value == 0) {
                            print("settings");
                          } else if (value == 1) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Icon(Icons.warning_amber),
                                      Text("LogOut", style: TextStyle(fontSize: 12),)
                                    ],
                                  ),
                                  content: Text("Apakah anda yakin ingin keluar?", style: TextStyle(fontSize: 12),),
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
                              Text("Selamat datang di Aplikasi Facial Check",
                              style: GoogleFonts.roboto(
                                fontSize: 10,
                                color: Color(0xff408CFF)),),
                            ],
                          )
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
          },
          child: Icon(Icons.document_scanner_outlined),
          elevation: 4,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(horizontal: BorderSide(color: Color(0xffCCCCCC), width: 1)),
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
                    onPressed: () { },
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
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowNotification()));
                      },
                    ),
                  ),
                  label: 'History'
              ),
            ],
          ),
        )
    );
  }

}