import 'package:flutter/material.dart';
import 'package:facialcheck/resource/theme.dart';


class Login extends StatelessWidget{


  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: greyColor,
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
                      
                    ],
                  )
                ]),
            )
          ],
        )),
    );
  }
}