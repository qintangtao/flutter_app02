// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `home`
  String get title {
    return Intl.message(
      'home',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get home {
    return Intl.message(
      'home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `category`
  String get category {
    return Intl.message(
      'category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `mine`
  String get mine {
    return Intl.message(
      'mine',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  /// `favorite`
  String get favorite {
    return Intl.message(
      'favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `info`
  String get about {
    return Intl.message(
      'info',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `share`
  String get share {
    return Intl.message(
      'share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `theme`
  String get theme {
    return Intl.message(
      'theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Switch the theme`
  String get switch_theme {
    return Intl.message(
      'Switch the theme',
      name: 'switch_theme',
      desc: '',
      args: [],
    );
  }

  /// `close`
  String get close {
    return Intl.message(
      'close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `prompt`
  String get prompt {
    return Intl.message(
      'prompt',
      name: 'prompt',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to logout?`
  String get logout_prompt {
    return Intl.message(
      'Do you want to logout?',
      name: 'logout_prompt',
      desc: '',
      args: [],
    );
  }

  /// `login`
  String get login {
    return Intl.message(
      'login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `account`
  String get account {
    return Intl.message(
      'account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `immediately register`
  String get immediately_register {
    return Intl.message(
      'immediately register',
      name: 'immediately_register',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your mobile phone number`
  String get account_hint {
    return Intl.message(
      'Please enter your mobile phone number',
      name: 'account_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get password_hint {
    return Intl.message(
      'Please enter your password',
      name: 'password_hint',
      desc: '',
      args: [],
    );
  }

  /// `The account must be a number of 11 characters`
  String get account_rule {
    return Intl.message(
      'The account must be a number of 11 characters',
      name: 'account_rule',
      desc: '',
      args: [],
    );
  }

  /// `The password must be at least 6 characters`
  String get password_rule {
    return Intl.message(
      'The password must be at least 6 characters',
      name: 'password_rule',
      desc: '',
      args: [],
    );
  }

  /// `loading`
  String get loading {
    return Intl.message(
      'loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `welcome login fm`
  String get login_welcome {
    return Intl.message(
      'welcome login fm',
      name: 'login_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Flutter fm system`
  String get login_app_introduce {
    return Intl.message(
      'Flutter fm system',
      name: 'login_app_introduce',
      desc: '',
      args: [],
    );
  }

  /// `register`
  String get register {
    return Intl.message(
      'register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `welcome register fm`
  String get register_welcome {
    return Intl.message(
      'welcome register fm',
      name: 'register_welcome',
      desc: '',
      args: [],
    );
  }

  /// `register success`
  String get register_success {
    return Intl.message(
      'register success',
      name: 'register_success',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get year {
    return Intl.message(
      '',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get month {
    return Intl.message(
      '',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get day {
    return Intl.message(
      '',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelText {
    return Intl.message(
      'Cancel',
      name: 'cancelText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmText {
    return Intl.message(
      'Confirm',
      name: 'confirmText',
      desc: '',
      args: [],
    );
  }

  /// `take photos`
  String get takePhotosText {
    return Intl.message(
      'take photos',
      name: 'takePhotosText',
      desc: '',
      args: [],
    );
  }

  /// `From the album to choose`
  String get photoAlbumSelectText {
    return Intl.message(
      'From the album to choose',
      name: 'photoAlbumSelectText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
