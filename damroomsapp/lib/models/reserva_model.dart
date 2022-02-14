// int codReserva
// Date fechaInicio
// Date fechaFin
// float importe

// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

import 'dart:ffi';

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
  String? dni_cliente;

  Reserva({
    required this.codReserva,
    required this.fechaInicio,
    required this.fechaFin,
    required this.importe,
    required this.dni_cliente,
  });

  Reserva.fromJsonMap(Map<String, dynamic> json) {
    codReserva = json['id'];
    fechaInicio = json['fechaInicio'];
    fechaFin = json['fechaFin'];
    // importe = json['importe_total'].toDouble();
    importe =
        json['importe_total'] == null ? 0.0 : json['importe_total'].toDouble();
    dni_cliente = json['dni_cliente'];
  }
}
