import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/notification.dart';
import 'package:gymfit_admin/models/searchObjects/notification_search.dart';
import 'package:gymfit_admin/models/user_for_selection.dart';
import 'package:gymfit_admin/providers/notification_provider.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:intl/intl.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
  int pageSize = 20;
  int hasNextPage = 0;

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(bottom: defaultPadding / 2),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 18, 16, 50),
                  width: 2.0,
                ),
              ),
            ),
            child: const Header(pageTitle: "Obavjesti"),
          ),
          const SizedBox(
            height: 16,
          ),
          buildButtonsAndFilters(context),
          SizedBox(
            height: 16,
          ),
          buildDataView(context),
           SizedBox(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: myButtonColor
                ),
                onPressed: () {
                  if (currentPage > 1) {
                    setState(() {
                      currentPage--;
                    });
                    loadNotifications(NotificationsSearchObject(
                      PageNumber: currentPage,
                      PageSize: pageSize,
                      content: _contentController.text,
                    ));
                  }
                },
                child: const Icon(Icons.arrow_left_outlined),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(backgroundColor: myButtonColor),
                onPressed: () {
                  setState(() {
                    if (hasNextPage == pageSize) {
                    currentPage++;
                    }
                  });
                  if (hasNextPage == pageSize) {
                    loadNotifications(NotificationsSearchObject(
                      PageNumber: currentPage,
                      PageSize: pageSize,
                      content: _contentController.text,
                    ));
                  }
                },
                child: const Icon(Icons.arrow_right_outlined),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Row buildButtonsAndFilters(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: secondaryColor,
                  title: Text("Kreiraj obavijest"),
                  content: SingleChildScrollView(child: AddNotificationForm()),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: myButtonColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Zatvori"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: myButtonColor,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedUsers.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Greška"),
                                  content: Text(
                                      "Obavezno odabrati barem jednog korisnika."),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: myButtonColor,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            // Validacija uspješna, nastavite s spremanjem obavijesti
                            for (var user in selectedUsers) {
                              InsertNotification(user.id);
                            }
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Text("Spremi"),
                    ),
                  ],
                );
              },
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'Dodaj',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
          ),
          onPressed: () {
            if (selectedNotifications.isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Upozorenje"),
                      content: Text(
                          "Morate odabrati jednu obavijest za  uređivanje"),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: myButtonColor),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  });
            } else if (selectedNotifications.length > 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Upozorenje"),
                      content: Text(
                          "Odaberite samo jednu obavjest koju želite urediti"),
                      actions: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonColor),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Ok"))
                      ],
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: secondaryColor,
                      title: Text("Uredi obavijest"),
                      content: AddNotificationForm(
                          isEditing: true,
                          notificationToEdit: selectedNotifications[0]),
                      actions: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonColor),
                            onPressed: () {
                              loadUsers();
                              Navigator.of(context).pop();
                            },
                            child: Text("Zatvori")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonColor),
                            onPressed: () {
                              EditNotification(selectedNotifications[0].id);
                              Navigator.of(context).pop();
                              selectedNotifications = [];
                              loadUsers();
                            },
                            child: Text("Spremi")),
                      ],
                    );
                  });
            }
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'Izmjeni',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
          ),
          onPressed: selectedNotifications.isEmpty
              ? () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("Upozorenje"),
                            content: Text(
                                "Morate odabrati obavijest koju želite obrisati."),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ]);
                      });
                }
              : () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Izbriši obavijest!"),
                        content: SingleChildScrollView(
                          child: Text(
                              "Da li ste sigurni da želite obrisati obavijest?"),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Odustani"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              for (Notifications n in selectedNotifications) {
                                DeleteNotification(n.id);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text("Obriši"),
                          ),
                        ],
                      );
                    },
                  );
                },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_forever_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'Obriši',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 400, // Adjust the width as needed
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Pretraga",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding * 0.75),
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Search.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down_outlined),
              value: _seenController.text,
              items: <String>['Sve', 'Pregledane', 'Nepregledane']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(value),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                _seenController.text = newValue ?? '';
                loadNotifications(NotificationsSearchObject(
                    seen: _seenController.text == 'Pregledane'
                        ? true
                        : _seenController.text == 'Nepregledane'
                            ? false
                            : null));
              },
              underline: const Text(""),
            ),
          ),
        ),
      ],
    );
  }

  Widget AddNotificationForm(
      {bool isEditing = false, Notifications? notificationToEdit}) {
    if (notificationToEdit != null) {
      _contentController.text = notificationToEdit.content;

      UserForSelection? selectedUser = users.firstWhere(
        (user) => user.id == notificationToEdit.userId,
        orElse: () => UserForSelection(id: 0, firstName: '', lastName: ''),
      );

      // Postavite odabrane korisnike na korisnika iz obavijesti koju uređujete
      selectedUsers = [selectedUser];
    } else {
      selectedUsers = [];
      _contentController.text = '';
      loadUsers();
    }
    return Container(
      height: 450,
      width: 950,
      color: secondaryColor,
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _contentController,
                    decoration:
                        InputDecoration(labelText: ' Sadržaj obavijesti:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obavezan unos!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: MultipleSearchSelection<UserForSelection>(
                      searchFieldBoxDecoration: BoxDecoration(
                          color: secondaryColor,
                          border: Border.all(color: Colors.white)),
                      searchFieldInputDecoration:
                          const InputDecoration(hintText: ' Odaberi klijente'),

                      items: isEditing ? selectedUsers : users,
                      onTapSelectAll: () {
                        selectedUsers = users;
                      },
                      onTapClearAll: () {
                        setState(() {
                          selectedUsers = [];
                        });
                      },
                      onPickedChange: (List<UserForSelection> items) {
                        setState(() {
                          selectedUsers = items;
                        });
                      },
                      pickedItemBuilder: (UserForSelection user) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text('${user.firstName} ${user.lastName}'),
                          ),
                        );
                      },
                      onTapShowedItem: () {},
                      //onPickedChange: (List<Country> items) {},
                      onItemAdded: (UserForSelection item) {},
                      onItemRemoved: (UserForSelection item) {},
                      sortShowedItems: true,
                      sortPickedItems: true,
                      fuzzySearch: FuzzySearch.jaro,
                      itemsVisibility: ShowedItemsVisibility.alwaysOn,

                      title: Text(
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
                      itemBuilder: (UserForSelection user, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(),
                              child: Text('${user.firstName} ${user.lastName}'),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildDataView(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minWidth: MediaQuery.of(context).size.width),
          child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.white, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DataTable(
                dataRowColor: MaterialStateProperty.all(
                    const Color.fromARGB(42, 241, 241, 241)),
                columns: [
                  DataColumn(
                      label: Checkbox(
                          value: isAllSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              isAllSelected = value ?? false;
                              notifications.forEach((notificationItem) {
                                notificationItem.isSelected = isAllSelected;
                              });

                              if (!isAllSelected) {
                                selectedNotifications.clear();
                              } else {
                                selectedNotifications =
                                    List.from(notifications);
                              }
                            });
                          })),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        "Content",
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Korisnik",
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Datum slanja",
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      child: Text(
                        "Viđeno",
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ],
                rows: notifications.map((notificationItem) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Checkbox(
                          value: notificationItem.isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              notificationItem.isSelected = value ?? false;
                              if (notificationItem.isSelected == true) {
                                selectedNotifications.add(notificationItem);
                              } else {
                                selectedNotifications.remove(notificationItem);
                              }
                              isAllSelected = notifications.every(
                                  (notification) => notification.isSelected);
                            });
                          },
                        ),
                      ),
                      DataCell(Text(notificationItem.content)),
                      DataCell(
                        Text(
                            '${notificationItem.user!.firstName} ${notificationItem.user!.lastName}?? '
                            ' '),
                      ),
                      DataCell(
                        Text(
                          notificationItem.SendOnDate != null
                              ? DateFormat('dd/MM/yyyy')
                                  .format(notificationItem.SendOnDate!)
                              : '--',
                        ),
                      ),
                      DataCell(Container(
                        alignment: Alignment.centerLeft,
                        child: notificationItem.Read == true
                            ? Icon(
                                Icons.check_outlined,
                                color: primaryColor,
                              )
                            : Icon(
                                Icons.close_outlined,
                                color: Colors.red,
                              ),
                      )),
                    ],
                  );
                }).toList(),
              )),
        ),
      ),
    );
  }
}
