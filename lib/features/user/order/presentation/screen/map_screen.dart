import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ##########################################################################
// THAY THẾ BẰNG API KEY GOOGLE MAPS THỰC TẾ CỦA BẠN TẠI ĐÂY
// HÃY ĐẢM BẢO BẠN ĐÃ KÍCH HOẠT CÁC API CẦN THIẾT TRÊN GOOGLE CLOUD CONSOLE:
// - Maps SDK for Android
// - Maps SDK for iOS
// - Directions API
// ##########################################################################
const String Maps_API_KEY = "AIzaSyDmPOj1HFlSVpSUB9HceLx0YLyZgKKDJIsYOUR_API_KEY_HERE";

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  // Tọa độ ví dụ:
  // _origin: Bến xe Mỹ Đình, Hà Nội
  // _destination: Hồ Gươm, Hà Nội
  LatLng _origin = LatLng(21.028682, 105.776602);
  LatLng _destination = LatLng(21.028000, 105.854000);

  String _distance = "Đang tính...";
  String _duration = "Đang tính...";

  @override
  void initState() {
    super.initState();
    // Đặt các marker ban đầu và lấy đường đi khi widget khởi tạo
    _setMarkers();
    _getPolyline();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Hàm đặt các điểm đánh dấu (Markers) trên bản đồ
  void _setMarkers() {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('origin'),
          position: _origin,
          infoWindow: const InfoWindow(title: 'Điểm xuất phát', snippet: 'Bến xe Mỹ Đình'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Marker màu xanh
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: _destination,
          infoWindow: const InfoWindow(title: 'Điểm đến', snippet: 'Hồ Gươm'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Marker màu đỏ
        ),
      );
    });
  }

  // Hàm gọi Google Directions API để lấy đường đi và thông tin khoảng cách/thời gian
  _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    // Xây dựng URL cho Google Directions API
    String requestUrl =
        "https://maps.googleapis.com/maps/api/directions/json?"
        "origin=${_origin.latitude},${_origin.longitude}"
        "&destination=${_destination.latitude},${_destination.longitude}"
        "&key=$Maps_API_KEY";

    print("Requesting directions from: $requestUrl"); // Log URL để debug

    try {
      var response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['routes'] != null && data['routes'].isNotEmpty) {
          String encodedPolyline = data['routes'][0]['overview_polyline']['points'];
          List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);

          for (var point in result) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }

          // Lấy thông tin khoảng cách và thời gian
          if (data['routes'][0]['legs'] != null && data['routes'][0]['legs'].isNotEmpty) {
            _distance = data['routes'][0]['legs'][0]['distance']['text'];
            _duration = data['routes'][0]['legs'][0]['duration']['text'];
          } else {
            _distance = "Không có thông tin khoảng cách";
            _duration = "Không có thông tin thời gian";
          }

          setState(() {
            _polylines.add(
              Polyline(
                polylineId: const PolylineId('route'),
                points: polylineCoordinates,
                color: Colors.blue,
                width: 5,
              ),
            );
          });
        } else {
          print("Không tìm thấy tuyến đường trong phản hồi API.");
          setState(() {
            _distance = "Không có tuyến đường";
            _duration = "Không có tuyến đường";
          });
        }
      } else {
        print("Lỗi khi gọi Directions API. Status code: ${response.statusCode}, Body: ${response.body}");
        setState(() {
          _distance = "Lỗi tải dữ liệu";
          _duration = "Lỗi tải dữ liệu";
        });
      }
    } catch (e) {
      print("Đã xảy ra lỗi mạng hoặc phân tích JSON: $e");
      setState(() {
        _distance = "Lỗi mạng/dữ liệu";
        _duration = "Lỗi mạng/dữ liệu";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps với Đường đi'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _origin,
              zoom: 12.0, // Zoom để thấy cả hai điểm
            ),
            markers: _markers,
            polylines: _polylines, // Hiển thị đường đi
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.route, color: Colors.blue, size: 24),
                        const SizedBox(width: 12),
                        Flexible( // Sử dụng Flexible để tránh tràn chữ nếu quá dài
                          child: Text(
                            'Khoảng cách: $_distance',
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis, // Cắt bớt nếu dài quá
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.orange, size: 24),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            'Thời gian: $_duration',
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}