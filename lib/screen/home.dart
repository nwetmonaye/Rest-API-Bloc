import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_bloc/bloc/get/cubit/getcontact_cubit.dart';
import 'package:test_api_bloc/data/model/contact.dart';
import 'package:test_api_bloc/screen/add_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_api_bloc/screen/edit_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddScreen()));
          if (result != null && result == 'success') {
            BlocProvider.of<GetcontactCubit>(context).getContact();
          }
        },
      ),
      body: BlocBuilder<GetcontactCubit, GetcontactState>(
        builder: (context, state) {
          print(state);
          if (state is GetContactSuccess) {
            List<Contact> contacts = state.contacts;
            return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, position) {
                  return item(contacts[position], context);
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget item(Contact contact, BuildContext context) {
    return Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actions: [
          IconSlideAction(
            icon: Icons.edit,
            color: Colors.blue,
            onTap: () async {
              var result = await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EditScreen(contact)));
              if (result != null && result == 'success') {
                BlocProvider.of<GetcontactCubit>(context).getContact();
              }
            },
          )
        ],
        secondaryActions: [
          IconSlideAction(
            icon: Icons.delete,
            color: Colors.red,
            onTap: () {
              context.read<GetcontactCubit>().delete(contact.id);
            },
          )
        ],
        child: ListTile(
          title: Text(contact.name),
          subtitle: Text(contact.phoneno),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(contact.img),
          ),
        ),
      ),
    );
  }
}
