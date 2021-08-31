import 'package:flutter/material.dart';
import 'package:flutter_app02/ui/widgets/loading_dialog.dart';

class DialogUtil {

  static showLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoadingDialog();
        });
  }
}