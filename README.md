# PasswordFormField
A customizable password input widget with rule validation

## Getting Started

### Installation
- add dependency
    ````dart
        dependencies:
            passwordformfield: 0.0.1

- import package
  ````dart
  import 'package:passwordformfield/password_form_field.dart';
  
- Implementation
    ```dart
     PasswordFormField(
        fieldHintText: "Password",
        focusColor: Colors.yellow,
        patterns: [
            FieldPattern(label: '8 characters minimum', pattern: RegExp(r'[a-zA-Z0-9]{8}')),
            FieldPattern(label: 'start with uppercase', pattern: RegExp(r'^[A-Z]')),
            FieldPattern(label: 'contain 3 uppercase letter', pattern: RegExp(r'(.*[A-Z]){3}')), // exactly 3 uppercase letter
           ],
        border: const OutlineInputBorder(),
      ),

### Patterns Customization
 For proper validation beyond limit, FieldPattern is made available.
 
*Note:* Make sure your rule(s) is correct, the package validate with only regular expression passed nothing more.

## Sample

 <img src="https://github.com/1cornerstone/password_form_field/blob/master/screenshot/passwordfield.png" width="240" height="430" alt="passwordfield.png"/> 
 <img src="https://github.com/1cornerstone/password_form_field/blob/master/screenshot/passwordfield_filled.png" width="240" height="430" alt="passwordfield_filled.png"/>
