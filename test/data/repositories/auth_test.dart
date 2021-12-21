import 'package:flutter_test/flutter_test.dart';
import 'package:blackboard_public/data/repositories/auth.dart';

void main() {
  late Auth auth;

  setUp(() {
    auth = Auth();
  });

  test('auth-signin', () async {
    final result =
        await auth.signIn(email: "blackboard@uninorte.co", password: "1234567");
    expect(result, true);
  });

  test('auth-signup', () async {
    final result = await auth.signUp(
        name: "Barry Allen",
        email: "barry.allen@example.comentar",
        password: "Superheroe");
    expect(result, true);
  });

  test('auth-signout', () async {
    final result = await auth.signOut();
    expect(result, true);
  });
}
