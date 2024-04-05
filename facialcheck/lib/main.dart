import 'package:facialcheck/page/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'page/login.dart';
import 'package:facialcheck/event/event_pref.dart';
import 'package:facialcheck/model/user.dart';
void main() {
  runApp(const FacialCheck());
}

class FacialCheck extends StatelessWidget {
  const FacialCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: FutureBuilder(
        future: EventPref.getUser(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          return snapshot.data == null?
          Login(): snapshot.data!.type=='0'?
          Dashboard(): Login();
        },
      ),
    );
  }
}