import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:test_api_bloc/data/contact_repository.dart';
import 'package:test_api_bloc/data/model/contact.dart';

part 'postcontact_state.dart';

class PostcontactCubit extends Cubit<PostcontactState> {
  final ContactRepository _contactRepository;
  PostcontactCubit(this._contactRepository) : super(PostcontactInitial());

  void addContact(Contact contact) {
    emit(PostcontactLoading());
    _contactRepository
        .addContact(contact)
        .then((value) => emit(PostcontactSuccess()))
        .catchError((e) => emit(PostcontactFail("Error")));
  }
}
