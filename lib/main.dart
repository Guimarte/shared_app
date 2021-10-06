import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: HomeWidget()));
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste SharedPreferences"),
      ),
      body: CampoTexto(),
    );
  }
}

class CampoTexto extends StatelessWidget {
  TextEditingController host = TextEditingController();
  TextEditingController api = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "host"),
            controller: host,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "api"),
            controller: api,
          ),
          BotaoSalvarWidget(
            texto: "Salvar SharedPreferences",
            onPressed: () async {
              await sharedPreferencesFuncao(host.text, api.text);
            },
          ),
          BotaoSalvarWidget(
              texto: "Pegar SharedPreferences",
              onPressed: () async {
                await getValuesFuncao();
              })
        ],
      ),
    );
  }
}

class BotaoSalvarWidget extends StatelessWidget {
  const BotaoSalvarWidget(
      {Key? key, required this.onPressed, required this.texto})
      : super(key: key);
  final String texto;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: onPressed, child: Text(texto)),
    );
  }
}

Future<void> sharedPreferencesFuncao(String host, String api) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString("host", host);
  await prefs.setString("api", api);

  final hostValue = await prefs.getString("host");
  final apiValue = await prefs.getString("api");
}

Future<void> getValuesFuncao() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final hostValue = await prefs.getString("host");
  final apiValue = await prefs.getString("api");
  print(hostValue);
  print(apiValue);
}
