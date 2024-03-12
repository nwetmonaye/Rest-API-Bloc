part of 'getcontact_cubit.dart';

sealed class GetcontactState extends Equatable {
  const GetcontactState();

  @override
  List<Object> get props => [];
}

final class GetcontactInitial extends GetcontactState {}

final class GetContactSuccess extends GetcontactState {
  final List<Contact> contacts;

  GetContactSuccess(this.contacts);
  @override
  // TODO: implement props
  List<Object> get props => [contacts];
}

final class GetContactFail extends GetcontactState {
  final String error;

  GetContactFail(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
