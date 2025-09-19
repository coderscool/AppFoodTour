import 'package:appfoodtour/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:appfoodtour/features/sale/dishform/presentation/screen/add_dish_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/stat_card.dart';
import '../widgets/dish_card.dart';

class HomeSaleScreen extends StatelessWidget {
  const HomeSaleScreen({super.key});

  Future<String?> _getUserId() async {
    final localDataSource = AuthLocalDataSourceImpl();
    return await localDataSource.getUserId();
  }

  @override
  Widget build(BuildContext context) {
    final Future<String?> futureUserId = _getUserId();

    return FutureBuilder<String?>(
      future: futureUserId,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text("Không tìm thấy userId")),
          );
        }

        final id = snapshot.data!;

        return BlocProvider(
          create: (_) => context.read<HomeBloc>()..add(LoadHomeData(id)),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: const Text(
                'Quản lý quán ăn',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tổng quan',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: [
                            for (int i = 0; i < state.stats.length; i++) ...[
                              StatCard(stat: state.stats[i]),
                              if (i < state.stats.length - 1)
                                const SizedBox(height: 12),
                            ],
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Danh sách món ăn',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AddDishScreen()),
                                );
                              },
                              icon: const Icon(Icons.add,
                                  color: Colors.deepOrange),
                              tooltip: 'Thêm món ăn',
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (state.dishes.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Chưa có món ăn nào',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          )
                        else
                          ...state.dishes.map((dish) => DishCard(dish: dish)),
                      ],
                    ),
                  );
                } else if (state is HomeError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        );
      },
    );
  }
}