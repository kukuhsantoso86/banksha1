import 'package:bank_sha1/blocs/auth/auth_bloc.dart';
import 'package:bank_sha1/models/sign_up_form_model.dart';
import 'package:bank_sha1/shared/shared_methods.dart';
import 'package:bank_sha1/shared/theme.dart';
import 'package:bank_sha1/ui/pages/sign_up_set_profile_page.dart';
import 'package:bank_sha1/ui/widgets/buttons.dart';
import 'package:bank_sha1/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthCheckEmailSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpSetProfilePage(
                  data: SignUpFormModel(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            children: [
              Container(
                width: 155,
                height: 50,
                margin: const EdgeInsets.only(
                  top: 100,
                  bottom: 100,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/img_logo_light.png',
                    ),
                  ),
                ),
              ),
              Text(
                'join us to unlock\nyour growth',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    //note: name input
                    CustomFormField(
                      title: 'full name',
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //note: email input
                    CustomFormField(
                      title: 'email address',
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //note: password input
                    CustomFormField(
                      title: 'password',
                      obscureText: true,
                      controller: passwordController,
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: 'continue',
                      onPressed: () {
                        if (validate()) {
                          context
                              .read<AuthBloc>()
                              .add(AuthCheckEmail(emailController.text));
                        } else {
                          showCustomSnackbar(
                              context, 'semua field harus diisi');
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextButton(
                title: 'sign in',
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-in');
                },
              ),
              const SizedBox(
                height: 30,
              )
            ],
          );
        },
      ),
    );
  }
}
