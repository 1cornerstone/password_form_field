
class FieldPattern {
  String label;
  RegExp pattern;
  bool isChecked;

  FieldPattern({required this.label, required this.pattern, this.isChecked = false});

  Map<String, dynamic> toJson(){
    return {
      "title" : label,
      "isCheck": isChecked
    };
  }
}