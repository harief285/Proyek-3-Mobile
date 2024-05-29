import 'package:facialcheck/page/login.dart';
import 'package:facialcheck/widget/info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:facialcheck/event/event_db.dart';

class Register extends StatelessWidget {
  var controllerName = TextEditingController();
  var controllerEmail = TextEditingController();
  var controllerPass = TextEditingController();
  var controllerPasscek = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 163,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SIGN UP",
                        style: GoogleFonts.inter(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    width: 350,
                    height: 600,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 240,
                                      height: 35,
                                      child: TextFormField(
                                        controller: controllerName,
                                        validator: (value) => value!.isEmpty
                                            ? 'Jangan Kosong'
                                            : null,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Type your name...",
                                          labelStyle: TextStyle(
                                            fontSize: 10,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.person_outline,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 240,
                                      height: 35,
                                      child: TextFormField(
                                        controller: controllerEmail,
                                        validator: (value) => value!.isEmpty
                                            ? 'Jangan Kosong'
                                            : null,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Type your email...",
                                          labelStyle: TextStyle(
                                            fontSize: 10,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.person_outline,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 240,
                                      height: 35,
                                      child: TextFormField(
                                        controller: controllerPass,
                                        validator: (value) => value!.isEmpty
                                            ? 'Jangan Kosong'
                                            : null,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Type your password...",
                                          labelStyle: TextStyle(
                                            fontSize: 10,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.lock_outlined,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 240,
                                      height: 35,
                                      child: TextFormField(
                                        controller: controllerPasscek,
                                        validator: (value) => value!.isEmpty
                                            ? 'Jangan Kosong'
                                            : null,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Repeat your password...",
                                          labelStyle: TextStyle(
                                            fontSize: 10,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.lock_outlined,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 164,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: Color(
                                              0xff408CFF), // Warna teks tombol
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                6), // Mengatur tampilan squared (persegi)
                                          ),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            EventDB.addUser(
                                                controllerName.text,
                                                controllerEmail.text,
                                                controllerPass.text,
                                                controllerPasscek.text);
                                            controllerName.clear();
                                            controllerEmail.clear();
                                            controllerPass.clear();
                                            controllerPasscek.clear();
                                          }
                                        },
                                        child: Text(
                                          "CREATE ACCOUNT",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                        );
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff408CFF),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
