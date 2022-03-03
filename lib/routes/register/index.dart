import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/routes/login/index.dart';
import 'package:reksawaluya/utils/AllStyles.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late String email, password, name, nik, address, phone;
  final Network network = Get.find();

  _doLogin() async {
    var payload = {
      'email': email,
      'password': password,
      'name': name,
      'nik': nik,
      'address': address,
      'phone': phone,
    };
    final result = await network.doPost('/user/register/', jsonEncode(payload));
    var d = jsonDecode(result.body);
    if (d['status'] == 'OK') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(d['reason'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: AllStyles.primaryMenu(),
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          name = text;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Nama Lengkap',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide())))),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          nik = text;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'NIK',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide())))),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          address = text;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Alamat',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide())))),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          phone = text;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Nomor Telepon',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide())))),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
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
      ),
    );
  }
}
