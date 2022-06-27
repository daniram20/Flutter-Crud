import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/model.dart';

class UserViewModel {
  Future getUsers() async {
    try {
      http.Response hasil = await http.get(
          Uri.parse("http://10.0.2.2/crud_php_api/list.php"),
          headers: {"Accept": "application/json"});
      if (hasil.statusCode == 200) {
        // print(hasil.body);
        final data = userFromJson(hasil.body);
        return data;
      } else {
        // print("error status " + hasil.statusCode.toString());
        return null;
      }
    } catch (e) {
      //print("error catch $e");
      return null;
    }
  }

  Future deleteUser(String id) async {
    Map data = {"id": id};

    try {
      http.Response hasil = await http.post(
          Uri.parse("http://10.0.2.2/crud_php_api/delete.php"),
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      if (hasil.statusCode == 200) {
        return true;
      } else {
        // print("error status " + hasil.statusCode.toString());
        return false;
      }
    } catch (e) {
      // print("error catch $e");
      return false;
    }
  }

  Future createUser(String name, String email, String password) async {
    Map data = {"name": name, "email": email, "password": password};
    try {
      http.Response hasil = await http.post(
          Uri.parse("http://10.0.2.2/crud_php_api/create.php"),
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      if (hasil.statusCode == 200) {
        return true;
      } else {
        // print("error status " + hasil.statusCode.toString());
        return false;
      }
    } catch (e) {
      // print("error catch $e");
      return false;
    }
  }

  Future editUser(String id, String name, String email, String password) async {
    Map data = {"id": id, "name": name, "email": email, "password": password};

    try {
      http.Response hasil = await http.post(
          Uri.parse("http://10.0.2.2/crud_php_api/update.php"),
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      if (hasil.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
