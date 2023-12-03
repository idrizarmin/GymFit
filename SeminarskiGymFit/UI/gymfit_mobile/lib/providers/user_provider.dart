import 'package:gymfit_mobile/models/user.dart';
import 'package:gymfit_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/constants.dart';
import '../utils/authorization.dart';

class UserProvider extends BaseProvider {
  UserProvider() : super('User');
  User? user;
  refreshUser() async {
    user = await getById(user!.id);
  }

  @override
  Future<List<User>> get(Map<String, String>? params) async {
    var uri = Uri.parse('$apiUrl/User/GetPaged');
    var headers = Authorization.createHeaders();
    if (params != null) {
      uri = uri.replace(queryParameters: {'name': params.values});
    }
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['items'];
      return items.map((d) => fromJson(d)).cast<User>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<User>> getTrainers() async {
    var uri = Uri.parse('$apiUrl/User/GetAllTrainers');
    var headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};

    uri = uri.replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: headers);
    print(response);
    if (response.statusCode == 200) {

      var data = json.decode(response.body);
      print("data $data");
      return data.map((d) => fromJson(d)).cast<User>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> delete(int id) async {
    var uri = Uri.parse('$apiUrl/User/${id}');
    Map<String, String> headers = Authorization.createHeaders();

    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  @override
  fromJson(data) {
    return User.fromJson(data);
  }
}
