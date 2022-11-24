import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passwordformfield/password_form_field.dart';

void main() {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorResponse;

  Widget _testWidget({required Widget child}){
    return  MaterialApp(
      home: Material(
        child:  Form(
            key: formKey,
            child: child),
      ),
    );
  }


  group("test password form field",(){

    testWidgets("find the widget", (tester)async{
      await tester.pumpWidget(_testWidget(child: const PasswordFormField()));
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
    });

    testWidgets('check for input', (tester)async{
      await tester.pumpWidget(_testWidget(child: const PasswordFormField()));
      await tester.enterText(find.byType(TextField), "hello");
      await tester.pump();
      expect(find.text('hello'), findsOneWidget);
    });
    
    testWidgets('check for regex error', (widgetTester)async{
      await widgetTester.pumpWidget(_testWidget(child:  PasswordFormField(
        key: const Key('password1'),
        validator: (response)=> errorResponse =response,
        patterns: [
          FieldPattern(label: '3 Uppercase letter', pattern: RegExp(r'(.*[A-Z]){3}'))
        ],
      )));

      final field = find.byKey(const Key('password1'));
      await widgetTester.enterText(field, 'hello');
      formKey.currentState!.validate(); // manually validate this
      await widgetTester.pump();
      expect(errorResponse, equals('error'));
    },);

    testWidgets('check if custom error is passed', (widgetTester) async{
      await widgetTester.pumpWidget(_testWidget(child: PasswordFormField(
        errorText: "Field requirement not met",
        validator: (response)=> errorResponse = response,
        patterns: [
          FieldPattern(label: '3 Uppercase letter', pattern: RegExp(r'(.*[A-Z]){3}'))
        ],
      )));
      formKey.currentState!.validate();
      await widgetTester.pump();
      expect(errorResponse, isNot('error'));
    });


  });

}
