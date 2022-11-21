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



  chip({required String label, bool isChecked = false}){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(isChecked) Row(
            children: [
              Icon(
                  Icons.check_outlined,
                  size: 17,
                color: Colors.green.shade800,
              ),
             const SizedBox(width: 2,),
            ],
          ),
          Text(label,)
        ],
      ),
      decoration: BoxDecoration(
          color: isChecked ? Colors.greenAccent.withOpacity(0.38) : Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }

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
            PasswordFormField(
              showSuffixIcon: true,
              patterns: [
                FieldPattern(label: '8 characters long', pattern: RegExp(r'[a-zA-Z]{8}')),
                FieldPattern(label: 'only 1 number', pattern: RegExp(r'\d{1}')),
                FieldPattern(label: 'start with uppercase', pattern: RegExp(r'^[A-Z]')),
                FieldPattern(label: '3 Uppercase letter', pattern: RegExp(r'(.*[A-Z]){3}')), // exactly 3 uppercase letter
              ],
              border: const OutlineInputBorder(),
            ),

            TextFormField(
            )
          ],
        )
      ),
    );
  }
}
