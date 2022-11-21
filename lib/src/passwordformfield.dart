
import 'package:flutter/material.dart';
import '../password_form_field.dart';

class PasswordFormField extends StatefulWidget {
  final bool enableField;
  final bool canPastePassword;
  final IconData? hiddenStateIcon;
  final IconData? unHiddenStateIcon;
  final bool showSuffixIcon;
  final bool initialPasswordState;
  final String fieldHintText;
  final String? errorText;
  final TextStyle? hintStyle;
  final Widget? label;
  final TextStyle? labelStyle;
  final String? labelText;
  final InputBorder? border,
      focusedBorder,
      enabledBorder,
      disabledBorder;
  final TextStyle? inputTextStyle;
  final TextEditingController? textEditingController;
  final Function(String)? onFieldSubmitted;
  final List<FieldPattern>? patterns;
  final bool showValidatorSheet;
  final Function(String)? onChanged;
  final Color? focusColor;
  final Widget? prefix;
  final Icon? prefixIcon;
   final Color? prefixIconColor;
  final TextStyle? prefixStyle;
  final EdgeInsetsGeometry? contentPadding;
  const PasswordFormField({Key? key,
    this.hiddenStateIcon,
    this.unHiddenStateIcon,
    this.showSuffixIcon = false,
    this.initialPasswordState = true,
    this.fieldHintText = "",
    this.border,
    this.enableField = true,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.inputTextStyle,
    this.canPastePassword = true,
    this.textEditingController, this.onFieldSubmitted, this.patterns,
    this.showValidatorSheet = true,
    this.onChanged, this.errorText,
    this.hintStyle, this.label,
    this.labelStyle, this.labelText,
    this.focusColor, this.prefix,
    this.prefixIcon, this.prefixIconColor,
    this.prefixStyle, this.contentPadding }) : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {

  late bool _initialPasswordVisibilityState;
  List<FieldPattern> _validPattern = [];
  bool onFocus = false;
  bool allPatternPassed = false;

  validateInput(String? input){
    return  allPatternPassed ? null : widget.errorText ?? "error";
  }

  @override
  void initState() {
    _initialPasswordVisibilityState = widget.initialPasswordState;
    _validPattern = [...?widget.patterns];
    super.initState();
  }

  Widget _field(){
    return TextFormField(
      obscureText:  _initialPasswordVisibilityState,
      maxLines: 1,
      enabled: widget.enableField,
      style: widget.inputTextStyle,
      controller: widget.textEditingController,
      validator: (input)=> validateInput(input),
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: (input){
        if(widget.onChanged!=null){
          widget.onChanged!(input);
        }
        if(widget.showValidatorSheet && _validPattern.isNotEmpty){
          _validPattern.forEach((element) {
            if(element.pattern.hasMatch(input)){
              element.isChecked = true;
            }else{
              element.isChecked = false;
            }
          });
          setState(() {});
        }
      },
      toolbarOptions: ToolbarOptions(
          paste: widget.canPastePassword
      ),
      decoration: InputDecoration(
        suffixIcon: widget.showSuffixIcon ? GestureDetector(
          onTap: (){
            _initialPasswordVisibilityState = !_initialPasswordVisibilityState;
            setState(() {});
          },
          child:  Icon(
              _initialPasswordVisibilityState ? widget.hiddenStateIcon ?? Icons.visibility_off_outlined:
              widget.unHiddenStateIcon ?? Icons.visibility_outlined
          ),
        ) : const SizedBox.shrink(),
        contentPadding: widget.contentPadding,
        focusColor: widget.focusColor,
        hintText: widget.fieldHintText,
        hintStyle: widget.hintStyle ,
        label: widget.label,
        labelStyle: widget.labelStyle,
        labelText: widget.labelText,
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.prefixIconColor,
        prefixStyle: widget.prefixStyle,
        border: widget.border,
        focusedBorder: widget.focusedBorder,
        enabledBorder: widget.enabledBorder,
        disabledBorder: widget.disabledBorder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.showValidatorSheet ? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          onFocusChange: (val){
            onFocus = val;
            setState(() {});
          },
            child: _field()),
        const SizedBox(height: 8,),
     if(onFocus) Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          runSpacing: 8,
          spacing: 5,
          children: _validPattern.map((e) => PasswordChip(label: e.label,isChecked: e.isChecked,)).toList()
        ),
      ],
    ) : _field();
  }
}

