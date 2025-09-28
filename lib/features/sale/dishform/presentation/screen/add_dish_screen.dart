import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dish_bloc.dart';
import '../bloc/dish_event.dart';
import '../bloc/dish_state.dart';
import '../widget/dish_form.dart';

class AddDishScreen extends StatelessWidget {
  const AddDishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm món ăn')),
      body: BlocConsumer<DishBloc, DishState>(
        listener: (context, state) {
          if (state is DishSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Thêm món ăn thành công")),
            );
            Navigator.pop(context);
          } else if (state is DishFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Lỗi: ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          if (state is DishLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return DishForm(
            onSubmit: (dish) {
              context.read<DishBloc>().add(AddDishRequested(dish));
            },
          );
        },
      ),
    );
  }
}

