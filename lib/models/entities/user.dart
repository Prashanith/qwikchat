import 'package:json_annotation/json_annotation.dart';

import '../validators/email.dart';

@JsonSerializable(explicitToJson: true)
class User {
  User({
    required this.name,
    required this.email,
  });

  final String name;
  @EmailAddressValidator()
  final String email;
}
