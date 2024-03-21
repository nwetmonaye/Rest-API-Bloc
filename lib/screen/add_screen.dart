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
  String _phoneno = "";
  String _img = "";
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
              hintText: 'Enter Phone No',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please Enter Phone No';
              }
              return null;
            },
            onSaved: (value) {
              this._phoneno = value!;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Profile Picture',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please Enter Profile Picture';
              }
              return null;
            },
            onSaved: (value) {
              this._img = value!;
            },
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Contact contact = Contact("", _name, _phoneno, _img);
                  context.read<PostcontactCubit>().addContact(contact);
                }
              },
              child: Text('Add Contact'))
        ],
      ),
    );
  }
}
