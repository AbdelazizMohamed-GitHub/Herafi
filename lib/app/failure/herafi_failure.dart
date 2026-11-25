class Failure {
  final String message;

  const Failure({required this.message});

  factory Failure.fromCode(String code) {
    switch (code) {
      case 'network-request-failed':
        return const Failure(message: 'No Internet Connection.');

      case 'invalid-email':
        return const Failure(message: 'Email address is not valid.');

      case 'user-disabled':
        return const Failure(message: 'This user has been disabled.');

      case 'user-not-found':
        return const Failure(message: 'No user found with this email.');

      case 'wrong-password':
        return const Failure(message: 'Wrong password provided.');

      case 'email-already-in-use':
        return const Failure(message: 'This email is already in use.');

      case 'operation-not-allowed':
        return const Failure(message: 'Operation not allowed.');

      case 'weak-password':
        return const Failure(message: 'Password is too weak.');

      case 'user-mismatch':
        return const Failure(message: 'User Mismatch.');

      case 'invalid-credential':
        return const Failure(message: 'Incorrect Email or Password.');

      case 'permission-denied':
        return const Failure(
          message: 'You don’t have permission to perform this action.',
        );

      case 'not-found':
        return const Failure(message: 'Requested data not found.');

      case 'already-exists':
        return const Failure(message: 'This item already exists.');

      case 'cancelled':
        return const Failure(message: 'Operation was cancelled.');

      case 'deadline-exceeded':
        return const Failure(message: 'Request took too long. Try again.');

      case 'resource-exhausted':
        return const Failure(message: 'Quota exceeded. Try again later.');

      case 'unavailable':
        return const Failure(message: 'Service is currently unavailable.');

      case 'data-loss':
        return const Failure(message: 'Data loss occurred.');

      case 'unauthenticated':
        return const Failure(message: 'User is not authenticated.');
        

      default:
        return Failure(message: 'Error: $code');
    }
  }
}
