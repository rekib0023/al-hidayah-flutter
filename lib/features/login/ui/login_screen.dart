import 'package:al_hidayah/features/home/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/login_bloc.dart';
import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';
import '../../../widgets/buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthBloc loginBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: BlocConsumer<AuthBloc, AuthState>(
            bloc: loginBloc,
            listenWhen: (previous, current) =>
                current is AuthActionState || current is AuthLoadedSucessState,
            buildWhen: (previous, current) => current is! AuthActionState,
            listener: (context, state) {
              if (state is AuthLoadedSucessState) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case AuthLoadingState:
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case AuthInitial || AuthErrorState:
                  return Scaffold(
                    body: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'lib/assets/icons/building.svg',
                                width: 48, // Adjust the size as needed
                                height: 48,
                                color: AppColors.primary,
                              ),
                              const Text(
                                "Management Portal",
                                style: AppTextStyles.heading,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Enter your email address",
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: passwordController,
                                obscureText: obscureText,
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: obscureText
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: PrimaryButton(
                                  text: "LOGIN",
                                  onPressed: () {
                                    loginBloc.add(AuthLoginButtonClickedEvent(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ));
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              state is AuthErrorState
                                  ? SizedBox(
                                      child: Text(
                                        state.message,
                                        style: AppTextStyles.error,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                default:
                  return const SizedBox(
                    child: Text('a'),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
