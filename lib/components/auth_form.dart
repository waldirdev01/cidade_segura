import 'dart:io';
import 'package:cidade_segura/components/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exceptions/auth_exception.dart';
import '../models/auth.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool obscuredText = true;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.login;

  bool _isSignup() => _authMode == AuthMode.signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  void _showPassord() {
    setState(() {
      obscuredText = !obscuredText;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Ocorreu um Erro',
          style: TextStyle(color: Colors.black),
        ),
        content: Text(
          msg,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        //Login
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Registrar
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  void _handleImagePick(File image) {
    Auth().imageUrl = image.path;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.5),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: _isLogin() ? 310 : 400,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    if (_isSignup())
                      UserImagePicker(onImagePick: _handleImagePick),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        icon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (email) => _authData['email'] = email ?? '',
                      validator: (_email) {
                        final email = _email ?? '';
                        if (email.trim().isEmpty || !email.contains('@')) {
                          return 'Informe um e-mail válido.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: const Icon(Icons.key),
                          suffixIcon: InkWell(
                            child: Icon(obscuredText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onTap: _showPassord,
                          )),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: obscuredText,
                      controller: _passwordController,
                      onSaved: (password) =>
                          _authData['password'] = password ?? '',
                      validator: (_password) {
                        final password = _password ?? '';
                        if (password.isEmpty || password.length < 5) {
                          return 'Informe uma senha válida';
                        }
                        return null;
                      },
                    ),
                    if (_isSignup())
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          icon: const Icon(Icons.key),
                            labelText: 'Confirmar Senha',
                            suffixIcon: InkWell(
                              onTap: _showPassord,
                              child: Icon(obscuredText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        validator: _isLogin()
                            ? null
                            : (_password) {
                                final password = _password ?? '';
                                if (password != _passwordController.text) {
                                  return 'Senhas informadas não conferem.';
                                }
                                return null;
                              },
                      ),
                    const SizedBox(height: 20),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          _authMode == AuthMode.login ? 'ENTRAR' : 'REGISTRAR',
                        ),
                      ),
                    TextButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                        _isLogin() ? 'CRIAR CONTA' : 'JÁ POSSUI CONTA?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
