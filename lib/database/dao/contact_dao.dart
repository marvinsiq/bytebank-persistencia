import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';

class ContactDAO {

  static const String _TABLE_NANE = 'contacts';
  static const String _FIELD_ID = 'id';
  static const String _FIELD_NAME = 'name';
  static const String _FIELD_ACCOUNT_NUMBER= 'account_number';

  static const String TABLE_SQL = '''CREATE TABLE $_TABLE_NANE(
    $_FIELD_ID INTEGER PRIMARY KEY,
    $_FIELD_NAME TEXT,
    $_FIELD_ACCOUNT_NUMBER INTEGER        
  )''';

  Future<int> save(Contact contact) async {
    final db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_TABLE_NANE, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final db = await getDatabase();
    final result = await db.query(_TABLE_NANE);
    List<Contact> contacts = _toList(result);
    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = List();
    for (Map<String, dynamic> value in result) {
      contacts.add(Contact(
        value[_FIELD_ID],
        value[_FIELD_NAME],
        value[_FIELD_ACCOUNT_NUMBER],
      ));
    }
    return contacts;
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_FIELD_NAME] = contact.name;
    contactMap[_FIELD_ACCOUNT_NUMBER] = contact.accountNumber;
    return contactMap;
  }
}