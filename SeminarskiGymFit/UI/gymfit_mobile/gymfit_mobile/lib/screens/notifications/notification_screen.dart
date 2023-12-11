import 'package:flutter/material.dart';
import 'package:gymfit_mobile/models/notifications.dart';
import 'package:gymfit_mobile/models/searchObjects/notification_search_object.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/notification_provider.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:provider/provider.dart';

class NotificationForm extends StatefulWidget {
  @override
  _NotificationFormState createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  List<Notifications> notifications = <Notifications>[];
  late NotificationProvider _notificationProvider;
  late UserLoginProvider _loginProvider;
  int? _userId;

  @override
  void initState() {
    super.initState();

    _loginProvider = context.read<UserLoginProvider>();
    _notificationProvider = context.read<NotificationProvider>();
    loadUser();

    loadNotifications();
  }

  void loadUser() async {
    var id = _loginProvider.getUserId();
    print(id);
    _userId = id;
  }

  void setAsDeleted(int id) async {
    _notificationProvider.setAsDeleted(id);
  }

  void loadNotifications() async {
    try {
      NotificationsSearchObject searchObject =
          NotificationsSearchObject(userId: _userId);

      var notificationsResponse =
          await _notificationProvider.getPaged(searchObject: searchObject);
      setState(() {
        notifications = notificationsResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  int countUnreadNotifications() {
    return notifications
        .where((notification) => notification.Read == false)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildTitle(),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return buildNotificationItem(
                        notifications[index].content, notifications[index].id);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 54, 222, 244),
                    ),
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotificationItem(String content, int id) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              content,
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            color: Colors.white,
            onPressed: () {
              setState(() {
                notifications.removeWhere((element) => element.id == id);
              });
              setAsDeleted(id);

              // });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "Obavijesti",
          style: TextStyle(
            color: Color.fromARGB(218, 0, 0, 70),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
