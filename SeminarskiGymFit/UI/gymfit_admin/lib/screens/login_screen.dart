import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/providers/login_provider.dart';
import 'package:provider/provider.dart';
import '../helpers/show_error_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/signIn';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginProvider userProvider;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    userProvider = context.read<LoginProvider>();
  }

  void login() async {
    try {
      await userProvider.loginAsync(
          _emailController.text, _passwordController.text);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        print("$context");
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title: const Text("Prijava"),
        ),
        body: Center(
            child: Container(
          width: 400, // Adjust the width as needed
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 20, 21, 27),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                    width: 250,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obavezno polje: Email!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: Color.fromRGBO(41, 209, 32, 1)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color.fromRGBO(41, 209, 32, 1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color.fromRGBO(41, 209, 32, 1)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      labelStyle: const TextStyle(
                        color: Color.fromRGBO(41, 209, 32, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.name,
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Obavezno polje: Lozinka!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Lozinka",
                      prefixIcon: const Icon(Icons.password_outlined,
                          color: Color.fromRGBO(41, 209, 32, 1)),
                      suffixIcon: IconButton(
                        icon: _obscurePassword
                            ? const Icon(Icons.visibility_outlined,
                                color: Color.fromRGBO(41, 209, 32, 1))
                            : const Icon(Icons.visibility_off_outlined,
                                color: Color.fromRGBO(41, 209, 32, 1)),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color.fromRGBO(41, 209, 32, 1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color.fromRGBO(41, 209, 32, 1)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      labelStyle: const TextStyle(
                        color:  Color.fromRGBO(41, 209, 32, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(41, 209, 32, 1),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        child: const Text(
                          "Prijava",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
