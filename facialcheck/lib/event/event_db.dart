import 'dart:convert';
import 'dart:ffi';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:facialcheck/config/api.dart';
import 'package:facialcheck/event/event_pref.dart';
import 'package:facialcheck/widget/info.dart';
import 'package:facialcheck/model/user.dart';
import 'package:facialcheck/page/dashboard.dart';
import 'package:facialcheck/page/login.dart';

class EventDB{
  static Future<User?> login(String email, String pass) async {
    User? user;

    try{
      var response = await http.post(Uri.parse(Api.login), body: {
        'email': email,
        'password': pass
      });

      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        if(responseBody['success']){
          user = User.fromJson(responseBody['user']);
          EventPref.saveUser(user);
          Info.snackbar('Login Berhasil');
          Future.delayed(Duration(milliseconds: 1700),() {
            Get.off(
              user!.type == '0'?
              Dashboard():
              Login()
            );
          });
        }else{
          Info.snackbar("Login Gagal");
        }
      }else{
        Info.snackbar("Request Login Gagal");
      }
    }catch(e){
      print(e);
    }
    return user;
  }

  static Future<List<User>> getUser() async {
    List<User> listUser = [];

    try {
      var response = await http.post(Uri.parse(Api.list_user));

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var users = responseBody['user'];
          users.forEach((user) {
            listUser.add(User.fromJson(user));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listUser;
  }
}
