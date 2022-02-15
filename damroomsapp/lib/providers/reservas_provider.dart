import 'package:damroomsapp/models/reserva_model.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ReservasProvider {
  final String urlTest = 'my-json-server.typicode.com';
  final String urlTest2 = '/Lazaro000/testClientes/reservas';

  final String urlmain = '192.168.1.2:8080';
  final String url_peticion = '/reservas';

  Future<List<Reserva>> getInfoReservas() async {
    final url = Uri.http(urlmain, url_peticion);

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    print(decodedData);

    final listaReservas = Reservas.fromJsonList(decodedData);

    return listaReservas.reservas;
  }
}
