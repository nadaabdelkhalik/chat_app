abstract class LoginStates {}

class InitialState extends LoginStates {}

class LoadingState extends LoginStates {}

class UpdateUI extends LoginStates {}

class PasswordVisibilityState extends LoginStates {}

class SuccessState extends LoginStates {}

class FailureState extends LoginStates {}
