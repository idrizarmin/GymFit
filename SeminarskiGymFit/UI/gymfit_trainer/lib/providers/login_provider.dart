import 'dart:convert';
import 'package:gymfit_trainer/helpers/constants.dart';
import 'package:gymfit_trainer/models/user_login.dart';
import 'package:gymfit_trainer/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';


import '../utils/authorization.dart';

class UserLoginProvider extends BaseProvider  {
  UserLogin? user;

  UserLoginProvider() : super('User');

  refreshUser() async {
    user = await getById(int.parse(user!.Id));
  }

  @override
  Future<UserLogin> getById(int id) async {
    var uri = Uri.parse('$apiUrl/User/$id');

    var headers = Authorization.createHeaders();

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
 
  int? getUserId() {
    if (user != null) {
      return int.parse(user!.Id);
    }
    return null; 
  }
  Future<UserLogin> loginAsync(String email, String password) async {
    var url = '$apiUrl/Access/SignIn';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(response.body);
      user = UserLogin.fromJson(decodedToken);
      Authorization.token = user!.token;
      notifyListeners();
      return user!;
    } else {
      throw Exception(response.body);
    }
  }




  

  Future edit(user) async {
    var uri = Uri.parse('$apiUrl/User');
    Map<String, String> headers = Authorization.createHeaders();

    var jsonRequest = jsonEncode(user);
    var response = await http.put(uri, headers: headers, body: jsonRequest);
    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future chanagePassword(user) async {
    var uri = Uri.parse('$apiUrl/User/ChangePassword');
    Map<String, String> headers = Authorization.createHeaders();

    var jsonRequest = jsonEncode(user);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  void logout() {
    user = null;
    notifyListeners();
  }

  @override
  fromJson(data) {
    return UserLogin.fromJson(data);
  }
}