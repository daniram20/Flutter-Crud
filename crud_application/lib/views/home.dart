import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../models/model.dart';
import '../viemodels/user_vm.dart';
import 'create.dart';
import 'edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List dataUser = [];
  void getDataUser() async {
    UserViewModel().getUsers().then((value) {
      setState(() {
        dataUser = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  // Widget personDetailCard(String name, String username, String email) {
  Widget userDetail(User data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Text(
                    "Name :",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    data.name,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Email :",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    data.email,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Password :",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    data.password,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  hapusUser(String id) {
    UserViewModel().deleteUser(id).then((value) => getDataUser());
  }

  updateUser(User user) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => EditUserScreen(
              user: user,
            )));
  }

  showDetailDialog(User data) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Detail User'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ID : ${data.id}"),
                    Text("Name : ${data.name}"),
                    Text("Email : ${data.email}"),
                    Text("Password : ${data.password}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              hapusUser(data.id);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Hapus")),
                        ElevatedButton(
                            onPressed: () {
                              updateUser(data);
                            },
                            child: const Text("Edit"))
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Utama"),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, i) {
            return GestureDetector(
                onTap: () {
                  showDetailDialog(dataUser[i]);
                },
                child: userDetail(dataUser[i]));
          },
          // ignore: unnecessary_null_comparison
          itemCount: dataUser == null ? 0 : dataUser.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateUserScreen()))
        },
        heroTag: 'createNew',
        backgroundColor: const Color(0xFF242569),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
