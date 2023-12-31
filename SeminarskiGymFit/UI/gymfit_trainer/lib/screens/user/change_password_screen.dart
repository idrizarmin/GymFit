import 'package:flutter/material.dart';
import 'package:gymfit_trainer/helpers/app_decoration.dart';
import 'package:gymfit_trainer/helpers/constants.dart';
import 'package:gymfit_trainer/helpers/theme_helper.dart';
import 'package:gymfit_trainer/models/user_login.dart';
import 'package:gymfit_trainer/providers/login_provider.dart';
import 'package:gymfit_trainer/routes/app_routes.dart';
import 'package:gymfit_trainer/utils/error_dialog.dart';
import 'package:gymfit_trainer/utils/succes_dialog.dart';
import 'package:provider/provider.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);


  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late UserLoginProvider loginProvider;
  late UserLogin? user;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
  super.initState();
  loginProvider = context.read<UserLoginProvider>(); 
  user = loginProvider.user;
}

  void changePassword() async {
    try {
      var updatedUser = {
        "Id": user!.Id,
        "Password": _passwordController.text,
        "NewPassword": _newPasswordController.text,
        "ConfirmNewPassword": _confirmNewPasswordController.text,
      };
      var userEdited = await loginProvider.chanagePassword(updatedUser);
      if (userEdited == "OK") {
        showSuccessDialog(context, "Uspjesno ste promijenili lozinku!");
        Navigator.of(context).pushReplacementNamed(AppRoutes.userProfileScreen);
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    user = context.watch<UserLoginProvider>().user;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
      });
      return Container();
    }
    return Scaffold(
       backgroundColor: appTheme.bgSecondary,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    decoration: AppDecoration.fillBlack,
                    child: Text(
                      "Korisnički profil",
                      style: TextStyle(fontSize: 14, color: white),
                    ),
                  ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Promjena lozinke",
              style: TextStyle(fontSize: 25, color: Colors.teal),
            ),
            Center(child: ChangePasswordWidget()),
          ],
        ),
      ),
    );
  }

  Widget ChangePasswordWidget() {
    return Container(
      
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: 400,
            
            margin: EdgeInsets.all(24),
            child: Column(children: [
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Unesite staru šifru!';
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text("Trenutna lozinka")),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Unesite novu lozinku!';
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text("Nova lozinka")),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmNewPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Potvrdite novu šifru!';
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text("Potvrdite novu lozinku")),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal
                  ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        changePassword();
                      }
                       
                    },
                    child: Text("Spremi",style: TextStyle(color: white),))
              ])
            ]),
          ),
        ),
      ),
    );
  }
}