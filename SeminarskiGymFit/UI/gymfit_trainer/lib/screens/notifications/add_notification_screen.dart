import 'package:flutter/material.dart';
import 'package:gymfit_trainer/helpers/app_decoration.dart';
import 'package:gymfit_trainer/helpers/constants.dart';
import 'package:gymfit_trainer/helpers/theme_helper.dart';
import 'package:gymfit_trainer/models/notification.dart';
import 'package:gymfit_trainer/models/seaarchObjects/notification_search_object.dart';
import 'package:gymfit_trainer/models/user_for_selection.dart';
import 'package:gymfit_trainer/providers/notification_provider.dart';
import 'package:gymfit_trainer/providers/user_provider.dart';
import 'package:gymfit_trainer/utils/error_dialog.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({Key? key}) : super(key: key);

  @override
  State<AddNotificationScreen> createState() => _AddNotificationsScreenState();
}

class _AddNotificationsScreenState extends State<AddNotificationScreen> {
  List<Notifications> notifications = <Notifications>[];
  List<Notifications> selectedNotifications = <Notifications>[];
  List<UserForSelection> users = <UserForSelection>[];
  List<UserForSelection> selectedUsers = <UserForSelection>[];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  TextEditingController _seenController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime.now();
  late NotificationProvider _notificationProvider;
  late UserProvider _userProvider;
  bool isEditing = false;
  bool isAllSelected = false;
  int currentPage = 1;
  int pageSize = 1000000;
  int hasNextPage = 0;
  late MediaQueryData mediaQueryData;

  @override
  void initState() {
    super.initState();
    _notificationProvider = NotificationProvider();
    _userProvider = UserProvider();
    _seenController = TextEditingController(text: 'Sve');
    _searchController = TextEditingController(text: '');
    loadNotifications(NotificationsSearchObject(
      PageNumber: currentPage,
      PageSize: pageSize,
    ));
    loadUsers();
    _searchController.addListener(() {
      final searchQuery = _searchController.text;
      final seen = _seenController.text;

      if (seen == 'Pregledane' || seen == 'Nepregledane') {
        loadNotifications(NotificationsSearchObject(
            seen: seen == 'Pregledane',
            content: searchQuery,
            PageNumber: currentPage,
            PageSize: pageSize));
      } else {
        loadNotifications(NotificationsSearchObject(
            content: searchQuery, PageNumber: currentPage, PageSize: pageSize));
      }
    });

    _userIdController.addListener(() {
      final userId = _userIdController.text;
      loadNotifications(
          NotificationsSearchObject(userId: int.tryParse(userId)));
    });

    _seenController.addListener(() {
      final seen = _seenController.text;
      if (seen == 'Pregledane') {
        loadNotifications(NotificationsSearchObject(
            seen: true,
            content: _searchController.text,
            PageNumber: currentPage,
            PageSize: pageSize));
      } else if (seen == 'Nepregledane') {
        loadNotifications(NotificationsSearchObject(
            seen: false,
            content: _searchController.text,
            PageNumber: currentPage,
            PageSize: pageSize));
      } else {
        loadNotifications(NotificationsSearchObject(
            content: _searchController.text,
            PageNumber: currentPage,
            PageSize: pageSize));
      }
    });
  }

  void loadUsers() async {
    try {
      var usersResponse = await _userProvider.getusersForSelection();
      setState(() {
        users = usersResponse;
        print(users);
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadNotifications(NotificationsSearchObject searchObject) async {
    try {
      var notificationsResponse =
          await _notificationProvider.getPaged(searchObject: searchObject);
      setState(() {
        notifications = notificationsResponse;
        hasNextPage = notifications.length;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void InsertNotification(int id) async {
    try {
      var newNotification = {
        "id": 0,
        "content": _contentController.text,
        "read": false,
        "deleted": false,
        "dateRead": null,
        "sendOnDate": DateTime.now().toUtc().toIso8601String(),
        "seen": null,
        "userId": id
      };
      var notification = await _notificationProvider.insert(newNotification);
      if (notification == "OK") {
        currentPage == 1;
        loadNotifications(NotificationsSearchObject(
            PageNumber: currentPage, PageSize: pageSize));
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Color(0XFF12B422),
              content: Text('Uspjesno poslana obavijest.',
                  style: TextStyle(
                    color: Colors.white,
                  ))),
        );
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void EditNotification(int id) async {
    try {
      var newNotification = {
        "id": id,
        "content": _contentController.text,
        "read": false,
        "deleted": false,
        "dateRead": null,
        "sendOnDate": DateTime.now().toUtc().toIso8601String(),
        "seen": null,
        "userId": selectedUsers[0].id
      };
      var change = await _notificationProvider.edit(newNotification);
      if (change == "OK") {
        currentPage = 1;
        loadNotifications(NotificationsSearchObject(
            PageNumber: currentPage, PageSize: pageSize));
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void DeleteNotification(int id) async {
    try {
      var actor = await _notificationProvider.delete(id);
      if (actor == "OK") {
        currentPage = 1;
        loadNotifications(NotificationsSearchObject(
            PageNumber: currentPage, PageSize: pageSize));
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.bgSecondary,
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 1,
                  ),
                  decoration: AppDecoration.fillBlack,
                  child: Text(
                    "Kreiranje obavijesti",
                    style: TextStyle(fontSize: 14, color: white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Container(
                      width: 950,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Kreiraj obavijest',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextFormField(
                                    controller: _contentController,
                                    decoration: InputDecoration(
                                      labelText: ' Sadržaj obavijesti:',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Obavezan unos!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child:
                                      MultipleSearchSelection<UserForSelection>(
                                    items: isEditing ? selectedUsers : users,
                                    onTapSelectAll: () {
                                      selectedUsers = users;
                                    },
                                    onTapClearAll: () {
                                      setState(() {
                                        selectedUsers = [];
                                      });
                                    },
                                    onPickedChange:
                                        (List<UserForSelection> items) {
                                      setState(() {
                                        selectedUsers = items;
                                      });
                                    },
                                    pickedItemBuilder: (UserForSelection user) {
                                      return Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                              '${user.firstName} ${user.lastName}'),
                                        ),
                                      );
                                    },
                                    onTapShowedItem: () {},
                                    onItemAdded: (UserForSelection item) {},
                                    onItemRemoved: (UserForSelection item) {},
                                    sortShowedItems: true,
                                    sortPickedItems: true,
                                    fuzzySearch: FuzzySearch.jaro,
                                    itemsVisibility:
                                        ShowedItemsVisibility.alwaysOn,
                                    title: const Text(
                                      'Odaberite klijente',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    showSelectAllButton: true,
                                    maximumShowItemsHeight: 200,
                                    fieldToCheck: (UserForSelection u) {
                                      return u.firstName;
                                    },
                                    itemBuilder:
                                        (UserForSelection user, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(),
                                            child: Text(
                                                '${user.firstName} ${user.lastName}'),
                                          ),
                                        ),
                                      );
                                    },
                                    searchField: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Pretraži klijente',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: teal
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()){
                                for (var user in selectedUsers) {
                                  InsertNotification(user.id);
                                }
                                  setState(() {
                                    _contentController.text ="";
                                  });
                                }
                              },
                              child: Text('Pošalji',style: TextStyle(color: white),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
