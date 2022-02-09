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
            _testResultado()
          ],
        ));
  }

  // Widget del input fecha
  Widget _crearFecha(BuildContext context) {
    _selectDate(BuildContext context) async {
      DateTime? picked = await showDatePicker(
          context: context,
          locale: const Locale('es', 'ES'),
          initialDate: DateTime.now(),
          firstDate: DateTime(2018),
          lastDate: DateTime(2025));

      if (picked != null) {
        setState(() {
          _fecha = picked.toString();
          _inputFieldDateController.text = _fecha;
        });
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
    );
  }

  Widget _testResultado() {
    return ListTile(title: Text('Has elegido: $_fecha'));
  }
}
