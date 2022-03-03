import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/routes/home/index.dart';
import 'package:reksawaluya/utils/AllStyles.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late String email, password;
  final Network network = Get.find();

  _doLogin() async {
    var payload = {'email': email, 'password': password};
    final result = await network.doPost('/user/token/', jsonEncode(payload));
    var d = jsonDecode(result.body);
    if (d['status'] == 'OK') {
      await network.addToken(d['token']);
      final fetchRole = await network.doGet('/user/detail/');
      d = jsonDecode(fetchRole.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(Constant.roleKey, d['role']);
      await prefs.setString(Constant.emailKey, d['email']);
      await prefs.setString(Constant.nameKey, d['name']);
      await prefs.setString(Constant.nikKey, d['nik']);
      await prefs.setString(Constant.addressKey, d['address']);
      await prefs.setString(Constant.phoneKey, d['phone']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login gagal.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: AllStyles.primaryMenu(),
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        email = text;
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide())))),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        password = text;
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide())))),
              ElevatedButton(onPressed: _doLogin, child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
