import 'package:damroomsapp/models/cliente_model.dart';
import 'package:damroomsapp/providers/cliente_provider.dart';
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
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // Widget que muestra los clientes
  Widget _crearClientes(List<dynamic> clientes) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemCount: clientes.length,
          pageSnapping: false,
          itemBuilder: (context, i) => _actorTarjeta(clientes[i], context)),
    );
  }

  Widget _actorTarjeta(Cliente cliente, BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            cliente.nombre!,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
