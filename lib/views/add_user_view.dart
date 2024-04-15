import 'package:crud_project/constants/snack_bar.dart';
import 'package:crud_project/logic/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final TextEditingController _userNameCtrl = TextEditingController();

  @override
  void dispose() {
    _userNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add user'),
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _userNameCtrl,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "User name"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(onPressed: () {
          if (_userNameCtrl.text.isEmpty) {
            snackBar(context, "Please input name");
          } else {
            context
                .read<LogicalService>()
                .add(AddUserEvent(name: _userNameCtrl.text, context: context));
          }
        }, child:
            BlocBuilder<LogicalService, LogicState>(builder: (context, state) {
          if (state is AddUserLoading) {
            bool isLoading = state.isLoading;
            return isLoading
                ? const CircularProgressIndicator(color: Colors.white,)
                : const Text("Add user");
          } else {
            return const Text("Add user");
          }
        }))
      ],
    );
  }
}
