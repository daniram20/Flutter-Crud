import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crud_application/views/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/model.dart';
import 'package:crud_application/viemodels/user_vm.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  late String email = "", password = "", name = "", reTypePassword = "";

  register() async {
    if ((email == "") || (password == "") || (name == "")) {
      Fluttertoast.showToast(
          msg: "Semua Field harus diisi dengan data yang benar!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.yellow[300],
          textColor: Colors.red);
    } else {
      if (password != reTypePassword) {
        Fluttertoast.showToast(
            msg: "Password yang anda masukkan tidak sama!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.yellow[300],
            textColor: Colors.red);
      } else {
        showLoaderDialog(context);
        UserViewModel().createUser(name, email, password).then((value) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
      }
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah User Baru")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Nama Lengkap"),
            SizedBox(
              height: 25,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) => name = e,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Email Address"),
            SizedBox(
              height: 25,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) => email = e,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Password"),
            SizedBox(
              height: 25,
              child: TextField(
                obscureText: true,
                onChanged: (e) => password = e,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Retype Password"),
            SizedBox(
              height: 25,
              child: TextField(
                obscureText: true,
                onChanged: (e) => reTypePassword = e,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    child: const Text("Simpan")))
          ],
        ),
      ),
    );
  }
}
