part of 'postcontact_cubit.dart';

sealed class PostcontactState extends Equatable {
  const PostcontactState();

  @override
  List<Object> get props => [];
}

final class PostcontactInitial extends PostcontactState {}

final class PostcontactLoading extends PostcontactState {}

final class PostcontactSuccess extends PostcontactState {}

final class PostcontactFail extends PostcontactState {
  final String error;

  PostcontactFail(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
