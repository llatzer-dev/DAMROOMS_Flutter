import 'package:damroomsapp/models/reserva_model.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ReservasProvider {
  final String urlTest = 'my-json-server.typicode.com';

  Future<List<Reserva>> getInfoReservas() async {
    final url = Uri.https(
      urlTest,
      '/Lazaro000/testClientes/reservas',
      {},
    );

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    print(decodedData);

    final listaReservas = Reservas.fromJsonList(decodedData);

    return listaReservas.reservas;
  }
}
