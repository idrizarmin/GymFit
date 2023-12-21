import 'package:gymfit_admin/models/searchObjects/bar_chart_search.dart';
import 'package:gymfit_admin/models/searchObjects/user_package_search_object.dart';
import 'package:gymfit_admin/models/user_package.dart';
import 'package:gymfit_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/constants.dart';
import '../utils/authorization.dart';

class UserPackageProvider extends BaseProvider<UserPackage> {
  UserPackageProvider() : super('UserPackages/GetPaged');

  Future<List<UserPackage>> getPaged(
      {UserPackageSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/UserPackages/GetPaged');
    var headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};
    if (searchObject != null) {
      if (searchObject.expired != null) {
        queryParameters['expired'] = searchObject.expired!.toString();
      }
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
      return items.map((d) => fromJson(d)).cast<UserPackage>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<dynamic> insert(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/UserPackages');
    Map<String, String> headers = Authorization.createHeaders();
    var jsonRequest = jsonEncode(resource);
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<dynamic> edit(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/UserPackages');
    Map<String, String> headers = Authorization.createHeaders();
    var jsonRequest = jsonEncode(resource);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

Future<List<dynamic>> getByMonth(BarChartSearchObject? searchObject) async {
    var uri = Uri.parse('$apiUrl/UserPackages/GetByMonth');
    var headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};
    if (searchObject != null) {
      if (searchObject.year != null) {
        queryParameters['year'] = searchObject.year.toString();
      }
    }
    

    uri = uri.replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> delete(int id) async {
    var uri = Uri.parse('$apiUrl/UserPackages/${id}');
    Map<String, String> headers = Authorization.createHeaders();

    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  @override
  UserPackage fromJson(data) {
    return UserPackage.fromJson(data);
  }
}
