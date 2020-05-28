import 'dart:async';

import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DB_NAME = 'bytebanck.db';
const int DB_VERSION = 1;

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), DB_NAME);

  final String sql = '''CREATE TABLE contacts(
    id INTEGER PRIMARY KEY,
    name TEXT,
    account_number INTEGER        
  )''';

  return openDatabase(path, onCreate: (db, version) {
    db.execute(sql);
  }, version: DB_VERSION /*, onDowngrade: onDatabaseDowngradeDelete*/);
}

Future<int> save(Contact contact) async {
  final db = await getDatabase();
  final Map<String, dynamic> contactMap = Map();

  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;

  return db.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {
  final db = await getDatabase();
  final result = await db.query('contacts');

  final List<Contact> contacts = List();
  for (Map<String, dynamic> value in result) {
    contacts.add(Contact(
      value['id'],
      value['name'],
      value['account_number'],
    ));
  }
  return contacts;
}
