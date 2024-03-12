import 'package:flutter/material.dart';
import 'package:test_api_bloc/bloc/post/cubit/postcontact_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_bloc/bloc/put/cubit/edit_contact_cubit.dart';
import 'package:test_api_bloc/data/model/contact.dart';
import 'package:test_api_bloc/module.dart';

class EditScreen extends StatelessWidget {
  final Contact _contact;

  EditScreen(this._contact);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditContactCubit>(
      create: (context) => EditContactCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Contact'),
        ),
        body: BlocBuilder<EditContactCubit, EditContactState>(
          builder: (context, state) {
            if (state is EditContactLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is EditContactSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Success'),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, 'success');
                        },
                        child: Text('Go Home'))
                  ],
                ),
              );
            } else if (state is EditContactFail) {
              return Center(child: Text(state.error));
            }
            return ContactForm(this._contact);
          },
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  final Contact _contact;
  ContactForm(this._contact);

  @override
  State<ContactForm> createState() => _ContactFormState(this._contact);
}

class _ContactFormState extends State<ContactForm> {
  final Contact _contact;
  _ContactFormState(this._contact);
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _job = "";
  String _age = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          TextFormField(
            initialValue: _contact.name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Name',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please Enter Name';
              }
              return null;
            },
            onSaved: (value) {
              this._name = value!;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: _contact.age,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Age',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please Enter Age';
              }
              return null;
            },
            onSaved: (value) {
              this._age = value!;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: _contact.job,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Job',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please Enter Job';
              }
              return null;
            },
            onSaved: (value) {
              this._job = value!;
            },
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Contact contact = Contact(_contact.id, _name, _job, _age);
                  context.read<EditContactCubit>().edit(_contact.id, contact);
                }
              },
              child: Text('Edit Contact'))
        ],
      ),
    );
  }
}
