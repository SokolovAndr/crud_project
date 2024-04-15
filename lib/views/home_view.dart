import 'package:crud_project/logic/logic.dart';
import 'package:crud_project/model/user_model.dart';
import 'package:crud_project/views/add_user_view.dart';
import 'package:crud_project/views/update_user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<LogicalService>().add(ReadUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Display users"),
      ),
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUserView()));
          Future.delayed(const Duration(milliseconds: 500), () {
            context.read<LogicalService>().add(ReadUserEvent());
          });
        },
        child: const Text("Add"),
      ),
    );
  }

  Widget get _buildBody {
    return BlocBuilder<LogicalService, LogicState>(builder: (context, state) {
      if (state is LogicInitializeState || state is LogicloadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LogicErrorState) {
        String err = state.error;
        return Center(
          child: Text(err),
        );
      } else if (state is ReadUserState) {
        var data = state.userModel;
        return _buildListView(data);
      } else {
        return Container();
      }
    });
  }

  Widget _buildListView(UserModel userModel) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<LogicalService>().add(ReadUserEvent());
      },
      child: ListView.builder(
          itemCount: userModel.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return UpdateUserView(
                      id: userModel.data[index].id,
                      name: userModel.data[index].name);
                }));
              },
              child: ListTile(
                leading: Text(userModel.data[index].id.toString()),
                title: Text(userModel.data[index].name),
                trailing: IconButton(
                  onPressed: () {
                    context.read<LogicalService>().add(DeleteUserEvent(
                        id: userModel.data[index].id.toString()));
                    context.read<LogicalService>().add(ReadUserEvent());
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ),
            );
          }),
    );
  }
}
