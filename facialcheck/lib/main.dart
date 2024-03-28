import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'page/login.dart';

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
        future: Future.delayed(Duration(seconds: 2)), // contoh Future yang diinisialisasi dengan delay 2 detik
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Tampilkan indicator loading saat menunggu Future selesai
          } else {
            return Login(); // Setelah Future selesai, tampilkan halaman Login
          }
        },
      ),
    );
  }
}