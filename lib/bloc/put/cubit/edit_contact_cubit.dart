import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/physics.dart';
import 'package:test_api_bloc/data/contact_repository.dart';
import 'package:test_api_bloc/data/model/contact.dart';

part 'edit_contact_state.dart';

class EditContactCubit extends Cubit<EditContactState> {
  final ContactRepository _contactRepository;

  EditContactCubit(this._contactRepository) : super(EditContactInitial());

  void edit(String id, Contact contact) {
    emit(EditContactLoading());
    _contactRepository
        .updateContact(id, contact)
        .then((value) => emit(EditContactSuccess()))
        .catchError((e) => EditContactFail('Error'));
  }
}
