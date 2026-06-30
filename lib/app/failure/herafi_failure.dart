class Failure {
  final String message;

  const Failure({required this.message});

  factory Failure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return Failure(message: 'Email address is not valid.');
      case 'user-disabled':
        return Failure(message: 'This user has been disabled.');
      case 'user-not-found':
        return Failure(message: 'No user found with this email.');
      case 'wrong-password':
        return Failure(message: 'Wrong password provided.');
      case 'email-already-in-use':
        return Failure(message: 'This email is already in use.');
      case 'operation-not-allowed':
        return Failure(message: 'Operation not allowed.');
      case 'weak-password':
        return Failure(message: 'Password is too weak.');
      case 'user-mismatch':
        return Failure(message: 'User Mismatch.');
      case 'invalid-credential':
        return Failure(message: 'Incorrect Email or Password.');
      case 'network-request-failed':
        return Failure(message: 'No Internet Connection.');
      case 'permission-denied':
        return Failure(
          message: 'You don’t have permission to perform this action.',
        );
      case 'not-found':
        return Failure(message: 'Requested data not found.');
      case 'already-exists':
        return Failure(message: 'This item already exists.');
      case 'cancelled':
        return Failure(message: 'Operation was cancelled.');
      case 'deadline-exceeded':
        return Failure(message: 'Request took too long. Try again.');
      case 'resource-exhausted':
        return Failure(message: 'Quota exceeded. Try again later.');
      case 'unavailable':
        return Failure(message: 'Service is currently unavailable.');
      case 'data-loss':
        return Failure(message: 'Data loss occurred.');
      case 'unauthenticated':
        return Failure(message: 'User is not authenticated.');
      default:
        return Failure(message: ' error : $code');
    }
  }
}
