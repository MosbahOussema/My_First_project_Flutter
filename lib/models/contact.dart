import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactItem {
  int? id;
  String? name;
  String? phone;
  IconData? icon;
  int? type;
  bool? update;

  ContactItem(
      {this.id,
      this.name,
      this.phone,
      this.icon,
      this.type,
      this.update = false});
}
