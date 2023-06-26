import 'package:cloud_firestore_odm/annotation.dart';

class EmailAddressValidator implements Validator {
  const EmailAddressValidator();

  @override
  void validate(Object? v, String value) {
    if (!v.toString().endsWith('@gmail.com')) {
      throw Exception('Email address is not valid!');
    }
  }
}
