import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'list_listenable.dart';

class ListNotifier<E> extends ChangeNotifier implements Iterable<E>, List<E>, ListListenable<E> {
  /// Creates a [ChangeNotifier] that wraps this value.
  ListNotifier(this._value);

  /// The current value stored in this notifier.
  ///
  /// When the value is replaced with something that is not equal to the old
  /// value as evaluated by the equality operator ==, this class notifies its
  /// listeners.
  @override
  List<E> get value => _value;
  List<E> _value;
  set value(List<E> newValue) {
    //if (_value == newValue) return;
    if (const DeepCollectionEquality().equals(_value, newValue)) return;
    _value = newValue;
    notifyListeners();
  }


  @override
  List<E> operator +(List<E> other) => _value + other;

  @override
  E operator [](int index) => _value[index];

  @override
  void operator []=(int index, E value) {
    _value[index] = value;
    notifyListeners();
  }

  @override
  void add(E value) {
    _value.add(value);
    notifyListeners();
  }

  @override
  void addAll(Iterable<E> iterable) {
    _value.addAll(iterable);
    notifyListeners();
  }

  @override
  Map<int, E> asMap() => _value.asMap();

  @override
  void clear() {
    _value.clear();
    notifyListeners();
  }

  @override
  void fillRange(int start, int end, [E? fillValue]) {
    _value.fillRange(start, end, fillValue);
    notifyListeners();
  }

  @override
  set first(E value) {
    _value.first = value;
    notifyListeners();
  }

  @override
  Iterable<E> getRange(int start, int end) => _value.getRange(start, end);

  @override
  int indexOf(E element, [int start = 0]) => _value.indexOf(element, start);

  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) =>
      _value.indexWhere(test, start);

  @override
  void insert(int index, E element) {
    _value.insert(index, element);
    notifyListeners();
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    _value.insertAll(index, iterable);
    notifyListeners();
  }

  @override
  set last(E value) {
    _value.last = value;
    notifyListeners();
  }

  @override
  int lastIndexOf(E element, [int? start]) =>
      _value.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(E element) test, [int? start]) =>
      _value.lastIndexWhere(test, start);

  @override
  set length(int newLength) {
    _value.length = newLength;
    notifyListeners();
  }

  @override
  bool remove(Object? value) {
    final value2 = _value.remove(value);
    notifyListeners();
    return value2;
  }

  @override
  E removeAt(int index) {
    final value = _value.removeAt(index);
    notifyListeners();
    return value;
  }

  @override
  E removeLast() {
    final value = _value.removeLast();
    notifyListeners();
    return value;
  }

  @override
  void removeRange(int start, int end) {
    _value.removeRange(start, end);
    notifyListeners();
  }

  @override
  void removeWhere(bool Function(E element) test) {
    _value.removeWhere(test);
    notifyListeners();
  }

  @override
  void replaceRange(int start, int end, Iterable<E> replacements) {
    _value.replaceRange(start, end, replacements);
    notifyListeners();
  }

  @override
  void retainWhere(bool Function(E element) test) {
    _value.retainWhere(test);
    notifyListeners();
  }

  @override
  Iterable<E> get reversed => _value.reversed;

  @override
  void setAll(int index, Iterable<E> iterable) {
    _value.setAll(index, iterable);
    notifyListeners();
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    _value.setRange(start, end, iterable);
    notifyListeners();
  }

  @override
  void shuffle([Random? random]) {
    _value.shuffle(random);
    notifyListeners();
  }

  @override
  void sort([int Function(E a, E b)? compare]) {
    _value.sort(compare);
    notifyListeners();
  }

  @override
  List<E> sublist(int start, [int? end]) => _value.sublist(start, end);


  @override
  String toString() => _value.toString();

  @override
  bool any(bool Function(E element) test)  => _value.any(test);

  @override
  List<R> cast<R>() => _value.cast<R>();

  @override
  bool contains(Object? element) => _value.contains(element);

  @override
  E elementAt(int index) => _value.elementAt(index);

  @override
  bool every(bool Function(E element) test) => _value.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) toElements) => _value.expand(toElements);

  @override
  E get first => _value.first;

  @override
  E firstWhere(bool test(E element), {E orElse()?}) => _value.firstWhere(test, orElse: orElse);


  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) => _value.fold(initialValue, combine);

  @override
  Iterable<E> followedBy(Iterable<E> other) => _value.followedBy(other);

  @override
  void forEach(void Function(E element) action)  => _value.forEach(action);

  @override
  bool get isEmpty => _value.isEmpty;

  @override
  bool get isNotEmpty => _value.isNotEmpty;

  @override
  Iterator<E> get iterator => _value.iterator;

  @override
  String join([String separator = ""]) => _value.join(separator);

  @override
  E get last => _value.last;

  @override
  E lastWhere(bool Function(E element) test, {E Function()? orElse})=> _value.lastWhere(test, orElse: orElse);

  @override
  int get length => _value.length;

  @override
  Iterable<T> map<T>(T Function(E e) toElement) => _value.map(toElement);

  @override
  E reduce(E Function(E value, E element) combine) => _value.reduce(combine);

  @override
  E get single => _value.single;

  @override
  E singleWhere(bool Function(E element) test, {E Function()? orElse}) => _value.singleWhere(test, orElse: orElse);

  @override
  Iterable<E> skip(int count) => _value.skip(count);

  @override
  Iterable<E> skipWhile(bool Function(E value) test) => _value.skipWhile(test);

  @override
  Iterable<E> take(int count) => _value.take(count);

  @override
  Iterable<E> takeWhile(bool Function(E value) test) => _value.takeWhile(test);

  @override
  List<E> toList({bool growable = true}) => _value.toList(growable: growable);

  @override
  Set<E> toSet() => _value.toSet();

  @override
  Iterable<E> where(bool Function(E element) test) => _value.where(test);

  @override
  Iterable<T> whereType<T>() => _value.whereType();
}