// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_local_variable, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'package:damroomsapp/models/cliente_model.dart';
import 'package:damroomsapp/models/habitacion_model.dart';
import 'package:damroomsapp/models/reserva_model.dart';
import 'package:damroomsapp/providers/reservas_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FacturaPage extends StatefulWidget {
  const FacturaPage({Key? key}) : super(key: key);

  @override
  State<FacturaPage> createState() => _FacturaPageState();
}

class _FacturaPageState extends State<FacturaPage> {
  @override
  Widget build(BuildContext context) {
    final Reserva reserva =
        ModalRoute.of(context)!.settings.arguments as Reserva;

    Habitacion? habitacion = reserva.habitacion;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Facturación'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        children: [
          Factura(reserva, context),
        ],
      ),
    );
  }
}

Widget Factura(Reserva reserva, BuildContext context) {
  Cliente? cliente = reserva.cliente;
  Habitacion? habitacion = reserva.habitacion;

  String daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round().toString();
  }

  final _fechaFin = DateTime.parse(reserva.fechaFin!);
  final _fechaIni = DateTime.parse(reserva.fechaInicio!);
  final _diastotales = daysBetween(_fechaIni, _fechaFin);
  final _importeTotal = reserva.importe;
  final _importeNoche = reserva.habitacion!.importe_noche;
  final _nombreCliente =
      reserva.cliente!.nombre! + ' ' + reserva.cliente!.apellidos!;
  final _dniCliente = reserva.cliente!.dni;
  final _telefonoCliente = reserva.cliente!.telefono;
  final _direccionCliente = reserva.cliente!.direccion;

  return Container(
    child: Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Cliente',
            textScaleFactor: 1.8,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            textDirection: TextDirection.ltr,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  Text(
                    "Nombre:",
                    textScaleFactor: 1.5,
                  ),
                  Align(
                    child: Text("$_nombreCliente", textScaleFactor: 1.3),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    "DNI:",
                    textScaleFactor: 1.5,
                  ),
                  Align(
                    child: Text("$_dniCliente", textScaleFactor: 1.3),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    "Telefono:",
                    textScaleFactor: 1.5,
                  ),
                  Align(
                    child: Text("$_telefonoCliente", textScaleFactor: 1.3),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    "Dirección:",
                    textScaleFactor: 1.5,
                  ),
                  Align(
                    child: Text("$_direccionCliente", textScaleFactor: 1.3),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          height: 20,
          thickness: 2,
          indent: 10,
          endIndent: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Factura',
            textScaleFactor: 1.8,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            textDirection: TextDirection.ltr,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(width: 2.0, color: Colors.blueAccent),
            children: [
              TableRow(
                children: [
                  Text(
                    "Noches",
                    textScaleFactor: 1.5,
                  ),
                  Align(
                    child: Text("Importe", textScaleFactor: 1.5),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              TableRow(children: [
                Text(_diastotales, textScaleFactor: 1.5),
                Align(
                  child: Text("$_importeNoche €/noche", textScaleFactor: 1.5),
                  alignment: Alignment.centerRight,
                )
              ]),
              TableRow(children: [
                Text('Precio total:', textScaleFactor: 1.5),
                Align(
                  child: Text('$_importeTotal €', textScaleFactor: 1.5),
                  alignment: Alignment.centerRight,
                )
              ]),
            ],
          ),
        ),
        const Divider(
          height: 50,
          thickness: 5,
          indent: 10,
          endIndent: 10,
        ),
        _botonCheckOut(reserva, context),
      ],
    ),
  );
}

Widget _botonCheckOut(Reserva r, BuildContext context) {
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 20,
    ),
    primary: Colors.blue,
    onPrimary: Colors.white,
    shape: const StadiumBorder(),
  );

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 40,
          child: ElevatedButton(
            style: style,
            onPressed: () {
              _crearChange(r);
            },
            child: const Text(
              'Finalizar',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _crearChange(Reserva r) {
  final reservasProvider = ReservasProvider();
  final estadoReserva = r.estado;
  if (estadoReserva.toString().compareTo('Activa') == 0) {
    return FutureBuilder(
      future: reservasProvider.changeCheckOut(r),
      builder: (BuildContext context, AsyncSnapshot<Reserva> snapshot) {
        if (snapshot.hasData) {
          return Text('Reserva finalizada');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  return Container();
}
