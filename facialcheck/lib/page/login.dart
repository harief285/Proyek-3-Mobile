import 'package:facialcheck/widget/info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:facialcheck/event/event_db.dart';


class Login extends StatelessWidget{

  var controllerEmail = TextEditingController();
  var controllerPass = TextEditingController();
  var formKey = GlobalKey<FormState>();


  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async{
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
                        "LOGIN",
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    width: 350,
                    height: 500,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "E-mail",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 240,
                                      height: 60,
                                      child: TextFormField(
                                        controller: controllerEmail,
                                        validator: (value) => value!.isEmpty ? 'Jangan Kosong' : null,
                                        decoration: InputDecoration(
                                          helperText: ' ',
                                          border: OutlineInputBorder(),
                                          labelText: "Enter your email...",
                                          labelStyle: TextStyle(
                                            fontSize: 10,
                                          ),
                                          prefixIcon: Icon(Icons.person_outline, size: 20,),
                                        ),
                                      ),
                                    ),

                                    Text(
                                      "Password",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 240,
                                      height: 60,
                                      child: TextFormField(
                                        controller: controllerPass,
                                        validator: (value) => value!.isEmpty ? 'Jangan Kosong' : null,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Enter your password...",
                                          labelStyle: TextStyle(
                                            fontSize: 10,
                                          ),
                                          helperText: ' ',
                                          prefixIcon: Icon(Icons.lock_outlined, size: 20,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 240,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      // onTap: () {
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(builder: (context) => Login()),
                                      //   );
                                      // },
                                      child: Text(
                                        "Forgot Password ?",
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 240,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff408CFF), // Warna latar belakang tombol
                                          onPrimary: Colors.black, // Warna teks tombol
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6), // Mengatur tampilan squared (persegi)
                                          ),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                          EventDB.login(controllerEmail.text, controllerPass.text);
                                          controllerEmail.clear();
                                          controllerPass.clear();
                                          }
                                        },
                                        child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
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
                                        // onTap: () {
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(builder: (context) => Login()),
                                        //   );
                                        // },
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff408CFF),
                                            fontWeight: FontWeight.bold
                                          ),
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
                  ),
                ]
              ),
            )
          ],
        )),
    );
  }
}