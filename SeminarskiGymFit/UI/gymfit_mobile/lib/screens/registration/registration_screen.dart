import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/custom_text_style.dart';
import 'package:gymfit_mobile/helpers/image_constant.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/register.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/routes/app_routes.dart';
import 'package:gymfit_mobile/screens/login_screen.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:gymfit_mobile/widgets/custom_elevated_button.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';
import 'package:gymfit_mobile/widgets/custom_text_fptm_field.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  late UserLoginProvider _userProvider;
  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserLoginProvider>();

  }

   void register() async {
    try {
      var registerData = Register(
        password: _passwordController.text,
        firstName: _nameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
      );

      await _userProvider.registerAsync(registerData);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Color(0XFF12B422),
              content: Text('Registracija uspješna.',
                  style: TextStyle(
                    color: Colors.white,
                  ))),
        );
        Navigator.pushNamed(context, AppRoutes.loginScreen);
        
      }
    } on Exception catch (e) {
      showErrorDialog(context, getErrorMessage(e));
    }
  }

  
  String getErrorMessage(dynamic exception) {
    if (exception.toString().contains('GymFit.Core.UserNotFoundException') ||
        exception.toString().contains('UserWrongCredentialsException')) {
      return 'Neispravni korisnički podaci. Pokušajte ponovo.';
    } else if (exception
        .toString()
        .contains('The remote computer refused the network connection')) {
      return 'Došlo je do greške na serveru. Pokušajte kasnije.';
    } else {
      return 'Došlo je do nepoznate greške. Pokušajte ponovo.';
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
                horizontal: 28,
                vertical: 35,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.logo1,
                      height: 38,
                      width: 210,
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Registracija",
                      style: theme.textTheme.displaySmall,
                    ),
                    SizedBox(height: 17),
                    _buildNameField(context),
                    SizedBox(height: 14),
                    _buildLastnameField(context),
                    SizedBox(height: 22),
                    _buildEmailField(context),
                    SizedBox(height: 19),
                    _buildPhoneNumberField(context),
                    SizedBox(height: 17),
                    _buildPasswordField(context),
                    SizedBox(height: 19),
                    _buildRegistracija(context),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the login screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(left: 23),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Imate kreiran račun?",
                                  style: CustomTextStyles.titleLargeGray50,
                                ),
                                TextSpan(
                                  text: " ",
                                ),
                                TextSpan(
                                  text: "Prijavi se",
                                  style: CustomTextStyles
                                      .titleLargeSecondaryContainer,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNameField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      padding: EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Ime",
              style: CustomTextStyles.titleLargeGray90001,
            ),
          ),
          CustomTextFormField(
            controller: _nameController,
            hintText: "Ime",
            validator: (value) {
              if (value!.isEmpty) {
                return 'Obavezan unos polja';
              }
              return null;
            },
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLastnameField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      padding: EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 12,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              "Prezime",
              style: CustomTextStyles.titleLargeGray90001,
            ),
          ),
          SizedBox(height: 2),
          CustomTextFormField(
            controller: _lastNameController,
            hintText: "Prezime",
          )
        ],
      ),
    );
  }

  /// Section Widget

  /// Section Widget
  Widget _buildEmailField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      padding: EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Email",
            style: CustomTextStyles.titleLargeGray90001,
          ),
          SizedBox(height: 2),
          CustomTextFormField(
            suffix: const Icon(Icons.email_outlined, color:  Color.fromARGB(255, 53, 53, 53),),
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
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      padding: EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lozinka",
            style: CustomTextStyles.titleLargeGray90001,
          ),
          SizedBox(height: 2),
          CustomTextFormField(
            suffix: IconButton(
              icon: _obscurePassword
                  ? const Icon(Icons.visibility_outlined ,color:  Color.fromARGB(255, 53, 53, 53),)
                  : const Icon(Icons.visibility_off_outlined, color:  Color.fromARGB(255, 53, 53, 53),),
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
                        return 'Unesite šifru!';
                      }

                      // Check for at least 8 characters
                      if (value.length < 8) {
                        return 'Šifra mora sadržavati barem 8 karaktera!';
                      }

                      // Check for at least one uppercase letter
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Šifra mora sadržavati barem jedno veliko slovo!';
                      }

                      // Check for at least one lowercase letter
                      if (!value.contains(RegExp(r'[a-z]'))) {
                        return 'Šifra mora sadržavati barem jedno malo slovo!';
                      }

                      // Check for at least one digit
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Šifra mora sadržavati barem jedan broj!';
                      }

                      // Check for at least one special character
                      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'Šifra mora sadržavati barem jedan specijalni karakter!';
                      }

                      return null;
                    },
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      padding: EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Broj telefona",
            style: CustomTextStyles.titleLargeGray90001,
          ),
          SizedBox(height: 2),
          CustomTextFormField(
            controller: _phoneNumberController,
            hintText: "060222333",
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Obavezan unos polja';
              }
              return null;
            },
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildRegistracija(BuildContext context) {
    return CustomElevatedButton(
      buttonStyle: ElevatedButton.styleFrom(
        backgroundColor: primary
      ),
      onPressed: () {
        if(_formKey.currentState!.validate()){
        register();
        }
      },
      height: 48,
      text: "Registracija",
      margin: EdgeInsets.only(
        left: 19,
        right: 26,
      ),
    );
  }
}
