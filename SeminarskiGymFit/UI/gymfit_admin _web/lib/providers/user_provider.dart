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
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['items'];
      return items.map((d) => fromJson(d)).cast<User>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<int> getCountOfUsers() async {
    var uri = Uri.parse('$apiUrl/User/GetCountUsers');
    var headers = Authorization.createHeaders();
    
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
        return data;      
    } else {
      throw Exception('Failed to load data');
    }
  }
Future<int> getCountOfUsersActive() async {
    var uri = Uri.parse('$apiUrl/User/GetCountActiveUsers');
    var headers = Authorization.createHeaders();
    
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
        return data;      
    } else {
      throw Exception('Failed to load data');
    }
  }Future<int> getCountOfUsersInactive() async {
    var uri = Uri.parse('$apiUrl/User/GetCountInactiveUsers');
    var headers = Authorization.createHeaders();
    
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
        return data;      
    } else {
      throw Exception('Failed to load data');
    }
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
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['items'];
      return items.map((d) => fromJson(d)).cast<User>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
Future<List<User>> getAdminsPaged({UserSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/User/GetAdminsPaged');
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
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['items'];
      return items.map((d) => fromJson(d)).cast<User>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<User>> getTrainersPaged({UserSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/User/GetTrainersPaged');
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

Future<dynamic> insertUser(Map<String, dynamic> userData) async {
  try {
    var uri = Uri.parse('$apiUrl/User');
    Map<String, String> headers = Authorization.createHeaders();

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    var stringUserData = userData.map((key, value) => MapEntry(key, value.toString()));

    request.fields.addAll(stringUserData);

    if (userData.containsKey('ProfilePhoto')) {
      request.files.add(userData['ProfilePhoto']);
    }

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Error inserting user: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error inserting user: $e');
  }
}

 Future<dynamic> updateUser(Map<String, dynamic> updatedUserData) async {
  try {
    var uri = Uri.parse('$apiUrl/User');

    Map<String, String> headers = Authorization.createHeaders();
    var request = http.MultipartRequest('PUT', uri);
    request.headers.addAll(headers);
    var stringUpdatedUserData = updatedUserData.map((key, value) => MapEntry(key, value.toString()));
    request.fields.addAll(stringUpdatedUserData);

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
