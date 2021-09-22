import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'list_listenable.dart';

typedef ListWidgetBuilder<E> = Widget Function(BuildContext context, List<E> value, Widget? child);

class ListListenableBuilder<E> extends StatefulWidget {
  const ListListenableBuilder({
    Key? key,
    required this.valueListenable,
    required this.builder,
    this.child,
  }) : assert(valueListenable != null),
       assert(builder != null),
       super(key: key);

  final ListListenable<E> valueListenable;

  final ListWidgetBuilder<E> builder;

  final Widget? child;

  @override
  State<StatefulWidget> createState() => _ListListenableBuilderState<E>();
}

class _ListListenableBuilderState<E> extends State<ListListenableBuilder<E>> {

  late List<E> value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(ListListenableBuilder<E> oldWidget) {
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }

  void _valueChanged() {
    setState(() { value = widget.valueListenable.value; });
  }
}