
import 'package:flutter/material.dart';
import '../password_form_field.dart';


class PasswordFormField extends StatefulWidget {
  /// Creates a customizable password field

  const PasswordFormField({Key? key,
    this.hiddenStateIcon,
    this.unHiddenStateIcon,
    this.showSuffixIcon = true,
    this.obscureText = true,
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
    this.prefixStyle, this.contentPadding,
    this.validator,
    this.checkedChipLabelStyle,
    this.uncheckChipLabelStyle,
    this.uncheckChipColor,
    this.checkedChipColor,
    this.checkIcon }) : super(key: key);

  /// Enable the [PasswordFormField] to accept input from keyboard
  /// Default to true.
  final bool enableField;

  /// Allow [PasswordFormField] to accept paste option in toolbar
  /// defaults to true
  final bool canPastePassword;

  /// By default it is true to show [Icons.visibility_off_outlined ] and [Icons.visibility_outlined] icon
  final bool showSuffixIcon;

  /// Display custom visibility off state icon
  final IconData? hiddenStateIcon;

  /// Display custom visibility state icon
  final IconData? unHiddenStateIcon;

  /// Set whether to display the entered text.
  final bool obscureText;

  /// Field info to display when there is no input
  /// this can be empty string but can`t be null
  final String fieldHintText;

  /// Set error message to show when validation is not satisfied
  /// if it is not set "error" message will be shown
  final String? errorText;

  /// Style [fieldHintText]
  final TextStyle? hintStyle;

  final Widget? label;

  /// Set [PasswordFormField] label value
  final String? labelText;
  /// Set [PasswordFormField] label style  value
  final TextStyle? labelStyle;

  /// Listen to error message when field is validated
  /// This return either null, error tex or custom message set at [errorText]
  /// [validator]: (String? val){
  ///   return null || String
  /// }
  final Function(String?)? validator;

  ///Field Decoration border
  final InputBorder? border,
      focusedBorder,
      enabledBorder,
      disabledBorder;
  final TextStyle? inputTextStyle;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController]
  final TextEditingController? textEditingController;

  /// Listen to input when done or go button is clicked
  final Function(String)? onFieldSubmitted;

  /// Provide the list to Pattern to validate the input
  ///  patterns: [
  ///     FieldPattern(label: '3 Uppercase letter', pattern: RegExp(r'(.*[A-Z]){3}')),
  ///  ]
  final List<FieldPattern>? patterns;

  /// Tells the field not to validate input and make pattern label invisible
  final bool showValidatorSheet;

  /// Input event callback which send the full text whenever character is entered
  final Function(String)? onChanged;

  final Color? focusColor;

  /// Display a leading widget before input value
  final Widget? prefix;

  /// Display a leading icon before input value
  final Icon? prefixIcon;

  /// Set prefix text style
  final Color? prefixIconColor;

  /// Set prefix text style
  final TextStyle? prefixStyle;

  /// Padding for the [PasswordFormField]
  final EdgeInsetsGeometry? contentPadding;

  /// Chip
  final TextStyle? checkedChipLabelStyle;
  final TextStyle? uncheckChipLabelStyle;
  final Color? uncheckChipColor;
  final Color? checkedChipColor;
  final Icon? checkIcon;


  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}



class _PasswordFormFieldState extends State<PasswordFormField> {

  /// initiate the text visibility
  late bool _initialPasswordVisibilityState;
  List<FieldPattern> _validPattern = [];
  bool onFocus = false;

  @override
  void initState() {
    _initialPasswordVisibilityState = widget.obscureText;
    _validPattern = [...?widget.patterns];
    super.initState();
  }

  validateInput(String? input){
    int testCaseCount = 0;
    if(widget.showValidatorSheet){
      for(int i = 0; i < _validPattern.length; i++){
        if( !_validPattern[i].isChecked){
          testCaseCount = -1;
          break;
        }
      }
      String? message = testCaseCount == 0 ? null : widget.errorText ?? "error";
      return message;
    }
    if(widget.validator != null) {
      return widget.validator!(input);
    }
    return null;
  }

  Widget _field(){
    return TextFormField(
      key: widget.key,
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
              !_initialPasswordVisibilityState ? widget.hiddenStateIcon ?? Icons.visibility_off_outlined:
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
          children: _validPattern.map((e) => PasswordChip(
            chipLabel: e.label,isChecked: e.isChecked,
            checkedChipColor: widget.checkedChipColor ,
            checkedChipLabelStyle: widget.checkedChipLabelStyle,
            checkIcon: widget.checkIcon,
            uncheckChipColor: widget.uncheckChipColor,
            uncheckChipLabelStyle: widget.uncheckChipLabelStyle,
          )).toList()
        ),
      ],
    ) : _field();
  }
}

/// documentation
