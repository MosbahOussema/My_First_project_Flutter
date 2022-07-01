import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/contact.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_sms/flutter_sms.dart';

class SmsScreen extends StatefulWidget {
  const SmsScreen({Key? key}) : super(key: key);

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  List<ContactItem> contacts = [
    ContactItem(
        id: 3, name: "Ahmed", phone: "21986320", icon: Icons.person, type: 2),
    ContactItem(
        id: 4, name: "Hosni", phone: "25206987", icon: Icons.person, type: 2),
    ContactItem(
        id: 5, name: "Brahim", phone: "50147789", icon: Icons.person, type: 2),
    ContactItem(
        id: 6, name: "Amal", phone: "98100200", icon: Icons.person, type: 2),
    ContactItem(
        id: 7, name: "Olfa", phone: "22478963", icon: Icons.person, type: 2),
    ContactItem(
        id: 8, name: "Oussema", phone: "20142398", icon: Icons.person, type: 2),
    ContactItem(
        id: 9, name: "Farah", phone: "55214710", icon: Icons.person, type: 3),
    ContactItem(
        id: 10, name: "Aya", phone: "20023698", icon: Icons.person, type: 3),
    ContactItem(
        id: 11, name: "Khalil", phone: "22778899", icon: Icons.person, type: 3),
    ContactItem(
        id: 12,
        name: "Mohamed",
        phone: "21100200",
        icon: Icons.person,
        type: 3),
    ContactItem(
        id: 13, name: "Nahed", phone: "50111993", icon: Icons.person, type: 3),
    ContactItem(
        id: 14, name: "Nihed", phone: "98144855", icon: Icons.person, type: 3),
    ContactItem(
        id: 15, name: "Borhen", phone: "24569336", icon: Icons.person, type: 4),
    ContactItem(
        id: 16,
        name: "Kawther",
        phone: "20447331",
        icon: Icons.person,
        type: 4),
    ContactItem(
        id: 17,
        name: "Haythem",
        phone: "52667774",
        icon: Icons.person,
        type: 4),
    ContactItem(
        id: 18, name: "Ali", phone: "20119885", icon: Icons.person, type: 4),
    ContactItem(
        id: 18, name: "Amal", phone: "2177966", icon: Icons.person, type: 4),
    ContactItem(
        id: 19,
        name: "Khaoula",
        phone: "21111111",
        icon: Icons.person,
        type: 4),
    ContactItem(
        id: 20, name: "Nader", phone: "98114556", icon: Icons.person, type: 4),
  ];

  List<ContactItem> contactSelected = [];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  List<String> categories = ['Family', 'Friends', 'Doctors'];

  bool sos = false;
  bool family = false;
  bool friends = false;
  bool doctor = false;
  bool addButton = false;
  int? selectedCategory;
  String? selectedValue;

  selectedItem(int choice) {
    if (choice == 1) {
      setState(() {
        sos = true;
        family = false;
        friends = false;
        doctor = false;
      });
    } else if (choice == 2) {
      setState(() {
        sos = false;
        family = true;
        friends = false;
        doctor = false;
      });
    } else if (choice == 3) {
      setState(() {
        sos = false;
        family = false;
        friends = true;
        doctor = false;
      });
    } else {
      setState(() {
        sos = false;
        family = false;
        friends = false;
        doctor = true;
      });
    }
  }

  selectContactListType(int type) {
    setState(() {
      contactSelected =
          contacts.where((element) => element.type == type).toList();
    });
  }

  void saveNewContact() {
    if (_nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add a name", fontSize: 16.0);
      return;
    }
    if (_phoneController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add a phone", fontSize: 16.0);
      return;
    }
    if (selectedCategory == null) {
      Fluttertoast.showToast(msg: "Please select a category", fontSize: 16.0);
      return;
    }

    setState(() {
      ContactItem newContact = ContactItem();
      newContact.icon = Icons.person;
      newContact.name = _nameController.text;
      newContact.phone = _phoneController.text;
      newContact.type = selectedCategory;
      contactSelected.add(newContact);

      _nameController.text = '';
      _phoneController.text = '';
      selectedCategory = null;
      selectedValue = null;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      family = true;
    });
    selectContactListType(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      selectedItem(2);
                      selectContactListType(2);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            color: family
                                ? Colors.green.withOpacity(0.5)
                                : Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          "assets/images/family.png",
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedItem(3);
                      selectContactListType(3);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            color: friends
                                ? Colors.green.withOpacity(0.5)
                                : Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          "assets/images/friends.png",
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedItem(4);
                      selectContactListType(4);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            color: doctor
                                ? Colors.green.withOpacity(0.5)
                                : Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          "assets/images/doctor.png",
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/images/add.png",
                        width: 120,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    if (addButton) {
                      setState(() {
                        addButton = false;
                      });
                    } else {
                      setState(() {
                        addButton = true;
                      });
                    }
                  },
                  icon: addButton ? Icon(Icons.close) : Icon(Icons.add))),
          addButton
              ? Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.all(4),
                  child: Row(children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Nom',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: 'Téléphone',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 3,
                      child: DropdownButton<String>(
                        underline: Container(),
                        hint: Text('Category'),
                        // Not necessary for Option 1
                        items: categories.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                            selectedCategory = categories.indexOf(value!) + 1;
                          });
                          print(categories.indexOf(value!) + 1);
                        },
                      ),
                    ),
                    Expanded(
                        child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        saveNewContact();
                      },
                    )),
                  ]),
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: contactSelected.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        ListTile(
                            leading: Icon(contactSelected[index].icon),
                            subtitle: Text(contactSelected[index].phone!),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.message,
                                        color: Colors.yellowAccent,
                                      ),
                                      onPressed: () {
                                        _sendSMS('',
                                            [contactSelected[index].phone!]);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          print("ffff");
                                          contactSelected
                                              .remove(contactSelected[index]);
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      icon: Icon(
                                        contactSelected[index].update!
                                            ? Icons.close
                                            : Icons.create,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        if (contactSelected[index].update!) {
                                          setState(() {
                                            contactSelected[index].update =
                                                false;
                                          });
                                        } else {
                                          setState(() {
                                            contactSelected[index].update =
                                                true;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: Text(contactSelected[index].name!)),
                        contactSelected[index].update!
                            ? Container(
                                padding: EdgeInsets.all(6),
                                margin: EdgeInsets.all(4),
                                child: Row(children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      initialValue: contactSelected[index].name,
                                      onChanged: (value) {
                                        contactSelected[index].name = value;
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Nom',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      initialValue:
                                          contactSelected[index].phone,
                                      onChanged: (value) {
                                        contactSelected[index].phone = value;
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Téléphone',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: IconButton(
                                    icon: Icon(Icons.create),
                                    onPressed: () {
                                      setState(() {
                                        contactSelected[contactSelected
                                                .indexWhere((element) =>
                                                    element.id ==
                                                    contactSelected[index].id)]
                                            .name = contactSelected[index].name;
                                        contactSelected[contactSelected
                                                .indexWhere((element) =>
                                                    element.id ==
                                                    contactSelected[index].id)]
                                            .phone = contactSelected[
                                                index]
                                            .phone;
                                        contactSelected[index].update = false;
                                      });
                                    },
                                  )),
                                ]),
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            : Container()
                      ],
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }

  _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {

    });

  }
}
