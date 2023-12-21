import 'package:flutter/material.dart';

class PasswordChangeForm extends StatefulWidget {
  final Function(String, String, String) onPasswordChange;

  PasswordChangeForm(this.onPasswordChange);

  @override
  _PasswordChangeFormState createState() => _PasswordChangeFormState();
}

class _PasswordChangeFormState extends State<PasswordChangeForm> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _currentPasswordController,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Trenutna lozinka'),
        ),
        TextFormField(
          controller: _newPasswordController,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Nova lozinka'),
        ),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Potvrda lozinke'),
        ),
      ],
    );
  }
}