import 'package:appfoodtour/features/user/storedetail/presentation/screen/store_detail_screen.dart';
import 'package:flutter/material.dart';

class Store {
  final String name;
  final String city;
  final String cuisine;
  final String imageUrl;

  Store(this.name, this.city, this.cuisine, this.imageUrl);
}

class StoreListScreen extends StatefulWidget {
  const StoreListScreen({super.key});

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  final List<Store> _allStores = [
    Store(
      'Sushi Tokyo',
      'Hồ Chí Minh',
      'Nhật Bản',
      'https://lh3.googleusercontent.com/p/AF1QipOQ4vF8RmHkRdMLBEHZ10fuDPrJ5REopefYZ_8W=w408-h272-k-no',
    ),
  ];

  String _searchName = '';
  String? _selectedCity;
  String? _selectedCuisine;

  bool _isCityDropdownOpen = false;
  bool _isCuisineDropdownOpen = false;

  List<String> get _cities =>
      _allStores.map((e) => e.city).toSet().toList()..sort();

  List<String> get _cuisines =>
      _allStores.map((e) => e.cuisine).toSet().toList()..sort();

  @override
  Widget build(BuildContext context) {
    final filteredStores = _allStores.where((store) {
      return store.name.toLowerCase().contains(_searchName.toLowerCase()) &&
          (_selectedCity == null || store.city == _selectedCity) &&
          (_selectedCuisine == null || store.cuisine == _selectedCuisine);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        toolbarHeight: 60, // 👈 Tăng chiều cao header
        title: const Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            'Khám phá quán ăn',
            style: TextStyle(
              fontSize: 24, // 👈 Font to hơn
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: false, // 👈 Căn trái
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildSearchField('Tìm theo tên cửa hàng', Icons.search, (val) {
              setState(() => _searchName = val);
            }),
            const SizedBox(height: 12),
            _buildCustomDropdown(
              label: 'Chọn thành phố',
              icon: Icons.location_city,
              value: _selectedCity,
              isOpen: _isCityDropdownOpen,
              items: _cities,
              onToggle: () => setState(() {
                _isCityDropdownOpen = !_isCityDropdownOpen;
                _isCuisineDropdownOpen = false;
              }),
              onSelected: (val) {
                setState(() {
                  _selectedCity = val;
                  _isCityDropdownOpen = false;
                });
              },
            ),
            const SizedBox(height: 12),
            _buildCustomDropdown(
              label: 'Chọn món ăn nước nào',
              icon: Icons.language,
              value: _selectedCuisine,
              isOpen: _isCuisineDropdownOpen,
              items: _cuisines,
              onToggle: () => setState(() {
                _isCuisineDropdownOpen = !_isCuisineDropdownOpen;
                _isCityDropdownOpen = false;
              }),
              onSelected: (val) {
                setState(() {
                  _selectedCuisine = val;
                  _isCuisineDropdownOpen = false;
                });
              },
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredStores.length,
              itemBuilder: (context, index) {
                final store = filteredStores[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreDetailScreen(storeId: "1234"),
                        ),
                      );
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        store.imageUrl,
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      store.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${store.city} • ${store.cuisine}'),
                  ),
                );
              },
            ),
            if (filteredStores.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text('Không tìm thấy cửa hàng nào'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(
      String hint,
      IconData icon,
      ValueChanged<String> onChanged,
      ) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildCustomDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required bool isOpen,
    required List<String> items,
    required VoidCallback onToggle,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.grey[700]),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value ?? label,
                    style: TextStyle(
                      color: value == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey[700],
                ),
              ],
            ),
          ),
        ),
        if (isOpen)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              shrinkWrap: true,
              children: items
                  .map(
                    (item) => ListTile(
                  title: Text(item),
                  onTap: () => onSelected(item),
                ),
              ).toList(),
            ),
          ),
      ],
    );
  }
}
