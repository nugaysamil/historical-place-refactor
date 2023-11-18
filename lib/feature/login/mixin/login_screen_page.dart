// ignore_for_file: invalid_use_of_protected_member

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapsuygulama/feature/login/components/login_screen_components.dart';
import 'package:mapsuygulama/feature/login/widgets/text_field/widget_text_field.dart';
import 'package:mapsuygulama/feature/login/controller/login_controller.dart';
import 'package:mapsuygulama/feature/login/controller/login_state.dart';
import 'package:mapsuygulama/feature/profile/companenets/profile_edit.dart';
import 'package:mapsuygulama/product/utils/const/color_const.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';

import '../widgets/text/widget_bottom_text.dart';
import '../widgets/text_field/widget_password_field.dart';
import '../widgets/text/widget_top_text.dart';
import 'package:firebase_auth/firebase_auth.dart';


final class LoginPage extends StatefulHookConsumerWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginContentState();
}

class _LoginContentState extends ConsumerState<LoginPage>
    with TickerProviderStateMixin {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {},
        child: Text(
          forgotPasswordText.tr(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kSecondaryColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginControllerProvider, ((previous, state) {
      if (state is LoginStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    }));
    return Stack(
      children: [
        Positioned(
          top: 136,
          left: 24,
          child: TopText(
            topText: welcomeBack.tr(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputTextField(
                      textController: _emailController,
                      hint: email,
                      iconData: Ionicons.mail_outline),
                  PasswordInputField(
                      textController: _passwordController,
                      hint: password.tr(),
                      iconData: Ionicons.lock_closed_outline),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 135, vertical: 16),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ref.read(loginControllerProvider.notifier).state =
                              LoginStateError(
                                  'Please enter email and password.');
                        } else {
                          try {
                            final email = _emailController.text;
                            final password = _passwordController.text;

                            final methods = await FirebaseAuth.instance
                                .fetchSignInMethodsForEmail(email);

                            if (methods.isNotEmpty) {
                              await ref
                                  .read(loginControllerProvider.notifier)
                                  .userLogin(email, password);

                              Fluttertoast.showToast(
                                msg: msgLogInSucces,
                                toastLength: Toast.LENGTH_SHORT,
                              );

                              Future.delayed(
                                Duration(milliseconds: 700),
                                () {
                                  _emailController.clear();
                                  _passwordController.clear();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileEdit(),
                                    ),
                                  );
                                },
                              );
                            } else {
                              ref.read(loginControllerProvider.notifier).state =
                                  LoginStateError(
                                      'Böyle bir email bulunamadı.');
                            }
                          } catch (e) {
                            ref.read(loginControllerProvider.notifier).state =
                                LoginStateError('Invalid email or password.');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: const StadiumBorder(),
                        backgroundColor: kSecondaryColor,
                        elevation: 8,
                        shadowColor: Colors.black87,
                      ),
                      child: Text(
                        login,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  forgotPassword(),
                ],
              ),
            ],
          ),
        ),
        _textAlign(context),
      ],
    );
  }

  Align _textAlign(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: BottomText(
          onTapCallback: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreenComponents()),
            );
          },
          text2: signUp.tr(),
          text: dontAccount.tr(),
        ),
      ),
    );
  }
}
