
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
  final InputBorder? border,
      focusedBorder,
      enabledBorder,
      disabledBorder;
  final TextStyle? inputTextStyle;
  final TextEditingController? textEditingController;
  final Function(String)? onFieldSubmitted;
  final List<Validator>? patterns;
  final bool showValidatorSheet;
  final Function(String)? onChanged;
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
    this.showValidatorSheet = true, this.onChanged }) : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {

  late bool _initialPasswordVisibilityState;
  late AnimationController _animationController;
  late Animation<double> _animation ;
  List<Validator> _validsPattern = [];

  validateInput(String? input){}

  @override
  void initState() {
    // TODO: implement initState
    _initialPasswordVisibilityState = widget.initialPasswordState;
    _validsPattern = [...?widget.patterns];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          if(widget.showValidatorSheet && _validsPattern.isNotEmpty){}
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
        border: widget.border,
        focusedBorder: widget.focusedBorder,
        enabledBorder: widget.enabledBorder,
        disabledBorder: widget.disabledBorder,
      ),
    );
  }
}

