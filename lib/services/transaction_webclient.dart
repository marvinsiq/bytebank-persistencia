import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

import 'webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get("$API_URL/transactions");
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((json) => Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post("$API_URL/transactions",
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transactionJson);

    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}
