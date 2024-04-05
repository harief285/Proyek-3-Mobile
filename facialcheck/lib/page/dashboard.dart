import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
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
                              Text("Hello, Dummy"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Admin", style: TextStyle(fontSize: 12),),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}