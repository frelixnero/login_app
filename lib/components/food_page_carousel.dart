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
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      clipBehavior: Clip.antiAlias, // Ensures circular clip
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                ),
              ),
            );
          } else {
            return child;
          }
        },
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }
}
