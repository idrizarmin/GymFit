import 'package:gymfit_admin/models/notification.dart';
import 'package:gymfit_admin/models/searchObjects/notification_search.dart';
import 'package:gymfit_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/constants.dart';
import '../utils/authorization.dart';

class NotificationProvider extends BaseProvider {
  NotificationProvider() : super('Notifications/GetPaged');

  Future<List<Notifications>> getPaged(
      {NotificationsSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/Notifications/GetPaged');
    var headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};

    if (searchObject != null) {
      if (searchObject.content != null) {
        queryParameters['content'] = searchObject.content!;
      }

      if (searchObject.userId != null) {
        queryParameters['userId'] = searchObject.userId.toString();
      }

      if (searchObject.seen != null) {
        queryParameters['seen'] = searchObject.seen.toString();
      }
    }

    uri = uri.replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['items'];
      return items.map((d) => fromJson(d)).cast<Notifications>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<dynamic> insert(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/Notifications');
    Map<String, String> headers = Authorization.createHeaders();
    print('Resource  ${resource}');
    print('Uri  ${uri}');
    print('Headers  ${headers}');
    var jsonRequest = jsonEncode(resource);
    print('Ovo je request ${jsonRequest}');
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    print('${response.body} ${response.headers}');
    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<dynamic> edit(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/Notifications');
    Map<String, String> headers = Authorization.createHeaders();
    print('Uri  ${uri}');
    print('Headers  ${headers}');

    var jsonRequest = jsonEncode(resource);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<dynamic> delete(int id) async {
    var uri = Uri.parse('$apiUrl/Notifications/${id}');
    Map<String, String> headers = Authorization.createHeaders();

    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  @override
  Notifications fromJson(data) {
    return Notifications.fromJson(data);
  }
}
