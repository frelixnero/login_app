import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
// Note: Assuming these components exist in your project structure
import 'package:login_app/components/carousel_slider.dart';
import 'package:login_app/components/category_widget.dart';
import 'package:login_app/components/image_avatar.dart';
import 'package:login_app/components/my_grid_view.dart';
import 'package:login_app/components/my_icon_btn.dart';
import 'package:login_app/components/my_textfield.dart';
import 'package:login_app/components/skeleton/category_row_skeleton.dart';
import 'package:login_app/components/skeleton/grid_skeleton.dart';
import 'package:login_app/components/skeleton_block.dart';
import 'package:login_app/pages/profile_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController serachBarController = TextEditingController();
  bool _isLoading = true;
  List<String> _foodData = []; // Placeholder for your actual food items

  // This is the required getter that tells Flutter to keep the state alive
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Start fetching the data when the widget is created
    _fetchData();
  }

  // Dispose the controller when the widget is permanently removed
  @override
  void dispose() {
    serachBarController.dispose();
    super.dispose();
  }

  void _fetchData() {
    // Simulate a network delay of 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _foodData = ["Pizza", "Burger", "Taco", "Salad"]; // Actual data
          _isLoading = false; // Data is ready, switch off loading
        });
      }
    });
  }

  // Helper method to build the Category section dynamically
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              'See more',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.primaryContainer,
                fontSize: 15,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ],
        ),
        // CONDITIONAL RENDERING for Categories
        _isLoading
            ? const CategoryRowSkeleton()
            : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CategoryWidget(
                    title: 'Danish',
                    imageUrl:
                        'https://www.seriouseats.com/thmb/ttIGcQA3NrB2MQ1eY_XQLelaaO4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__images__2014__09__20140817-Chocotorta-Allie-Lazar-b8f835dad3e741249e8edb950b2dce18.jpg',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: CategoryWidget(
                      title: 'British',
                      imageUrl:
                          'https://myloveofbaking.com/wp-content/uploads/2020/03/IMG_2446.jpg',
                    ),
                  ),
                  const CategoryWidget(
                    title: 'American',
                    imageUrl:
                        'https://www.gamberorossointernational.com/wp-content/uploads/2022/05/donuts-colorate-1024x683.jpg',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const CategoryWidget(
                      title: 'Swiss',
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Bostoncreampie.jpg/250px-Bostoncreampie.jpg',
                    ),
                  ),
                  const CategoryWidget(
                    title: 'French',
                    imageUrl:
                        'https://myloveofbaking.com/wp-content/uploads/2020/03/IMG_2446.jpg',
                  ),
                ],
              ),
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // MUST be called first when using AutomaticKeepAliveClientMixin
    super.build(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // spacing
                const SizedBox(height: 40),

                // Main Username Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello Emily!',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // marker icon
                            const Icon(Iconsax.map_1),
                            // spacing
                            const SizedBox(width: 10),
                            // location
                            Text(
                              'Lagos',
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Avatar Circle
                    GestureDetector(
                      onTap: () {},
                      // () => Navigator.of(context).pushAndRemoveUntil(
                      //   MaterialPageRoute(builder: (_) => ProfilePage()),
                      //   (route) => false,
                      // ),
                      child: const ImageAvatar(
                        imageUrl: "https://i.pravatar.cc/150",
                      ),
                    ),
                  ],
                ),
                // spacing
                const SizedBox(height: 10),
                // searchbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: MyTextField(
                          hintText: 'Search',
                          controller: serachBarController,
                          preIcon: const Icon(Iconsax.search_normal),
                        ),
                      ),
                    ),
                    MyIconBtn(
                      icon: LucideIcons.sliders,
                      onPressed: () {},
                      height: 60,
                      width: 60,
                    ),
                  ],
                ),
                // spacing
                const SizedBox(height: 10),
                // Sliding Carousel
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.125,
                  // CONDITIONAL RENDERING for Carousel
                  child:
                      _isLoading
                          ? const SkeletonBlock(
                            width: double.infinity,
                            height: double.infinity,
                          )
                          : MyCarouselSlider(),
                ),
                // spacing
                const SizedBox(height: 10),
                // Categories
                _buildCategorySection(),
                // spacing
                const SizedBox(height: 10),
                // Popular Dishes
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Pasteries',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'See more',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            fontSize: 15,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                      ],
                    ),
                    // CONDITIONAL RENDERING for GridView
                    _isLoading ? const GridSkeleton() : MyGridView(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
