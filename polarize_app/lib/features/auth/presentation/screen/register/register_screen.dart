import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_event.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_state.dart';
import 'package:polarize_app/features/Auth/presentation/screen/login/login_screen.dart';
import 'package:polarize_app/main_wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _userNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    bool obscurePassword = true;
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is InitialAuthState || state is LoadingAuthState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator(color: Colors.white)),
              ],
            );
          } else if (state is SuccesAuthState) {
            return MainWrapper();
          } else if (state is NotSuccesAuthState) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/background_fon.png',
                          height: 270,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 25,
                          left: 30,
                          child: Image.asset(
                            'assets/logo_polarize.png',
                            width: 150,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: double.infinity,
                            height: 580,
                            decoration: BoxDecoration(
                              color: Color(0xFF2D2D2D),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  'Create an account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 35),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 326,
                                        height: 50,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 10,
                                                ),
                                            hintText: 'Username',
                                            hintStyle: TextStyle(
                                              color: const Color.fromARGB(
                                                255,
                                                186,
                                                186,
                                                186,
                                              ),

                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          controller: _userNameController,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      SizedBox(
                                        width: 326,
                                        height: 50,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Email',
                                            hintStyle: TextStyle(
                                              color: const Color.fromARGB(
                                                255,
                                                186,
                                                186,
                                                186,
                                              ),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 10,
                                                ),
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          controller: _emailController,
                                        ),
                                      ),
                                      SizedBox(height: 16),

                                      SizedBox(
                                        width: 326,
                                        height: 50,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                              color: const Color.fromARGB(
                                                255,
                                                204,
                                                204,
                                                204,
                                              ),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),

                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscurePassword =
                                                      !obscurePassword;
                                                });
                                              },
                                              icon: Icon(
                                                obscurePassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 10,
                                                ),
                                            suffixIconColor: Color.fromARGB(
                                              224,
                                              219,
                                              25,
                                              25,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          obscureText: obscurePassword,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          controller: _passwordController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Image.asset('assets/g_logo.png'),
                                    ),
                                    SizedBox(width: 18),
                                    InkWell(
                                      onTap: () {},
                                      child: Image.asset('assets/f_logo.png'),
                                    ),
                                    SizedBox(width: 18),
                                    InkWell(
                                      onTap: () {},
                                      child: Image.asset('assets/t_logo.png'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                SizedBox(
                                  width: 326,
                                  height: 71,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape:
                                          WidgetStateProperty.all<
                                            RoundedRectangleBorder
                                          >(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                          ),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context).add(
                                        RegisterEvent(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 13),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Have an account?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Sign in',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            224,
                                            219,
                                            25,
                                            25,
                                          ),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ErrorAuthState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: Text(state.error))],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: Text('Перезагрузите приложение.'))],
            );
          }
        },
      ),
    );
  }
}
