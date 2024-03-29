import 'dart:convert';
import 'package:gymfit_admin/models/gym.dart';
import 'package:gymfit_admin/utils/authorization.dart';
import '../helpers/constants.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

class GymProvider extends BaseProvider<Gym> {
  GymProvider() : super('Gyms/GetPaged');

  @override
  Future<dynamic> insert(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/Gyms');
    Map<String, String> headers = Authorization.createHeaders();

    var jsonRequest = jsonEncode(resource);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<List<Gym>> getPaged() async {
    var uri = Uri.parse('$apiUrl/Gyms/GetPaged');
    var headers = Authorization.createHeaders();

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['items'];
      return items.map((d) => fromJson(d)).cast<Gym>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<Gym> getById(int id) async {
    var uri = Uri.parse('$apiUrl/Gyms/$id');

    var headers = Authorization.createHeaders();

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> edit(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/Gyms');
    Map<String, String> headers = Authorization.createHeaders();

    var jsonRequest = jsonEncode(resource);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  @override
  Gym fromJson(data) {
    return Gym.fromJson(data);
  }
}
