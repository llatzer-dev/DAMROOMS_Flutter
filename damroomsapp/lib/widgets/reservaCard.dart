// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
/*
import 'package:damroomsapp/models/habitacion_model.dart';
import 'package:damroomsapp/models/reserva_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ReservaCard extends StatelessWidget {
  List<dynamic> reservas = [];
  Reserva reserva = Reserva(codReserva: 23, fechaInicio: "", fechaFin: "", importe: 0, habitacion: new Habitacion(numero: 2, tipo: "", caracteristicas: "caracteristicas", importe_noche: 23));
  int index;
  final codReserva = reserva.codReserva;
        final fechaInicio = reserva.fechaInicio;
        final fechaFin = reservas[index].fechaFin;
        final importe = reservas[index].importe;

        // Datos de la habitacion de la reserva
        final habNumero = reservas[index].habitacion.numero;
        final habTipo = reservas[index].habitacion.tipo;
        final habCaracteristicas = reservas[index].habitacion.caracteristicas;
        final habImporteNoche = reservas[index].habitacion.importe_noche;
  @override
  Widget build(BuildContext context) {
    return Card(
                elevation: 100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.bookmarks_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(
                        '               ― Reserva ―\n' +
                            'Numero: ' +
                            codReserva.toString() +
                            '\nDel ' +
                            fechaInicio.toString() +
                            ' al ' +
                            fechaFin.toString() +
                            '\nImporte: ' +
                            importe.toString() +
                            '€.',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('Ver habitación'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(32),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            'Numero de habitación: $habNumero',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Tipo de habitación: $habTipo',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Características: $habCaracteristicas',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Importe por noche: $habImporteNoche',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              )),
        );
}
*/