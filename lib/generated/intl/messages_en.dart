// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(count) => "${count} Products";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "account" : MessageLookupByLibrary.simpleMessage("Account"),
    "best_selling" : MessageLookupByLibrary.simpleMessage("Best Selling"),
    "cart" : MessageLookupByLibrary.simpleMessage("Cart"),
    "categories" : MessageLookupByLibrary.simpleMessage("Categories"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "explore" : MessageLookupByLibrary.simpleMessage("Explore"),
    "featured_brands" : MessageLookupByLibrary.simpleMessage("Featured Brands"),
    "forgot_password" : MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "or" : MessageLookupByLibrary.simpleMessage("-OR-"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "products" : m0,
    "recommended" : MessageLookupByLibrary.simpleMessage("Recommended"),
    "see_all" : MessageLookupByLibrary.simpleMessage("See All"),
    "sign_in" : MessageLookupByLibrary.simpleMessage("SIGN IN"),
    "sign_in_facebook" : MessageLookupByLibrary.simpleMessage("Sign In with Facebook"),
    "sign_in_google" : MessageLookupByLibrary.simpleMessage("Sign In with Google"),
    "sign_in_to_continue" : MessageLookupByLibrary.simpleMessage("Sign in to continue"),
    "sign_up" : MessageLookupByLibrary.simpleMessage("Sign up"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Welcome")
  };
}
