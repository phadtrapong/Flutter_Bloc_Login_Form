import 'dart:async';

import 'package:login_bloc/src/blocs/validators.dart';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Add data to stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print('email is $validEmail password is $validPassword');
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

final bloc = new Bloc();
