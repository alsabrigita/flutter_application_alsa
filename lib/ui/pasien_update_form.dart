import 'package:flutter/material.dart';
import '../model/pasien.dart';
import '../service/pasien_service.dart';
import 'pasien_detail.dart';

class PasienUpdateForm extends StatefulWidget {
  final Pasien pasien;

  const PasienUpdateForm({Key? key, required this.pasien}) : super(key: key);
  _PasienUpdateFormState createState() => _PasienUpdateFormState();
}

class _PasienUpdateFormState extends State<PasienUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomorRmCtrl = TextEditingController();
  final _namaPasienCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  Future<Pasien> getData() async {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    setState(() {
      if (data.namaPasien != null) {
        _namaPasienCtrl.text = data.namaPasien;
      }
      if (data.nomorRm != null) {
        _nomorRmCtrl.text = data.nomorRm;
      }
      DateTime? tanggalLahir;
      if (tanggalLahir != null) {
        // Kode yang akan dijalankan jika tanggalLahir tidak null
        print('Tanggal lahir: $tanggalLahir');
      } else {
        // Kode yang akan dijalankan jika tanggalLahir null
        print('Tanggal lahir tidak tersedia');
      }
      if (data.nomorTelepon != null) {
        _nomorTeleponCtrl.text = data.nomorTelepon;
      }
      if (data.alamat != null) {
        _alamatCtrl.text = data.alamat;
      }
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNamaPasien(),
              _fieldtanggalLahir(),
              _fieldnomorTelepon(),
              _fieldalamat(),
              const SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNamaPasien() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pasien"),
      controller: _namaPasienCtrl,
    );
  }

  _fieldnomorRm() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor Rekam Medis"),
      controller: _nomorRmCtrl,
    );
  }

  _fieldtanggalLahir() {
    return TextField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir"),
      controller: _tanggalLahirCtrl,
    );
  }

  _fieldnomorTelepon() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor Telepon"),
      controller: _nomorTeleponCtrl,
    );
  }

  _fieldalamat() {
    return TextField(
      decoration: const InputDecoration(labelText: "Alamat"),
      controller: _alamatCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        Pasien pasien = new Pasien(
          nomorRm: _nomorRmCtrl.text,
          namaPasien: _namaPasienCtrl.text,
          tanggalLahir: DateTime.parse(_tanggalLahirCtrl.text),
          nomorTelepon: _nomorTeleponCtrl.text,
          alamat: _alamatCtrl.text,
        );
        String id = widget.pasien.id.toString();
        await PasienService().ubah(pasien, id).then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PasienDetail(pasien: value),
            ),
          );
        });
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
