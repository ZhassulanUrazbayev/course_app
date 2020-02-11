import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex ++;
    }
    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ')');
      if (newValue.selection.end >= 3) selectionIndex += 1;
    }
    if (newTextLength >= 4) {
      newText.write(' ');
      if (newValue.selection.end >= 4) selectionIndex += 1;
    }
    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex += 1;
    }
    if (newTextLength >= 8) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 8) + '-');
      if (newValue.selection.end >= 8) selectionIndex += 1;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }

//            TextFormField(
//              keyboardType: TextInputType.number,
//              textInputAction: TextInputAction.next,
//              maxLength: 15,
//              inputFormatters: <TextInputFormatter>[
//                WhitelistingTextInputFormatter.digitsOnly,
//                _mobileFormatter,
//              ],
//              decoration: InputDecoration(
//                labelText: 'Мобильный номер',
//                prefixText: '+7 ',
//                prefixStyle: TextStyle(
//                  fontSize: 16.0,
//                  color: Colors.black,
//                ),
//              ),
//            ),
}