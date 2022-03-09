import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DPPasienView extends StatefulWidget {
  const DPPasienView({Key? key}) : super(key: key);

  @override
  _DPPasienViewState createState() => _DPPasienViewState();
}

class _DPPasienViewState extends State<DPPasienView> {
  final Network network = Get.find();
  final _cName = TextEditingController();
  final _cTanggal = TextEditingController();
  final _cJenis = TextEditingController();
  final _cNik = TextEditingController();
  final _cAlamat = TextEditingController();
  final _cTelpon = TextEditingController();
  final _cBpjs = TextEditingController();
  bool _isEdit = false;
  String? medicalRecord;

  _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    medicalRecord = prefs.getString(Constant.medRecordKey);
    log('the med record $medicalRecord');
    if (medicalRecord != '-') {
      final result = await network.doGet('/pasien/detail/$medicalRecord');
      final d = jsonDecode(result.body);
      if (d['status'] == 'OK') {
        _cName.text = d['name'];
        _cTanggal.text = d['date'];
        _cJenis.text = d['gender'];
        _cNik.text = d['nik'];
        _cAlamat.text = d['address'];
        _cTelpon.text = d['telp'];
        _cBpjs.text = d['bpjs'];
        _isEdit = true;
      }
    }
  }

  _doSave() async {
    if (!_isEdit) {
      final p = {
        'name': _cName.text,
        'date': _cTanggal.text,
        'gender': _cJenis.text,
        'nik': _cNik.text,
        'address': _cAlamat.text,
        'telp': _cTelpon.text,
        'bpjs': _cBpjs.text,
      };
      final result = await network.doPost('/pasien/modify/', jsonEncode(p));
      var d = jsonDecode(result.body);
      if (d['status'] == 'OK') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(Constant.medRecordKey, d['medical_record']);
        await _fetchData();
        ScaffoldMessenger.of(context)
            .showSnackBar(
            const SnackBar(content: Text('Simpan data berhasil.')));
      }
    } else {
      final p = {
        'name': _cName.text,
        'date': _cTanggal.text,
        'gender': _cJenis.text,
        'nik': _cNik.text,
        'address': _cAlamat.text,
        'telp': _cTelpon.text,
        'bpjs': _cBpjs.text,
        'medical_record': medicalRecord,
      };
      final result = await network.doPut('/pasien/modify/', jsonEncode(p));
      var d = jsonDecode(result.body);
      if (d['status'] == 'OK') {
        ScaffoldMessenger.of(context)
            .showSnackBar(
            const SnackBar(content: Text('Update data berhasil.')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                    controller: _cName,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      // name = text;
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
                  controller: _cTanggal,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      // name = text;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Tempat, Tanggal Lahir',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide())))),
            Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _cJenis,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      // name = text;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Jenis Kelamin',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide())))),
            Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _cNik,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      // name = text;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Nomor Induk Kependudukan (NIK)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide())))),
            Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _cAlamat,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      // name = text;
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
                  controller: _cTelpon,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      // name = text;
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
                  controller: _cBpjs,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      // name = text;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Nomor BPJS',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide())))),
            ElevatedButton(onPressed: () => _doSave(), child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}
