import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';

class DialogManager {
  static void showAlertDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showAddNoteDialog(BuildContext context,
      TextEditingController textEditingController, RxString note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: mainVendorText('Add Note'),
          content: Container(
            height: 150,
            width: double.infinity,
            child: FormWidget(
              login: Login(
                  controller: textEditingController,
                  enableText: false,
                  hintText: 'Enter your note',
                  icon: Icon(Icons.event_note_outlined),
                  invisible: false,
                  validator: null,
                  type: TextInputType.name,
                  onChange: null,
                  inputFormat: null),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: subvendorText('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: subvendorText('Add'),
              onPressed: () {
                note.value = textEditingController.text;
                Navigator.of(context).pop();
                print(note.value);
                textEditingController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  static void showConfirmationDialog(BuildContext context, String title,
      String message, Function() onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
