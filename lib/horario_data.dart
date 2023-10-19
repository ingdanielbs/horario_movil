import 'package:http/http.dart' as http;
import 'dart:convert';

class HorarioData {
  final String dia;
  final Map<String, dynamic> horario;

  HorarioData({required this.dia, required this.horario});
}

Future<List<HorarioData>> fetchHorarioData(int documento) async {
  final response = await http.post(
    Uri.parse("https://ingdanielb.pythonanywhere.com/api/h_instructor"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({'DOCUMENTO': documento}),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body.replaceAll('NaN', 'null'));

    final List<String> dias = ["lunes", "martes", "miercoles", "jueves", "viernes", "sabado"];
    final List<HorarioData> horarioList = dias.map((dia) {
      return HorarioData(
        dia: dia,
        horario: jsonData['horario'][dias.indexOf(dia)][1],
      );
    }).toList();

    return horarioList;
  } if (response.statusCode == 404) {
    throw Exception('No se encontró el documento');
  } else {
    throw Exception('Error al cargar el horario');
  }
}
