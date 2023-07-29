class LogInWithEmailAndPasswordFailure {
   String message;
   LogInWithEmailAndPasswordFailure(this.message);

  factory LogInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'wrong-password':
        return  LogInWithEmailAndPasswordFailure(
            'You have entered an invalid email or password');
      case 'invalid-email':
        return  LogInWithEmailAndPasswordFailure(
            'You have entered an invalid email or password');
      case 'email-already-in-case':
        return  LogInWithEmailAndPasswordFailure(
            'Please enter a stronger password.');
      case 'operation-not-allowed':
        return  LogInWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted. ');
      case 'user-disabled':
        return LogInWithEmailAndPasswordFailure(
            'User Disabled');
      case 'user-not-found':
        return LogInWithEmailAndPasswordFailure(
           'User Not Found');
      default:
        return LogInWithEmailAndPasswordFailure('You have entered an invalid email or password');
    }
  }
}

class SignUpWithEmailAndPasswordfailure {
  final String message;
  const SignUpWithEmailAndPasswordfailure(
      [this.message = "An uknown errorr occurred"]);

  factory SignUpWithEmailAndPasswordfailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordfailure(
            'Please enter a stronger password.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordfailure(
            'Email is not valid or badly formatted. ');

      case 'email-already-in-case':
        return const SignUpWithEmailAndPasswordfailure(
            'Please enter a stronger password.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordfailure(
            'Email is not valid or badly formatted. ');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordfailure(
            'Email is not valid or badly formatted. ');

      default:
        return const SignUpWithEmailAndPasswordfailure();
    }
  }
}
