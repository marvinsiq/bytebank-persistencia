import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class Contactform extends StatefulWidget {
  @override
  _ContactformState createState() => _ContactformState();
}

class _ContactformState extends State<Contactform> {
  final ContactDAO _dao = ContactDAO();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full name',
                ),
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextField(
                controller: _accountNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Account number',
                ),
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: RaisedButton(
                onPressed: () {
                  final String name = _nameController.text;
                  final int accountNumber =
                      int.tryParse(_accountNumberController.text);
                  final Contact contact = Contact(0, name, accountNumber);
                  _dao.save(contact).then((id) {
                    debugPrint("Salvou o contato $id");
                    Navigator.pop(context);
                  });
                },
                child: Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
