// int numero
// string tipo
// string caracteristicas
// float importe_noche

// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

import 'dart:ffi';

class Habitaciones {
  List<Habitacion> habitaciones = [];

  Habitaciones();

  Habitaciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((element) {
      final habitacion = Habitacion.fromJsonMap(element);
      habitaciones.add(habitacion);
    });
  }
}

class Habitacion {
  int? numero;
  String? tipo;
  String? caracteristicas;
  var importe_noche;

  Habitacion(
      {required this.numero,
      required this.tipo,
      required this.caracteristicas,
      required this.importe_noche});

  Habitacion.fromJsonMap(Map<String, dynamic> json) {
    numero = json['numero'];
    tipo = json['tipo'];
    caracteristicas = json['caracteristicas'];
    importe_noche = json['importe_noche'];
    importe_noche =
        json['importe_noche'] == null ? 0.0 : json['importe_noche'].toDouble();
  }
}
