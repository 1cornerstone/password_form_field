import 'package:flutter/material.dart';
import 'package:passwordformfield/passwordformfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'password form field',
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Custom password field'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Form(
              key: _form,
                child: Column(
              children: [
                PasswordFormField(
                  showSuffixIcon: true,
                  fieldHintText: "Password",
                  patterns: [
                    FieldPattern(label: '8 characters minimum', pattern: RegExp(r'[a-zA-Z0-9]{8}')),
                    FieldPattern(label: 'start with uppercase', pattern: RegExp(r'^[A-Z]')),
                    FieldPattern(label: 'contain 3 uppercase letter', pattern: RegExp(r'(.*[A-Z]){3}')), // exactly 3 uppercase letter
                  ],
                  border: const OutlineInputBorder(),
                ),

                ElevatedButton(onPressed: (){
                  _form.currentState!.validate();
                }, child: Text("validate"))
              ],
            ))


          ],
        )
      ),
    );
  }
}
