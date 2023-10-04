import 'dart:convert';
import 'package:http/http.dart' as http;

class HorarioData {
  final String dia;
  final Map<String, dynamic> horario;

  HorarioData({required this.dia, required this.horario});
}

Future<List<HorarioData>> fetchHorarioData() async {
  final response = await http.get(
    Uri.parse("https://ingdanielb.pythonanywhere.com/api/h_instructor"),
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
  } else {
    throw Exception("Error al cargar los datos del horario");
  }
}


