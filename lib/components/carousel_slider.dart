import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyCarouselSlider extends StatelessWidget {
  MyCarouselSlider({super.key});

  final PageController _controller = PageController();

  final List<String> imageUrls = [
    "https://foodandjourneys.net/wp-content/uploads/2020/09/Danish-Dream-Cake-PIC1.jpg",
    "https://static.cordonbleu.edu/Files/MediaFile/64906.jpg",
    "https://www.britishbakels.co.uk/wp-content/uploads/sites/2/2022/01/Bakels_147-Large.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 210,
          child: PageView(
            controller: _controller,
            children:
                imageUrls.map((url) => carouselPageView(url, context)).toList(),
          ),
        ),
        Container(
          margin: EdgeInsets.all(0),
          height: MediaQuery.of(context).size.height * 0.125,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Overlay text + indicator
        Positioned(
          bottom: 10,
          left: 20,
          right: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else if (details.primaryVelocity! < 0) {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      height: 1.0,
                    ),
                    children: [
                      const TextSpan(text: "Buy 3, Get One "),
                      TextSpan(
                        text: "Free!",
                        style: TextStyle(
                          color: const Color(0xFFFBCD17),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const TextSpan(text: " More pastries, more fun!"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ), // 🔹 Reduced spacing between text and dots
              SmoothPageIndicator(
                controller: _controller,
                count: imageUrls.length,
                effect: ExpandingDotsEffect(
                  activeDotColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  dotColor: Theme.of(context).colorScheme.primary,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget carouselPageView(String imageUrl, BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          progressIndicatorBuilder:
              (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  value: progress.progress,
                ),
              ),
          errorWidget:
              (context, url, error) => const Center(
                child: Icon(Icons.broken_image, color: Colors.red, size: 40),
              ),
        ),
      ),
    );
  }
}
