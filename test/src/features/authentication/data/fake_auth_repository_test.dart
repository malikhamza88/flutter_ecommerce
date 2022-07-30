import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testEmail = "test@gmail.com";
  const testPassword = "1234";
  final testUser = AppUser(uid: testEmail.split('').reversed.join(), email: testEmail);

  FakeAuthRepository makeAuthRepository() => FakeAuthRepository(addDelay: false);

  group("FakeAuthRepository", () {
    test("Current User is null", () {
      final fakeAuthRepository = makeAuthRepository();
      expect(fakeAuthRepository.currentUser, null);
      expect(fakeAuthRepository.authStateChanges(), emits(null));
    });

    test("Current user is not null after sign in", () async {
      final fakeAuthRepository = makeAuthRepository();
      await fakeAuthRepository.signInWithEmailAndPassword(testEmail, testPassword);
      expect(fakeAuthRepository.currentUser, testUser);
      expect(fakeAuthRepository.authStateChanges(), emits(testUser));
    });

    test("Current user is not null after registration", () async {
      final fakeAuthRepository = makeAuthRepository();
      await fakeAuthRepository.createUserWithEmailAndPassword(testEmail, testPassword);
      expect(fakeAuthRepository.currentUser, testUser);
      expect(fakeAuthRepository.authStateChanges(), emits(testUser));
    });

    test("Current user is null after sign_out", () async {
      final fakeAuthRepository = makeAuthRepository();
      await fakeAuthRepository.signInWithEmailAndPassword(testEmail, testPassword);

      expect(fakeAuthRepository.currentUser, testUser);
      expect(fakeAuthRepository.authStateChanges(), emits(testUser));

      await fakeAuthRepository.signOut();
      expect(fakeAuthRepository.currentUser, null);
      expect(fakeAuthRepository.authStateChanges(), emits(null));
    });

    test("Sign in after dispose throws exception", () async {
      final fakeAuthRepository = makeAuthRepository();
      fakeAuthRepository.dispose();
      expect(() => fakeAuthRepository.signInWithEmailAndPassword(testEmail, testPassword), throwsStateError);
    });
  });
}
