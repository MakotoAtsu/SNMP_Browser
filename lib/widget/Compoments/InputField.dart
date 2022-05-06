import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snmp_browser/widget/Compoments/WidgetTool.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool isRequired;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? formatter;

  InputField(this.controller, this.title, this.isRequired,
      {this.hintText, this.formatter, this.validator});

  @override
  Widget build(BuildContext context) {
    var _validator = isRequired
        ? (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $title';
            }
            return validator?.call(value);
          }
        : validator;

    var textField = TextFormField(
      keyboardType:
          (formatter?.contains(FilteringTextInputFormatter.digitsOnly) == true)
              ? TextInputType.number
              : null,
      inputFormatters: formatter,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: _validator,
    );

    var titleWidget = Text(title + ' :');

    return WidgetTool.createPadding([titleWidget, textField]);
  }
}
