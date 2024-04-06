part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLoginRequested extends AppEvent {
  const AppLoginRequested(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

class UpdateFcmToken extends AppEvent {
  const UpdateFcmToken();
}
