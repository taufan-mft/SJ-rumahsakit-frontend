import 'package:flutter/material.dart';
import 'package:reksawaluya/routes/home/components/Admin/index.dart';
import 'package:reksawaluya/routes/home/components/Pasien/index.dart';
import 'package:reksawaluya/routes/home/components/Poliklinik/index.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  Widget mainScreen = Container();
  String appTitle = '';
  String name = '';
  String email = '';

  _determineScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constant.nameKey)!;
    email = prefs.getString(Constant.emailKey)!;
    int? role = prefs.getInt(Constant.roleKey);
    if (role == Constant.rolePatient) {
      mainScreen = const PasienView();
      appTitle = 'Hai, Pasien';
    }
    if (role == Constant.roleAdmin) {
      mainScreen = const AdminView();
      appTitle = 'Hai, Admin';
    }
    if (role == Constant.rolePoli) {
      mainScreen = const PoliklinikView();
      appTitle = 'Hai, Poli';
    }
    setState(() {});

  }

  @override
  void initState() {
    super.initState();
    _determineScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: mainScreen,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name),
                    Text(email)
                  ],
                ),
              ),
              ListTile(
                title: const Text('Akun'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Info Aplikasi'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
    );
  }
}
