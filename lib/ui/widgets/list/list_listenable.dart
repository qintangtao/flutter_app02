import 'package:flutter/foundation.dart';

abstract class ListListenable<E> extends Listenable {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const ListListenable();

  /// The current value of the object. When the value changes, the callbacks
  /// registered with [addListener] will be invoked.
  List<E> get value;
}