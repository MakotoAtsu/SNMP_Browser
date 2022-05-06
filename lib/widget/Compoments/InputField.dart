import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool isRequired;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? formatter;

  InputField(this.controller, this.title, this.isRequired,
      {this.hintText, this.formatter, this.validator});

  Widget _createPadding(List<Widget> children) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ));

  @override
  Widget build(BuildContext context) {
    // var _validator = validator ??
    //     (isRequired
    //         ? (String? value) {
    //             if (value == null || value.isEmpty) {
    //               return 'Please enter $title';
    //             }
    //             return null;
    //           }
    //         : null);

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

    return _createPadding([titleWidget, textField]);
  }
}
