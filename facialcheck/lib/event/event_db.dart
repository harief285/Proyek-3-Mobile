import 'dart:convert';
import 'dart:ffi';
import 'package:facialcheck/model/riwayat.dart';
import 'package:facialcheck/page/list_riwayat.dart';
import 'package:flutter/material.dart';
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

    try {
      var response = await http.post(Uri.parse(Api.login), body: {
        'email': email,
        'password': pass
      });

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          user = User.fromJson(responseBody['user']);
          if (user.type == '0') {
            EventPref.saveUser(user);
            Info.snackbar('Login Berhasil');
            Future.delayed(Duration(milliseconds: 1700), () {
              Get.off(() => Dashboard());
            });
          } else {
            EventPref.clear();
            Info.snackbar('Login Gagal');
            Future.delayed(Duration(milliseconds: 1700), () {
              Get.off(() => Login());
            });
          }
        } else {
          Info.snackbar("Login Gagal");
        }
      } else {
        Info.snackbar("Request Login Gagal");
      }
    } catch (e) {
      print(e);
      Info.snackbar("E-mail atau Password salah!");
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
  static Future<User?> addUser(String name, String email, String password, String passwordcek) async {

    try {
      var response = await http.post(Uri.parse(Api.add_user), body: {
        'name': name,
        'email': email,
        'password': password,
        'passwordcek': passwordcek
      });

      if (response.statusCode == 200) {
        Info.snackbar("Data Success");
        Future.delayed(Duration(milliseconds: 1700), () {
          Get.off(
              Login(),
          );
        });
      } else {
        Info.snackbar('Request Tambah Gagal');
      }

    } catch (e) {
      print(e);
    }
  }

  static Future<Riwayat?> addRiwayat(String userId, String prediksi, String Persentase, String gambar) async {
    
    try {
      double persen = double.parse(Persentase)*100;

      int persen2 = persen.toInt();


      var response = await http.post(Uri.parse(Api.add_riwayat), body: {
        'user_id': userId,
        'prediksi': prediksi,
        'presentase': persen2.toString(),
        'gambar': gambar,
        });

      if (response.statusCode == 200) {
        Future.delayed(Duration(milliseconds: 1700), () {
          Get.off(
              Dashboard(),
          );
        });
      } else {
        Info.snackbar('Request Tambah Gagal');
      }

    } catch (e) {
      print(e);
    }
  }


  static Future<List<Riwayat>> getRiwayat(String id) async {
    List<Riwayat> listRiwayat = [];

    try {
      var response = await http.post(Uri.parse(Api.list_riwayat), body: {
        'user_id': id,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          var riwayats = responseBody['user'];
          for (var riwayat in riwayats) {
            listRiwayat.add(Riwayat.fromJson(riwayat));
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return listRiwayat;
  }
}