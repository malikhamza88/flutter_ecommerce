@Timeout(Duration(milliseconds: 500))
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  const email = "test@gmail.com";
  const password = "1234";

  group("submit", () {
    test('''
    Give forumType is signIn
    When signInWithEmailPassword succeed
    Then it returns true
    And state is AsyncData
    ''', () async {
      //setup
      final authRepository = MockAuthRepository();
      when(() => authRepository.signInWithEmailAndPassword(email, password)).thenAnswer(
        (_) => Future.value(),
      );
      final controller = EmailPasswordSignInController(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.signIn,
      );

      // expect later
      expectLater(
          controller.stream,
          emitsInOrder([
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.signIn,
              value: const AsyncLoading<void>(),
            ),
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.signIn,
              value: const AsyncData<void>(null),
            ),
          ]));

      // run
      final result = await controller.submit(email, password);

      // verify
      expect(result, true);
    });

    test('''
    Give forumType is signIn
    When signInWithEmailPassword fails
    Then it returns false
    And state is AsyncError
    ''', () async {
      //setup
      final authRepository = MockAuthRepository();
      final exception = Exception("Connection Failed");
      when(() => authRepository.signInWithEmailAndPassword(email, password)).thenThrow(exception);
      final controller = EmailPasswordSignInController(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.signIn,
      );

      // expect later
      expectLater(
          controller.stream,
          emitsInOrder([
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.signIn,
              value: const AsyncLoading<void>(),
            ),
            predicate<EmailPasswordSignInState>((state) {
              expect(state.formType, EmailPasswordSignInFormType.signIn);
              expect(state.value.hasError, true);
              return true;
            }),
          ]));

      // run
      final result = await controller.submit(email, password);

      // verify
      expect(result, false);
    });

    //
    test('''
    Give forumType is register
    When createUserWithEmailAndPassword succeed
    Then it returns true
    And state is AsyncData
    ''', () async {
      //setup
      final authRepository = MockAuthRepository();
      when(() => authRepository.createUserWithEmailAndPassword(email, password)).thenAnswer(
        (_) => Future.value(),
      );
      final controller = EmailPasswordSignInController(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.register,
      );

      // expect later
      expectLater(
          controller.stream,
          emitsInOrder([
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.register,
              value: const AsyncLoading<void>(),
            ),
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.register,
              value: const AsyncData<void>(null),
            ),
          ]));

      // run
      final result = await controller.submit(email, password);

      // verify
      expect(result, true);
    });

    test('''
    Give forumType is register
    When createUserWithEmailAndPassword fails
    Then it returns false
    And state is AsyncError
    ''', () async {
      //setup
      final authRepository = MockAuthRepository();
      final exception = Exception("Connection Failed");
      when(() => authRepository.createUserWithEmailAndPassword(email, password)).thenThrow(exception);
      final controller = EmailPasswordSignInController(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.register,
      );

      // expect later
      expectLater(
          controller.stream,
          emitsInOrder([
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.register,
              value: const AsyncLoading<void>(),
            ),
            predicate<EmailPasswordSignInState>((state) {
              expect(state.formType, EmailPasswordSignInFormType.register);
              expect(state.value.hasError, true);
              return true;
            }),
          ]));

      // run
      final result = await controller.submit(email, password);

      // verify
      expect(result, false);
    });
  });

  group("updateForumType", () {
    test('''
    Given formType is signIn
    When call with register
    Then state.formType is register
    ''', () {
      //setup
      final authRepository = MockAuthRepository();
      final controller = EmailPasswordSignInController(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.signIn,
      );

      //run
      controller.updateFormType(EmailPasswordSignInFormType.register);

      //verify
      expect(
          controller.debugState,
          EmailPasswordSignInState(
            formType: EmailPasswordSignInFormType.register,
            value: const AsyncData<void>(null),
          ));
    });

    test('''
    Given formType is register
    When call with signIn
    Then state.formType is signIn
    ''', () {
      //setup
      final authRepository = MockAuthRepository();
      final controller = EmailPasswordSignInController(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.register,
      );

      //run
      controller.updateFormType(EmailPasswordSignInFormType.signIn);

      //verify
      expect(
          controller.debugState,
          EmailPasswordSignInState(
            formType: EmailPasswordSignInFormType.signIn,
            value: const AsyncData<void>(null),
          ));
    });
  });
}
