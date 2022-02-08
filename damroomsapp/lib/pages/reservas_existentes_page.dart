// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_element, unnecessary_new, prefer_final_fields

import 'package:flutter/material.dart';

import 'package:damroomsapp/widgets/background.dart';

class ReservasExistentesScreen extends StatefulWidget {
  @override
  _ReservasExistentesScreenState createState() =>
      _ReservasExistentesScreenState();
}

class _ReservasExistentesScreenState extends State<ReservasExistentesScreen> {
  String _fecha = '';

  TextEditingController _inputFieldDateController = new TextEditingController();

  // Lista de widgets de la pagina
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reservas existentes'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          children: [
            Background(),
            _crearFecha(context),
            Divider(),
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
          initialDate: new DateTime.now(),
          firstDate: new DateTime(2018),
          lastDate: new DateTime(2025));

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
          suffixIcon: Icon(Icons.perm_contact_calendar),
          icon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  Widget _testResultado() {
    return ListTile(title: Text('Has elegido: $_fecha'));
  }
}
