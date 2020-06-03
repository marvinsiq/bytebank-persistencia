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

  static final Map<int, String> _statusCodeResponses = {
    400 : 'There was an error submitting transaction',
    401 : 'Authentication failed',
  };

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post("$API_URL/transactions",
        headers: {'Content-type': 'application/json', 'password': password},
        body: transactionJson);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Transaction.fromJson(json);
    }

    String msgError = _statusCodeResponses[response.statusCode];
    if (msgError == null) {
      msgError = 'Unknown error.';
    }
    throw Exception(msgError);
  }
}
