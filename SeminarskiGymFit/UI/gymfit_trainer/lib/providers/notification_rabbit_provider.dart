import 'package:gymfit_trainer/models/notification.dart';
import 'package:gymfit_trainer/models/notificationRabbit.dart';
import 'package:gymfit_trainer/models/seaarchObjects/notification_search_object.dart';
import 'package:gymfit_trainer/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/constants.dart';
import '../utils/authorization.dart';

class NotificationRabbitProvider extends BaseProvider<NotificationRabbit> {
  NotificationRabbitProvider() : super('Notifications/GetPaged');

  Future<List<NotificationRabbit>> getPaged(
      {NotificationsSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/NotificationRabbit/GetPaged');
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
      return items.map((d) => fromJson(d)).cast<NotificationRabbit>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> setAsSeen(int id) async {
    var uri = Uri.parse('$apiUrl/NotificationRabbit/SetNotificationsAsSeen');
    Map<String, String> headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};
    queryParameters['id'] = id.toString();
    var response = await http.put(uri, headers: headers);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<dynamic> setAsDeleted(int id) async {
    var uri = Uri.parse('$apiUrl/NotificationRabbit/SetNotificationAsDeleted');
    Map<String, String> headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};
    queryParameters['id'] = id.toString();
    uri = uri.replace(queryParameters: queryParameters);

    var response = await http.put(uri, headers: headers);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  

 
  
  @override
  NotificationRabbit fromJson(data) {
    return NotificationRabbit.fromJson(data);
  }
}
