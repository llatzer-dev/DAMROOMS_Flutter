import 'package:damroomsapp/models/cliente_model.dart';
import 'package:damroomsapp/pages/reserva_all_info_page.dart';
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
  bool fechaSeleccionada = false;

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
          const Divider(),
          _crearReserva(fechaSeleccionada),
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
            _fecha = picked.toString().split(' ').first;
            _inputFieldDateController.text = _fecha;

            fechaSeleccionada = true;
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
                title: Text(
                  nombre + ' ' + apellidos,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      'Cancelar',
                    ),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: const Text(
                      'Ok',
                    ),
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

  // Widget conseguir los clientes
  Widget _crearReserva(bool fechaSelected) {
    if (fechaSelected == true) {
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

    return Container();
  }

  // Widget que muestra los clientes
  Widget _crearReservas(List<dynamic> reservas) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: reservas.length,
      itemBuilder: (BuildContext context, int index) {
        // Datos de la reserva
        final reserva = reservas[index];
        final codReserva = reservas[index].codReserva;
        final fechaInicio = reservas[index].fechaInicio;
        final fechaFin = reservas[index].fechaFin;
        final importe = reservas[index].importe;

        // Datos de la habitacion de la reserva
        final habNumero = reservas[index].habitacion.numero;
        final habTipo = reservas[index].habitacion.tipo;
        final habCaracteristicas = reservas[index].habitacion.caracteristicas;
        final habImporteNoche = reservas[index].habitacion.importe_noche;

        if (_fecha.toString().compareTo(fechaInicio.toString()) == 0) {
          print('LA FECHA ES IGUAL');

          return Card(
            color: Colors.blue,
            elevation: 100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
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
                                            'Importe por noche: $habImporteNoche €',
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
                        ),
                        TextButton(
                          child: const Text('+ Info'),
                          onPressed: () => Navigator.pushNamed(
                              context, 'reserva_all_info_page',
                              arguments: reserva),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          print('LA FECHA NO ES IGUAL');

          return Container();
        }
      },
    );
  }
}
