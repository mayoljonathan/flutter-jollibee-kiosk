part of '../custom_ui.dart';

class CustomTextField extends StatelessWidget {

  CustomTextField({
    this.autofocus = false,
    this.controller,
    this.enableInteractiveSelection = true,
    this.enabled = true,
    this.obscureText = false,
    this.isDense = false,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.leftmostIcon,
    this.prefix,
    this.prefixIcon,
    this.prefixText,
    this.prefixStyle,
    this.suffix,
    this.suffixText,
    this.suffixStyle,
    this.suffixIcon,
    this.labelText,
    this.style,
    this.validator,
    this.containerPadding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    this.contentPadding, //const EdgeInsets.only(bottom: 6.0)
    this.textCapitalization = TextCapitalization.none,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved
  });

  final TextEditingController controller;
  final bool autofocus;
  final bool enableInteractiveSelection;
  final bool enabled;
  final bool obscureText;
  final bool isDense;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget leftmostIcon;
  final Widget prefix;
  final String prefixText;
  final TextStyle prefixStyle;
  final Widget prefixIcon;
  final Widget suffix;
  final String suffixText;
  final TextStyle suffixStyle;
  final Widget suffixIcon;
  final String labelText;
  final TextStyle style;
  final Function(String) validator;
  final EdgeInsetsGeometry containerPadding;
  final EdgeInsetsGeometry contentPadding;
  final TextCapitalization textCapitalization;
  final VoidCallback onEditingComplete;
  final Function(String) onFieldSubmitted;
  final Function(String) onSaved;

  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(12.0);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kTextFieldBackgroundColor,
      borderRadius: this._borderRadius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: this._borderRadius,
        ),
        padding: this.containerPadding,
        child: TextFormField(
          autofocus: this.autofocus,
          enabled: this.enabled,
          enableInteractiveSelection: this.enableInteractiveSelection,
          focusNode: this.focusNode,
          controller: this.controller,
          obscureText: this.obscureText,
          keyboardType: this.keyboardType,
          textInputAction: this.textInputAction,
          textCapitalization: this.textCapitalization,
          style: this.style,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: this.leftmostIcon,
            labelText: this.labelText,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            errorMaxLines: 2,
            prefix: this.prefix,
            prefixIcon: this.prefixIcon,
            prefixText: this.prefixText,
            prefixStyle: this.prefixStyle,
            suffix: this.suffix,
            suffixText: this.suffixText,
            suffixStyle: this.suffixStyle,
            suffixIcon: this.suffixIcon,
            isDense: this.isDense,
            contentPadding: this.contentPadding ?? null,
          ),
          validator: this.validator,
          onEditingComplete: this.onEditingComplete,
          onFieldSubmitted: this.onFieldSubmitted,
          onSaved: this.onSaved
        ),
      ),
    );
  }
}