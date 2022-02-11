import 'package:damroomsapp/models/cliente_model.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ClientesProvider {
  final String urlTest = 'my-json-server.typicode.com';

  Future<List<Cliente>> getInfoClientes() async {
    final url = Uri.https(
      urlTest,
      '/Lazaro000/testClientes/clientes',
      {},
    );

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    print(decodedData);

    final listaClientes = Clientes.fromJsonList(decodedData);

    return listaClientes.clientes;
  }
}
