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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get sign_in_to_continue {
    return Intl.message(
      'Sign in to continue',
      name: 'sign_in_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get sign_in {
    return Intl.message(
      'SIGN IN',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign`
  String get sign_up {
    return Intl.message(
      'Sign',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Sign In with Facebook`
  String get sign_in_facebook {
    return Intl.message(
      'Sign In with Facebook',
      name: 'sign_in_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Sign In with Google`
  String get sign_in_google {
    return Intl.message(
      'Sign In with Google',
      name: 'sign_in_google',
      desc: '',
      args: [],
    );
  }

  /// `-OR-`
  String get or {
    return Intl.message(
      '-OR-',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Best Selling`
  String get best_selling {
    return Intl.message(
      'Best Selling',
      name: 'best_selling',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get see_all {
    return Intl.message(
      'See All',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Featured Brands`
  String get featured_brands {
    return Intl.message(
      'Featured Brands',
      name: 'featured_brands',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message(
      'Recommended',
      name: 'recommended',
      desc: '',
      args: [],
    );
  }

  /// `{count} Products`
  String products(Object count) {
    return Intl.message(
      '$count Products',
      name: 'products',
      desc: '',
      args: [count],
    );
  }

  /// `Sign Up`
  String get sign_up_page {
    return Intl.message(
      'Sign Up',
      name: 'sign_up_page',
      desc: '',
      args: [],
    );
  }

  /// `The account was created successfully,\nyou can now log in.`
  String get account_created {
    return Intl.message(
      'The account was created successfully,\nyou can now log in.',
      name: 'account_created',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get my_profile {
    return Intl.message(
      'My Profile',
      name: 'my_profile',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dob {
    return Intl.message(
      'Date of Birth',
      name: 'dob',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Password reset link has been sent to your email address`
  String get password_reset_sent {
    return Intl.message(
      'Password reset link has been sent to your email address',
      name: 'password_reset_sent',
      desc: '',
      args: [],
    );
  }

  /// `Account Restore`
  String get account_restore {
    return Intl.message(
      'Account Restore',
      name: 'account_restore',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get enter_your_email {
    return Intl.message(
      'Enter Your Email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `RESTORE`
  String get restore {
    return Intl.message(
      'RESTORE',
      name: 'restore',
      desc: '',
      args: [],
    );
  }

  /// `Required Field`
  String get required_field {
    return Intl.message(
      'Required Field',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `Please Add Full Name`
  String get full_name_required {
    return Intl.message(
      'Please Add Full Name',
      name: 'full_name_required',
      desc: '',
      args: [],
    );
  }

  /// `Minimum eight characters, at least one letter, one number and one special character`
  String get password_requirements {
    return Intl.message(
      'Minimum eight characters, at least one letter, one number and one special character',
      name: 'password_requirements',
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
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}