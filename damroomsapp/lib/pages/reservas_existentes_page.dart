import 'package:damroomsapp/models/cliente_model.dart';
import 'package:damroomsapp/providers/cliente_provider.dart';
import 'package:damroomsapp/providers/reservas_provider.dart';
import 'package:flutter/material.dart';

import 'package:damroomsapp/widgets/background.dart';

class ReservasExistentesScreen extends StatefulWidget {
  const ReservasExistentesScreen({Key? key}) : super(key: key);

  @override
  _ReservasExistentesScreenState createState() =>
      _ReservasExistentesScreenState();
}

class _ReservasExistentesScreenState extends State<ReservasExistentesScreen> {
  String _fecha = '';

  final TextEditingController _inputFieldDateController =
      TextEditingController();

  // Lista de widgets de la pagina
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas existentes'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        children: [
          Background(),
          _crearFecha(context),
          const Divider(),
          _testResultado(),
          _crearCliente(),
          _crearReserva(),
        ],
      ),
    );
  }

  // Widget del input fecha
  Widget _crearFecha(BuildContext context) {
    _selectDate(BuildContext context) async {
      DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es', 'ES'),
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2025),
      );

      if (picked != null) {
        setState(
          () {
            _fecha = picked.toString();
            _inputFieldDateController.text = _fecha;
          },
        );
      }
    }

    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        hintText: 'Elige fecha',
        labelText: 'Elige fecha',
        suffixIcon: const Icon(Icons.perm_contact_calendar),
        icon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
        _selectDate(context);
      },
    );
  }

  // Widget para ver lo seleccionado en el widget fecha
  Widget _testResultado() {
    return ListTile(
      title: Text('Has elegido: $_fecha'),
    );
  }

  // Widget conseguir los clientes
  Widget _crearCliente() {
    final clientesProvider = ClientesProvider();

    return FutureBuilder(
      future: clientesProvider.getInfoClientes(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearClientes(snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Widget que muestra los clientes
  Widget _crearClientes(List<dynamic> clientes) {
    // return SizedBox(
    //   height: 200.0,
    //   child: PageView.builder(
    //       controller: PageController(viewportFraction: 0.3, initialPage: 1),
    //       itemCount: clientes.length,
    //       pageSnapping: false,
    //       itemBuilder: (context, i) => _actorTarjeta(clientes[i], context)),
    // );

    return ListView.builder(
      shrinkWrap: true,
      itemCount: clientes.length,
      itemBuilder: (BuildContext context, int index) {
        final nombre = clientes[index].nombre;
        final apellidos = clientes[index].apellidos;

        return Card(
          elevation: 20,
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
                title: Text(nombre + ' ' + apellidos),
                // subtitle: const Text(
                //     'Esta es una prueba para ver lo que ocurre con una tarjeta que tiene un subtitle bastante largo y que no sabemos como responderá'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // Widget _actorTarjeta(Cliente cliente, BuildContext context) {
  //   return Container(
  //     child: Row(
  //       children: [
  //         Text(
  //           cliente.nombre!,
  //           overflow: TextOverflow.ellipsis,
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget conseguir los clientes
  Widget _crearReserva() {
    final reservasProvider = ReservasProvider();

    return FutureBuilder(
      future: reservasProvider.getInfoReservas(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearReservas(snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Widget que muestra los clientes
  Widget _crearReservas(List<dynamic> reservas) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: reservas.length,
      itemBuilder: (BuildContext context, int index) {
        final codReserva = reservas[index].codReserva;
        final fechaInicio = reservas[index].fechaInicio;
        final fechaFin = reservas[index].fechaFin;
        final importe = reservas[index].importe;
        final dniCliente = reservas[index].dni_cliente;

        return Card(
          elevation: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
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
                      title: Text(' - Reserva -\n' +
                          'Numero: ' +
                          codReserva.toString() +
                          '\nDel ' +
                          fechaInicio.toString() +
                          ' a ' +
                          fechaFin.toString() +
                          '\nImporte: ' +
                          importe.toString() +
                          '€.'),
                      subtitle: const Text(
                          'Aquí iría la info de la habitacion reservada.'),
                      isThreeLine: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () {},
                        ),
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () {},
                        ),
                        TextButton(
                          child: const Text('Prueba'),
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
