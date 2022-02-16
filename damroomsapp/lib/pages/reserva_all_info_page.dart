import 'package:damroomsapp/models/cliente_model.dart';
import 'package:damroomsapp/models/habitacion_model.dart';
import 'package:damroomsapp/models/reserva_model.dart';
import 'package:damroomsapp/providers/reservas_provider.dart';
import 'package:flutter/material.dart';

class ReservaAllInfoScreen extends StatefulWidget {
  const ReservaAllInfoScreen({Key? key}) : super(key: key);

  @override
  State<ReservaAllInfoScreen> createState() => _ReservaAllInfoScreenState();
}

class _ReservaAllInfoScreenState extends State<ReservaAllInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final Reserva reserva =
        ModalRoute.of(context)!.settings.arguments as Reserva;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de la reserva'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        children: [
          allInfo(reserva),
        ],
      ),
    );
  }

  Widget allInfo(Reserva r) {
    String msgError = 'Error al cargar los datos';

    final h = r.habitacion;
    final c = r.cliente;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _infoReserva(r, msgError),
            const Divider(
              height: 50,
              thickness: 5,
              indent: 10,
              endIndent: 10,
            ),
            _infoHabitacion(h!, msgError),
            const Divider(
              height: 50,
              thickness: 5,
              indent: 10,
              endIndent: 10,
            ),
            _infoCliente(c!, msgError),
            const Divider(
              height: 50,
              thickness: 5,
              indent: 10,
              endIndent: 10,
            ),
            if (r.estado.toString().compareTo('Pendiente') == 0)
              _botonCheckIn(r),
            if (r.estado.toString().compareTo('Activa') == 0) _botonCheckOut(r),
            if (r.estado.toString().compareTo('Completada') == 0)
              const Text('Reserva completada'),
          ],
        ),
      ),
    );
  }
}

Widget _infoReserva(Reserva r, String error) {
  // Datos de la reserva
  final codReserva = r.codReserva ?? error;
  final fechaInReserva = r.fechaInicio ?? error;
  final fechaFinReserva = r.fechaFin ?? error;
  final importeReserva = r.importe ?? error;
  final estadoReserva = r.estado ?? error;

  // Columna con los datos de RESERVA
  return Column(
    children: [
      const ListTile(
        title: Align(
          child: Text(
            '❰  Reserva  ❱',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          alignment: Alignment(0, 0),
        ),
      ),
      ListTile(
        title: Text(
          'Codigo de la reserva: $codReserva',
        ),
      ),
      ListTile(
        title: Text(
          'Fecha de inicio: $fechaInReserva',
        ),
      ),
      ListTile(
        title: Text(
          'Fecha final: $fechaFinReserva',
        ),
      ),
      ListTile(
        title: Text(
          'Importe total: $importeReserva €',
        ),
      ),
      ListTile(
        title: Text(
          'Estado: $estadoReserva',
        ),
      ),
    ],
  );
}

Widget _infoHabitacion(Habitacion h, String error) {
  // Datos de la habitacion de la reserva
  final numHabitacion = h.numero ?? error;
  final tipoHabitacion = h.tipo ?? error;
  final caracHabitacion = h.caracteristicas ?? error;
  final importeNocheHabitacion = h.importe_noche ?? error;

  // Columna con los datos de la HABITACION
  return Column(
    children: [
      const ListTile(
        title: Align(
          child: Text(
            '❰  Habitacion  ❱',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          alignment: Alignment(0, 0),
        ),
      ),
      ListTile(
        title: Text(
          'Numero: $numHabitacion',
        ),
      ),
      ListTile(
        title: Text(
          'Tipo: $tipoHabitacion',
        ),
      ),
      ListTile(
        title: Text(
          'Caracteristicas: $caracHabitacion',
        ),
      ),
      ListTile(
        title: Text(
          'Importe por noche: $importeNocheHabitacion',
        ),
      )
    ],
  );
}

Widget _infoCliente(Cliente c, String error) {
  // Datos del cliente de la reserva
  final dniCliente = c.dni ?? error;
  final nombreCliente = c.nombre ?? error;
  final apellidosCliente = c.apellidos ?? error;
  final direccionCliente = c.direccion ?? error;
  final telefono = c.telefono ?? error;

  // Columna con los datos de CLIENTE
  return Column(
    children: [
      const ListTile(
        title: Align(
          child: Text(
            '❰  Cliente  ❱',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          alignment: Alignment(
            0,
            0,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'DNI: $dniCliente',
        ),
      ),
      ListTile(
        title: Text(
          'Nombre y apellidos: $nombreCliente $apellidosCliente',
        ),
      ),
      ListTile(
        title: Text(
          'Dirección: $direccionCliente',
        ),
      ),
      ListTile(
        title: Text(
          'Telefono: $telefono',
        ),
      )
    ],
  );
}

Widget _botonCheckIn(Reserva r) {
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
            onPressed: () => _crearChange(r),
            child: const Text(
              'Check In',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _botonCheckOut(Reserva r) {
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
            onPressed: () => _crearChange(r),
            child: const Text(
              'Check Out',
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

  if (estadoReserva.toString().compareTo('Pendiente') == 0) {
    return FutureBuilder(
      future: reservasProvider.changeCheckIn(r),
      builder: (BuildContext context, AsyncSnapshot<Reserva> snapshot) {
        if (snapshot.hasData) {
          _mostrarAviso(context, snapshot.data!);
          return Container();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  if (estadoReserva.toString().compareTo('Activa') == 0) {
    return FutureBuilder(
      future: reservasProvider.changeCheckOut(r),
      builder: (BuildContext context, AsyncSnapshot<Reserva> snapshot) {
        if (snapshot.hasData) {
          _mostrarAviso(context, r);
          return Container();
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

void _mostrarAviso(BuildContext context, Reserva r) {
  final estadoReserva = r.estado;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Título'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Este es el contenido de la caja de la alerta. \n $estadoReserva'),
            const FlutterLogo(size: 70)
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    },
  );
}
