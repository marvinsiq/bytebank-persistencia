import 'dart:async';

import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DB_NAME = 'bytebanck.db';
const int DB_VERSION = 1;

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, DB_NAME);

    final String sql = '''CREATE TABLE contacts(
        id INTEGER PRIMARY KEY,
        name TEXT,
        account_number INTEGER        
      )''';

    return openDatabase(path, onCreate: (db, version) {
      db.execute(sql);
    }, version: DB_VERSION
        //, onDowngrade: onDatabaseDowngradeDelete
        );
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = Map();

    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;

    return db.insert('contacts', contactMap);
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((db) {
    return db.query('contacts').then((values) {
      final List<Contact> contacts = List();

      for (Map<String, dynamic> value in values) {
        contacts.add(Contact(
          value['id'],
          value['name'],
          value['account_number'],
        ));
      }
      return contacts;
    });
  });
}
