import 'package:api_horario_inst/home_page.dart';
import 'package:api_horario_inst/horario_data.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController documentoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _navigateToHorario(BuildContext context) async {
    final numeroDocumento = documentoController.text;

    try {
      final List<HorarioData> horarioData =
          await fetchHorarioData(int.parse(numeroDocumento));
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyHomePage(horarioData: horarioData);
      }));
    } catch (error) {
      final snackBar = SnackBar(
        content: Text(error.toString()),
        action: SnackBarAction(
          label: 'Cerrar',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo4.png', width: 300),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su número de cédula';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: documentoController,
                            decoration: const InputDecoration(
                              labelText: 'Documento',
                              hintText: 'Ingrese su número de cédula',
                              prefixIcon: Icon(Icons.numbers),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(90, 143, 140, 140)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(90, 143, 140,
                                        140)), // Cambia el color del borde cuando el TextField no está enfocado
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 65,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 2, 26, 55)),
                                foregroundColor: const MaterialStatePropertyAll(
                                    Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {                                  
                                  _navigateToHorario(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Procesando datos...')),
                                  );
                                }
                              },
                              child: const Text('Iniciar Sesión'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
