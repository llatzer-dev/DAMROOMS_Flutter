import 'package:damroomsapp/models/cliente_model.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ClientesProvider {
  final String _apikey = 'e8f5e031e2e167767274fb316c880b33';
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';

  Future<Cliente> getInfoCliente(Cliente cliente) async {
    final url = Uri.https(_url, '3/person/' + cliente.dni.toString(),
        {'api_key': _apikey, 'language': _language});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    print(decodedData);

    final infoCliente = Cliente.fromJsonMap(decodedData);

    return infoCliente;
  }
}
