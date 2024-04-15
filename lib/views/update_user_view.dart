import 'package:crud_project/constants/snack_bar.dart';
import 'package:crud_project/logic/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserView extends StatefulWidget {
  final int id;
  final String name;

  const UpdateUserView({super.key, required this.id, required this.name});

  @override
  State<UpdateUserView> createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends State<UpdateUserView> {
  late final TextEditingController _userNameCtrl;

  @override
  void initState() {
    _userNameCtrl = TextEditingController(text: widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update User"),
      ),
      body: Column(
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
          ElevatedButton(
            onPressed: () async{
              if (_userNameCtrl.text.isEmpty) {
                snackBar(context, "User name cant be null");
              } else {
                context.read<LogicalService>().add(UpdateUserEvent(context,
                    id: widget.id.toString(), name: _userNameCtrl.text));
                    context.read<LogicalService>().add(ReadUserEvent());
              }
            },
            child: BlocBuilder<LogicalService, LogicState>(
              builder: (context, state) {
                if (state is UpdateUserLoading) {
                  bool isLoading = state.isLoading;
                  return isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Update user");
                } else {
                  return const Text("Update user");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
