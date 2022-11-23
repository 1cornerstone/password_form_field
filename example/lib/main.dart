import 'package:flutter/material.dart';
import 'package:passwordformfield/password_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'password form field',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
                    FieldPattern(label: '8 characters long', pattern: RegExp(r'[a-zA-Z0-9]{8,8}')),
                    FieldPattern(label: 'only 1 number', pattern: RegExp(r'\d{1}')),
                    FieldPattern(label: 'start with uppercase', pattern: RegExp(r'^[A-Z]')),
                    FieldPattern(label: '3 Uppercase letter', pattern: RegExp(r'(.*[A-Z]){3}')), // exactly 3 uppercase letter
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
