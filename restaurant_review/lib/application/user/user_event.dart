abstract class UserEvent {}

class FetchUserRequested extends UserEvent {
  FetchUserRequested();
}

class ChangeUsernameRequested extends UserEvent {
  final String newUsername;

  ChangeUsernameRequested(this.newUsername);
}

class ChangePasswordRequested extends UserEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequested(this.oldPassword, this.newPassword);
}

class DeleteAccountRequested extends UserEvent {
  DeleteAccountRequested();
}
