import 'dart:async';
import 'package:flutter/material.dart';

///验证码按钮
class VerifitionCodeButton extends StatefulWidget {

   const VerifitionCodeButton(
      this.title, {
        Key? key,
        this.onPressed,
        this.seconds = 60,
    }) : super(key: key);

  final void Function() ?onPressed;
  final int seconds;
  final String title;

  @override
  _VerifitionCodeButtonState createState() => _VerifitionCodeButtonState();
}

class _VerifitionCodeButtonState extends State<VerifitionCodeButton> {

  Timer? timer;

  final secondsNotifier = ValueNotifier<int>(1);

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print('_VerifitionCodeButtonState.build.');
    return TextButton(
        onPressed: _countdown,
        child: ValueListenableBuilder<int>(
          valueListenable: secondsNotifier,
          builder: (context, value, child)  {
            //print('_secondsNotifier.build.');
            return Text(
              timer==null ? widget.title : secondsNotifier.value.toString() + "s",
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: Theme.of(context).primaryColor),
            );
          },
        ),
    );
  }

  void _countdown() {
    if (timer == null) {
      widget.onPressed!();
      secondsNotifier.value = widget.seconds;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        secondsNotifier.value--;
        if (secondsNotifier.value <= 0) {
          timer?.cancel();
          timer = null;
        }
      });
    }
  }
}