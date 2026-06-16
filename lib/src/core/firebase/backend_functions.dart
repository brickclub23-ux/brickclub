import 'package:cloud_functions/cloud_functions.dart';

class BackendFunctions {
  BackendFunctions({FirebaseFunctions? functions})
    : _functions = functions ?? FirebaseFunctions.instance;

  final FirebaseFunctions _functions;

  Future<MemberProfileDto> getMemberProfile() async {
    final callable = _functions.httpsCallable('getMemberProfile');
    final result = await callable.call<Map<String, dynamic>>();

    return MemberProfileDto.fromJson(result.data);
  }
}

class MemberProfileDto {
  const MemberProfileDto({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.emailVerified,
  });

  factory MemberProfileDto.fromJson(Map<String, dynamic> json) {
    return MemberProfileDto(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
    );
  }

  final String uid;
  final String? email;
  final String? displayName;
  final bool emailVerified;
}
