import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vinto/utils/ui/essentials.dart';

class BoxTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool obsecure;
  final bool readOnly;
  final VoidCallback onTap;
  final VoidCallback onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String errorText;
  final String label;
  final Widget suffix;
  final Widget prefix;
  final String hint;
  final List<TextInputFormatter> formatters;

  BoxTextField(
      {Key key,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obsecure = false,
      this.onTap,
      this.hint,
      this.formatters = const [],
      this.isMulti = false,
      this.readOnly = false,
      this.autofocus = false,
      this.errorText,
      @required this.label,
      this.suffix,
      this.prefix,
      this.enabled = true,
      this.onEditingCompleted,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
          onChanged: onChanged,
          onEditingComplete: onEditingCompleted,
          autofocus: autofocus,
          minLines: isMulti ? 4 : 1,
          maxLines: isMulti ? null : 1,
          onTap: onTap,
          enabled: enabled,
          readOnly: readOnly,
          obscureText: obsecure,
          keyboardType: keyboardType,
          controller: controller,
          inputFormatters: formatters,
          decoration: InputDecoration(
            errorText: errorText,
            prefixIcon: prefix,
            hintText: hint,
            suffixIcon: suffix,
            labelStyle: TextStyle(fontSize: 12),
            labelText: label,
            hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 15),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            enabledBorder: textFieldfocused(),
            border: textFieldfocused(),
            focusedBorder: textFieldfocused(),
            errorBorder: errorrTextFieldBorder(),
            focusedErrorBorder: errorrTextFieldBorder(),
          ),
          validator: validator),
    );
  }
}
