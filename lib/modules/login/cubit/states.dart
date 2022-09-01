
abstract class LoginStates {}
class LoginInitState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginsuccessState extends LoginStates{
  final  loginmodel;
  LoginsuccessState(this.loginmodel);
}
class LoginErrorState extends LoginStates{}
class visibiltyChange extends LoginStates{}
class SignupLoadingState extends LoginStates{}
class SignupsuccessState extends LoginStates{
  final  loginmodel;
  SignupsuccessState(this.loginmodel);
}
class SignupErrorState extends LoginStates{}