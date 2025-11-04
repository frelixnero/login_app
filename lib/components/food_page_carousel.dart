import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FoodPageCarousel extends StatelessWidget {
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;

  FoodPageCarousel({
    super.key,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3,
  });

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        PageView(
          controller: _controller,
          children: [
            carouselPageView(imageUrl1, context),
            carouselPageView(imageUrl2, context),
            carouselPageView(imageUrl3, context),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: Theme.of(context).colorScheme.primaryContainer,
              dotColor: Theme.of(context).colorScheme.primary,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
        ),
      ],
    );
  }

  // Carousel Page View
  Widget carouselPageView(String imageUrl, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 265,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,

        // Placeholder while loading
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primaryContainer,
              value: downloadProgress.progress,
            ),
          );
        },

        // Error handling
        errorWidget:
            (context, url, error) => const Center(
              child: Icon(Icons.broken_image, color: Colors.red, size: 40),
            ),
      ),
    );
  }
}
