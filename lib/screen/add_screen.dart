import 'package:flutter/material.dart';
import 'package:test_api_bloc/bloc/post/cubit/postcontact_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_bloc/data/model/contact.dart';
import 'package:test_api_bloc/module.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostcontactCubit>(
      create: (context) => PostcontactCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Contact'),
        ),
        body: BlocBuilder<PostcontactCubit, PostcontactState>(
          builder: (context, state) {
            if (state is PostcontactLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PostcontactSuccess) {
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
            } else if (state is PostcontactFail) {
              return Center(child: Text(state.error));
            }
            return ContactForm();
          },
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
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
                  Contact contact = Contact("", _name, _job, _age);
                  context.read<PostcontactCubit>().addContact(contact);
                }
              },
              child: Text('Add Contact'))
        ],
      ),
    );
  }
}
