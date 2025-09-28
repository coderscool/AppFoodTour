import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/swipable_advertisement_banner.dart';
import '../widgets/trending_dish_section.dart';
import '../../domain/entities/trending_dish.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeUserScreen> {
  final List<String> bannerUrls = [
    'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
  ];

  List<TrendingDish> trendingDishes = [];
  bool isLoading = true;

  int currentPageIndex = 0;

  void onBannerPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => context.read<HomeBloc>()..add(LoadHomeData(1,1)),
        child: Scaffold(
          appBar: AppBar(
            title: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      Text(
                        'foodtour',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFFE65100),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search, color: Colors.black87),
                      SizedBox(width: 8),
                      Icon(Icons.notifications, color: Colors.black87),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Text(
                        'Explore',
                        style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Offers',
                        style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.grey.withOpacity(0.0),
                              Colors.grey.shade400,
                              Colors.grey.withOpacity(0.0),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                      SwipableAdvertisementBanner(
                        bannerUrls: bannerUrls,
                        currentPageIndex: currentPageIndex,
                        onPageChanged: onBannerPageChanged,
                      ),
                      isLoading
                          ? const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                          : TrendingDishesSection(trendingDishes: trendingDishes),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Center(
                          child: Text(
                            'More delicious content here!',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ),
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
  }
}

