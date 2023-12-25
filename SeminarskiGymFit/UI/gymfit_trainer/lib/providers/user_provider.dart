import 'package:gymfit_trainer/models/seaarchObjects/trainers_search_object.dart';
import 'package:gymfit_trainer/models/seaarchObjects/user_search_object.dart';
import 'package:gymfit_trainer/models/user.dart';
import 'package:gymfit_trainer/models/user_for_selection.dart';
import 'package:gymfit_trainer/providers/base_provider.dart';
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

 
Future<List<User>> getTrainersPaged(TrainersSearchObject? searchObject) async {
    var uri = Uri.parse('$apiUrl/User/GetTrainersPaged');
    var headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};

    if (searchObject != null) {
  
      if (searchObject.PageNumber != null) {
        queryParameters['PageNumber'] = searchObject.PageNumber.toString();
      }
      if (searchObject.PageSize != null) {
        queryParameters['PageSize'] = searchObject.PageSize.toString();
      }
    }

    uri = uri.replace(queryParameters: queryParameters);
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

    var response = await http.get(uri, headers: headers);

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

Future<List<UserForSelection>> getTrainersForSelection(
      {UserSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/User/GetTrainersForSelection');
    var headers = Authorization.createHeaders();

    var response = await http.get(uri, headers: headers);

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

  Future<dynamic> updateUser(Map<String, dynamic> updatedUserData) async {
  try {
    var uri = Uri.parse('$apiUrl/User');
    Map<String, String> headers = Authorization.createHeaders();

    var request = http.MultipartRequest('PUT', uri);

    // Convert dynamic values to strings
    var stringUpdatedUserData = updatedUserData.map((key, value) => MapEntry(key, value.toString()));

    // Add converted fields to the request
    request.fields.addAll(stringUpdatedUserData);

    // Add the photo to the request if it exists in the updated data
    if (updatedUserData.containsKey('ProfilePhoto')) {
      request.files.add(updatedUserData['ProfilePhoto']);
    }

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Error updating user: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error updating user: $e');
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

  @override
  fromJson(data) {
    return User.fromJson(data);
  }
}
