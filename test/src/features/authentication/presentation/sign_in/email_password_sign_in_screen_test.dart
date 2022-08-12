import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  const testEmail = "test@gmail.com";
  const testPassword = "1234";
  late MockAuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });

  group("signIn", () {
    testWidgets('''
      Give formType is signIn
      When tap on sign-in button
      Then signInWithEmailAndPassword is not called
      ''', (tester) async {
      final r = AuthRobot(tester);
      await r.pumpEmailPasswordSignInContents(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.signIn,
      );
      await r.tapEmailAndPasswordSubmitButton();
      verifyNever(
        () => authRepository.signInWithEmailAndPassword(
          any(),
          any(),
        ),
      );
    });

    testWidgets('''
      Give formType is signIn
      When enter valid email and password
      And tap in sign-in button
      Then signInWithEmailAndPassword is called
      And onSignedIn callback is called
      And error alert is not shown
      ''', (tester) async {
      final r = AuthRobot(tester);
      await r.pumpEmailPasswordSignInContents(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.signIn,
      );
      await r.tapEmailAndPasswordSubmitButton();
      verifyNever(
        () => authRepository.signInWithEmailAndPassword(
          any(),
          any(),
        ),
      );
    });
  });
}
