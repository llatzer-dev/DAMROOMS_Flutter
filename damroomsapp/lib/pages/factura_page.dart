import 'package:damroomsapp/models/cliente_model.dart';
import 'package:damroomsapp/models/habitacion_model.dart';
import 'package:damroomsapp/models/reserva_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Facturación'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        children: [
          Factura(reserva),
        ],
      ),
    );
  }
}

Widget Factura(Reserva reserva) {
  Cliente? cliente = reserva.cliente;
  Habitacion? habitacion = reserva.habitacion;

  return Container(
    child: Column(children: <Widget>[
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
          children: const [
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
              Text('5', textScaleFactor: 1.5),
              Align(
                child: Text("importe total", textScaleFactor: 1.5),
                alignment: Alignment.centerRight,
              )
            ]),
          ],
        ),
      ),
    ]),
  );
}
