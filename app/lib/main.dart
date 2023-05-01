import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';

const List<String> list = <String>['An', 'Aus', 'Antwort'];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepenteApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'RepenteApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nummerControll = TextEditingController();
  String dropdownValue = list.first;
  late List<String> nummers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: nummerControll,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nummer eingeben',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(fontSize: 18, color: Colors.green),
                underline: Container(
                  //width: 300.0,
                  height: 1,
                  color: Colors.grey,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    nummers = nummerControll.text.split(' ');
                    _sendSMS(dropdownValue, nummers);
                  },
                  child: const Text('Send'),
                ),
              )),
          const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
            color: Colors.green,
          ),
        ])));
  }
}

Future<void> _sendSMS(String message, List<String> recipents) async {
  try {
    String _result = await sendSMS(
      message: message,
      recipients: recipents,
    );
    //setState(() => _message = _result);
    print(_result);
  } catch (error) {
    //setState(() => _message = error.toString());
    print(error);
  }
}
