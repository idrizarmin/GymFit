import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/custom_text_style.dart';
import 'package:gymfit_mobile/helpers/image_constant.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/routes/app_routes.dart';
import 'package:gymfit_mobile/screens/registration/registration_screen.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:gymfit_mobile/widgets/custom_elevated_button.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';
import 'package:gymfit_mobile/widgets/custom_text_fptm_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  late UserLoginProvider userProvider;

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserLoginProvider>();
  }

  void login() async {
    try {
      await userProvider.loginAsync(
          _emailController.text, _passwordController.text);
      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          decoration: BoxDecoration(
            color: appTheme.bgSecondary,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.backImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 31,
                vertical: 45,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 14),
                    CustomImageView(
                      imagePath: ImageConstant.logo,
                      height: 120,
                      width: 240,
                    ),
                    SizedBox(height: 60),
                    Text(
                      "Prijava",
                      style: theme.textTheme.displaySmall,
                    ),
                    SizedBox(height: 20),
                    _buildEmailField(context),
                    SizedBox(height: 20),
                    _buildPasswordField(context),
                    SizedBox(height: 50),
                    CustomElevatedButton(
                      buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: primary
                      ),
                      height: 48,
                      text: "Prijava",
                      margin: EdgeInsets.only(
                        left: 19,
                        right: 20,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                          
                        }
                      },
                    ),
                    SizedBox(height: 3),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Nemate račun?",
                              style:
                                  CustomTextStyles.titleLargeOnPrimaryContainer,
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: "Registrujte se",
                              style:
                                  CustomTextStyles.titleLargeSecondaryContainer,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1),
      padding: EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 5,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2),
            child: Text(
              "Email",
              style: CustomTextStyles.titleLargeGray90001,
            ),
          ),
          SizedBox(height: 14),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextFormField(
                prefix: Icon(Icons.email_outlined ,color: const Color.fromARGB(255, 53, 53, 53),),
                controller: _emailController,
                hintText: "ime.prezime@gmail.com",
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Unesite vaš email.';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Unesite validan email.';
                  }
                  return null;
                },
              ),
            ],
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1),
      padding: EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 5,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2),
            child: Text(
              "Lozinka",
              style: CustomTextStyles.titleLargeGray90001,
            ),
          ),
          SizedBox(height: 14),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextFormField(
                prefix: const Icon(Icons.password_outlined, color:  Color.fromARGB(255, 53, 53, 53),),
                suffix: IconButton(
                  icon: _obscurePassword
                      ? const Icon(Icons.visibility_outlined, color:  Color.fromARGB(255, 53, 53, 53),)
                      : const Icon(Icons.visibility_off_outlined , color:  Color.fromARGB(255, 53, 53, 53),),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                controller: _passwordController,
                hintText: ".......",
                obscureText: _obscurePassword,
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Obavezan unos polja';
                  }
                  return null;
                },
              ),
            ],
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
