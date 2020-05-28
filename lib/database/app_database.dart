import 'dart:async';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DB_NAME = 'bytebanck.db';
const int DB_VERSION = 1;

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), DB_NAME);
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContactDAO.TABLE_SQL);
  }, version: DB_VERSION /*, onDowngrade: onDatabaseDowngradeDelete*/);
}
