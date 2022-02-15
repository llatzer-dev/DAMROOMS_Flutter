import 'package:flutter/material.dart';

class ReservaAllInfoScreen extends StatefulWidget {
  const ReservaAllInfoScreen({Key? key}) : super(key: key);

  @override
  State<ReservaAllInfoScreen> createState() => _ReservaAllInfoScreenState();
}

class _ReservaAllInfoScreenState extends State<ReservaAllInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de la reserva'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        children: [
          allInfo(),
        ],
      ),
    );
  }

  Widget allInfo() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const [
            ListTile(
              title: Text('Prueba1'),
              subtitle: Text('Subtitulo1'),
            )
          ],
        ),
      ),
    );
  }
}
