import 'package:gymfit_admin/models/searchObjects/user_search.dart';
import 'package:gymfit_admin/models/user.dart';
import 'package:gymfit_admin/models/user_for_selection.dart';
import 'package:gymfit_admin/providers/base_provider.dart';
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
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['items'];
      return items.map((d) => fromJson(d)).cast<User>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<User>> getTrainers() async {
    final users = await get(null); // Dohvatite sve korisnike
    final trainers = users.where((user) => user.role == 2).toList();
    return trainers;
  }

  Future<List<User>> getPaged({UserSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/User/GetPaged');
    var headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};

    if (searchObject != null) {
      if (searchObject.name != null) {
        queryParameters['name'] = searchObject.name!;
      }

      if (searchObject.spol != null) {
        queryParameters['spol'] = searchObject.spol.toString();
      }

      if (searchObject.isActive != null) {
        queryParameters['isActive'] = searchObject.isActive.toString();
      }
      if (searchObject.isVerified != null) {
        queryParameters['isVerified'] = searchObject.isVerified.toString();
      }
      if (searchObject.PageNumber != null) {
        queryParameters['pageNumber'] = searchObject.PageNumber.toString();
      }
      if (searchObject.PageSize != null) {
        queryParameters['pageSize'] = searchObject.PageSize.toString();
      }
    }

    uri = uri.replace(queryParameters: queryParameters);
    print(uri);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['items'];
      return items.map((d) => fromJson(d)).cast<User>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<UserForSelection>> getusersForSelection(
      {UserSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/User/GetUsersForSelection');
    var headers = Authorization.createHeaders();

    print(uri);
    var response = await http.get(uri, headers: headers);
    print('response $response');

if (response.statusCode == 200) {
  var data = json.decode(response.body);
  if (data is List) {
    return data.map((d) => UserForSelection.fromJson(d)).toList();
  } else {
    throw Exception('Invalid data format');
  }
} else {
  throw Exception('Failed to load data');
}
    
  }

  @override
  Future<dynamic> insert(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/User');
    Map<String, String> headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};
    if (resource != null) {
      if (resource.firstName != null) {
        queryParameters['firstName'] = resource.firstName!;
      }
    }

    print('Ovo dođe u insert $resource');
    var jsonRequest = jsonEncode(resource);
    print('Encode od requesta: $jsonRequest');
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    print('Ovo je response   ${response.body}');
    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<dynamic> edit(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/User');
    Map<String, String> headers = Authorization.createHeaders();

    var jsonRequest = jsonEncode(resource);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
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
  Future<User> getById(int id) async {
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

  @override
  fromJson(data) {
    return User.fromJson(data);
  }
}
