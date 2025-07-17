import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StoreDetailScreen extends StatelessWidget {
  static final formatCurrency = NumberFormat("#,##0", "vi_VN");

  final double khongGian = 8.5;
  final double giaCa = 7.5;
  final double viTri = 9.0;
  final double chatLuong = 8.0;
  final double phucVu = 8.2;
  final String storeId;

  const StoreDetailScreen({required this.storeId}) : super();

  double get average =>
      ((khongGian + giaCa + viTri + chatLuong + phucVu) / 5).toDouble();

  bool isOpenNow() {
    final now = TimeOfDay.now();
    final open = TimeOfDay(hour: 7, minute: 0);
    final close = TimeOfDay(hour: 22, minute: 0);

    final nowMinutes = now.hour * 60 + now.minute;
    final openMinutes = open.hour * 60 + open.minute;
    final closeMinutes = close.hour * 60 + close.minute;

    return nowMinutes >= openMinutes && nowMinutes <= closeMinutes;
  }

  @override
  Widget build(BuildContext context) {
    final infoStyle = TextStyle(fontSize: 13, color: Colors.grey[800]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Banner ảnh
          SliverAppBar(
            expandedHeight: 200,
            pinned: false,
            floating: false,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Image.network(
                'https://lh3.googleusercontent.com/p/AF1QipOQ4vF8RmHkRdMLBEHZ10fuDPrJ5REopefYZ_8W=w408-h272-k-no',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Nội dung
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên + địa chỉ
                  Text(
                    'Nhà hàng Ngon Số 1',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.orange, size: 18),
                      SizedBox(width: 4),
                      Text('123 Đường ABC, TP.HCM',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Giờ + trạng thái + số điện thoại
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                color: Colors.orange, size: 16),
                            SizedBox(width: 6),
                            Text('07:00 - 22:00', style: infoStyle),
                            SizedBox(width: 30),
                            Icon(
                              isOpenNow()
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color:
                              isOpenNow() ? Colors.green : Colors.red,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              isOpenNow()
                                  ? 'Đang mở cửa'
                                  : 'Đã đóng cửa',
                              style: infoStyle.copyWith(
                                color: isOpenNow()
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.phone,
                                color: Colors.orange, size: 16),
                            SizedBox(width: 6),
                            Text('0909 123 456', style: infoStyle),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Đánh giá theo tiêu chí
                  RatingBreakdown(
                    khongGian: khongGian,
                    giaCa: giaCa,
                    viTri: viTri,
                    chatLuong: chatLuong,
                    phucVu: phucVu,
                  ),
                  SizedBox(height: 24),

                  Text(
                    'Thực đơn phổ biến',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  // Danh sách món ăn
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1553621042-f6e147245754',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Món ăn dài đặc biệt siêu ngon ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${formatCurrency.format(49000)}đ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.orange[800],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.add,
                                              color: Colors.white),
                                          iconSize: 18,
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RatingBreakdown extends StatelessWidget {
  final double khongGian;
  final double giaCa;
  final double viTri;
  final double chatLuong;
  final double phucVu;

  RatingBreakdown({
    required this.khongGian,
    required this.giaCa,
    required this.viTri,
    required this.chatLuong,
    required this.phucVu,
  });

  double get average =>
      ((khongGian + giaCa + viTri + chatLuong + phucVu) / 5).toDouble();

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(fontSize: 14);
    TextStyle scoreStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange[800]);

    Widget ratingRow(String label, double score) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Text('${score.toStringAsFixed(1)}/10', style: scoreStyle),
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ratingRow('🏠 Không gian', khongGian),
          ratingRow('💰 Giá cả', giaCa),
          ratingRow('📍 Vị trí', viTri),
          ratingRow('🍜 Chất lượng', chatLuong),
          ratingRow('🤝 Phục vụ', phucVu),
          Divider(height: 24, thickness: 1),
          ratingRow('⭐ Trung bình', average),
        ],
      ),
    );
  }
}
