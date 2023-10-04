import 'package:api_horario_inst/horario_data.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Future<List<HorarioData>> horarioData;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    horarioData = fetchHorarioData();
    _tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: DateTime.now().weekday - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Column(
            children: [
              Text('Coordinación de Teleinformática'),
              Text(
                'Centro de Servicios y Gestión Empresarial',
                style: TextStyle(fontSize: 12),
              ),              
            ],
          ),
        ),
        bottom: TabBar(                   
          controller: _tabController,
          tabs: const [
            Tab(text: 'Lunes'),
            Tab(text: 'Martes'),
            Tab(text: 'Miércoles'),
            Tab(text: 'Jueves'),
            Tab(text: 'Viernes'),
            Tab(text: 'Sábado'),
          ],
        ),
      ),
      body: FutureBuilder<List<HorarioData>>(
        future: horarioData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final horarioList = snapshot.data!;
            return TabBarView(              
              controller: _tabController,
              children: [
                for (var horarioData in horarioList)
                  ListView.builder(
                    itemCount: horarioData.horario.length,
                    itemBuilder: (context, index) {
                      final horaKey = horarioData.horario.keys.toList()[index];
                      final horaData = horarioData.horario[horaKey];
                      final horaInicio = horaKey.split('-')[0].trim();
                      final horaFin = horaKey.split('-')[1].trim();
                      final horaInicioFormateada = '$horaInicio:00';
                      final horaFinFormateada = '$horaFin:00';
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                      color: Colors.blueGrey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        '$horaInicioFormateada - $horaFinFormateada', style: const TextStyle(color: Color.fromARGB(255, 50, 135, 192), fontWeight: FontWeight.bold ),),
                                  ],
                                ),
                                if (horaData.isEmpty)
                                  const Text('Libre')
                                else
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.class_,
                                            color: Color.fromARGB(255, 50, 135, 192),
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text(horaData[0]['NC']),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.numbers,
                                            color: Colors.blueGrey,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(horaData[0]['FICHA']),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Color.fromARGB(255, 50, 135, 192),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text('${horaData[0]['AMB']}'),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}