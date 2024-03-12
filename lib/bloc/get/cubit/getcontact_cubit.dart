import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_api_bloc/data/contact_repository.dart';
import 'package:test_api_bloc/data/model/contact.dart';

part 'getcontact_state.dart';

class GetcontactCubit extends Cubit<GetcontactState> {
  final ContactRepository _contactRepository;
  GetcontactCubit(this._contactRepository) : super(GetcontactInitial());

  void getContact() {
    emit(GetcontactInitial());
    _contactRepository
        .getContact()
        .then((value) => emit(GetContactSuccess(value)))
        .catchError((e) => emit(GetContactFail('Error')));
  }
}
