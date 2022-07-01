import 'package:flutter_application_1/screens/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../contact.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE Contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        phone TEXT,
        type INTEGER,
        update bool
      )
      """);
  }

  static Future<Database> db() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Contacts.db');
    return openDatabase(
      'DbContacts.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

// Create new contact
  static Future<int> createContact(ContactItem c) async {
    final db = await SQLHelper.db();
    final data = {
      'name': c.name,
      'phone': c.phone,
      'type': c.type,
      'update': c.update
    };
    final id = await db.insert('Contacts', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Read all contact
  static Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await SQLHelper.db();
    return db.query('Contacts', orderBy: "id");
  }
}
