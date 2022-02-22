import 'package:damroomsapp/models/reserva_model.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ReservasProvider {
  final String urlmain = '192.168.1.2:8080';
  String url_peticion = '';

  Future<List<Reserva>> getInfoReservas() async {
    url_peticion = '/reservas';
    final url = Uri.http(urlmain, url_peticion);

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final listaReservas = Reservas.fromJsonList(decodedData);

    return listaReservas.reservas;
  }

  Future<Reserva> changeCheckIn(Reserva r) async {
    final idReserva = r.codReserva.toString();
    url_peticion = '/reservas/$idReserva/checkIn';

    final url = Uri.http(urlmain, url_peticion);

    final resp = await http.put(
      url,
      headers: {"Content-type": "application/json"},
      // body: jsonEncode(r.toJson()),
      body: json.encode({}),
      encoding: Encoding.getByName("utf-8"),
    );

    final decodedData = json.decode(resp.body);

    final reserva = Reserva.fromJsonMap(decodedData);

    return reserva;
  }

  Future<Reserva> changeCheckOut(Reserva r) async {
    final idReserva = r.codReserva.toString();
    url_peticion = '/reservas/$idReserva/checkOut';

    final url = Uri.http(urlmain, url_peticion);

    final resp = await http.put(
      url,
      headers: {"Content-type": "application/json"},
      // body: jsonEncode(r.toJson()),
      body: json.encode({}),
      encoding: Encoding.getByName("utf-8"),
    );
    final decodedData = json.decode(resp.body);

    final reserva = Reserva.fromJsonMap(decodedData);

    return reserva;
  }
}
