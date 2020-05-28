import 'package:bytebank/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                'teste',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              subtitle: Text(
                'teste2',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => Contactform(),
                ),
              )
              .then(
                (contact) => debugPrint(contact.toString()),
              );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
