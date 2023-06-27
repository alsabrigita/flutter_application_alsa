import 'package:flutter/material.dart';
import '../model/pasien.dart';
import '../service/pasien_service.dart';
import 'pasien_detail.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({Key? key}) : super(key: key);
  _PasienFormState createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomorRmCtrl = TextEditingController();
  final _namaPasienCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldnomorRm(),
              _fieldNamaPasien(),
              _fieldTanggalLahir(),
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

  _fieldnomorRm() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor Rm"),
      controller: _nomorRmCtrl,
    );
  }

  _fieldNamaPasien() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pasien"),
      controller: _namaPasienCtrl,
    );
  }

  _fieldTanggalLahir() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir"),
      controller: _tanggalLahirCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tanggal Lahir harus diisi';
        }
        return null;
      },
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          final formattedDate = pickedDate.toString().split(' ')[0];
          setState(() {
            _tanggalLahirCtrl.text = formattedDate;
          });
        }
      },
      readOnly: true, // Set the text field as read-only
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
        await PasienService().simpan(pasien).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PasienDetail(pasien: value),
            ),
          );
        });
      },
      child: const Text("Simpan"),
    );
  }
}
