class Failure {
  final String message;
  const Failure({this.message = 'Something Went Wrong'});
}

class GeneralFailure extends Failure {
  GeneralFailure({super.message = 'Something Went Wrong'});
}
