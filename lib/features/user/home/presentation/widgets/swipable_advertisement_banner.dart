import 'package:flutter/material.dart';
import './banner_page.dart';

class SwipableAdvertisementBanner extends StatelessWidget {
  final List<String> bannerUrls;
  final int currentPageIndex;
  final Function(int) onPageChanged;

  const SwipableAdvertisementBanner({
    required this.bannerUrls,
    required this.currentPageIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: SizedBox(
              height: 120,
              child: PageView.builder(
                itemCount: bannerUrls.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return BannerPage(imageUrl: bannerUrls[index]);
                },
              ),
            ),
          ),
          if (bannerUrls.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bannerUrls.asMap().entries.map<Widget>((entry) {
                  final int index = entry.key;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: currentPageIndex == index ? 24.0 : 8.0,
                    decoration: BoxDecoration(
                      color: currentPageIndex == index
                          ? const Color(0xFFE65100)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}