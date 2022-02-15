// int codReserva
// Date fechaInicio
// Date fechaFin
// float importe

// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

import 'package:damroomsapp/models/cliente_model.dart';
import 'package:damroomsapp/models/habitacion_model.dart';

class Reservas {
  List<Reserva> reservas = [];

  Reservas();

  Reservas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((element) {
      final reserva = Reserva.fromJsonMap(element);
      reservas.add(reserva);
    });
  }
}

class Reserva {
  int? codReserva;
  String? fechaInicio;
  String? fechaFin;
  var importe;
  String? estado;
  Habitacion? habitacion;
  Cliente? cliente;

  Reserva(
      {required this.codReserva,
      required this.fechaInicio,
      required this.fechaFin,
      required this.importe,
      required this.habitacion});

  Reserva.fromJsonMap(Map<String, dynamic> json) {
    codReserva = json['idReserva'];
    fechaInicio = json['fechaInicio'];
    fechaFin = json['fechaFin'];
    importe =
        json['importeTotal'] == null ? 0.0 : json['importeTotal'].toDouble();
    estado = json['fechaFin'];

    if (json['habitacion'] != null) {
      habitacion = Habitacion.fromJson(json['habitacion']);
    }

    if (json['clientes'] != null) {
      cliente = Cliente.fromJson(json['clientes']);
    }
  }
}
