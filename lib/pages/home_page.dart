import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:login_app/components/carousel_slider.dart';
import 'package:login_app/components/category_food_tile.dart';
import 'package:login_app/components/category_widget.dart';
import 'package:login_app/components/image_avatar.dart';
import 'package:login_app/components/my_grid_view.dart';
import 'package:login_app/components/my_icon_btn.dart';
import 'package:login_app/components/my_textfield.dart';
import 'package:login_app/components/skeleton/category_row_skeleton.dart';
import 'package:login_app/components/skeleton/grid_skeleton.dart';
import 'package:login_app/components/skeleton_block.dart';
import 'package:login_app/models/food.dart';
import 'package:login_app/models/resturant.dart';
import 'package:login_app/pages/categorie_page.dart';
import 'package:login_app/pages/food_page.dart';
import 'package:login_app/util/responsive.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController serachBarController = TextEditingController();

  bool _isLoading = true;

  // State for search feature
  bool _isSearching = false;

  // List to hold search results
  List<Food> _searchResults = [];

  List<String> _foodData = []; // Placeholder for your actual food items

  // This is the required getter that tells Flutter to keep the state alive
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Start fetching the data when the widget is created
    _fetchData();
    serachBarController.addListener(_onClearText);
  }

  // Listener to automatically stop searching if the field is cleared
  void _onClearText() {
    if (serachBarController.text.isEmpty && _isSearching) {
      // Use Future.microtask to avoid calling setState during build/notification cycle
      Future.microtask(() {
        setState(() {
          _isSearching = false;
          _searchResults = [];
        });
      });
    }
  }

  // Dispose the controller when the widget is permanently removed
  @override
  void dispose() {
    serachBarController.removeListener(_onClearText);
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

  void navigateToCategories(int tabIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriePage(tabIndex: tabIndex),
      ),
    );
  }

  // Method to handle search input changes (filtering)
  // Method to handle search input changes (filtering)
  void _onSearchChanged(String query) {
    final Resturant myResturant = Provider.of<Resturant>(
      context,
      listen: false,
    );
    List<Food> foodItems = myResturant.menu;
    // Ensure we are in search mode, even if triggered by typing
    if (!_isSearching) {
      setState(() {
        _isSearching = true;
      });
    }

    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    // Filter the full list of foods based on the query (case-insensitive)
    final filteredList =
        foodItems.where((food) {
          return food.name.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      _searchResults = filteredList;
    });
  }

  // Helper method to build the Category section dynamically
  Widget _buildCategorySection() {
    final responsiveProvider = Provider.of<Responsive>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        responsiveProvider.isTextEnormousAndLarge(context)
            ? responsiveProvider.isShorterThanNormal(context)
                ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sora-SemiBold",
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => CategoriePage(tabIndex: 0),
                              ),
                            ),
                        child: Text(
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
                      ),
                    ],
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sora-SemiBold",
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriePage(tabIndex: 0),
                            ),
                          ),
                      child: Text(
                        'See more',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                  ],
                )
            : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sora-SemiBold",
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriePage(tabIndex: 0),
                        ),
                      ),
                  child: Text(
                    'See more',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
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
                  CategoryWidget(
                    title: 'Puff',
                    imageUrl:
                        'https://www.seriouseats.com/thmb/ttIGcQA3NrB2MQ1eY_XQLelaaO4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__images__2014__09__20140817-Chocotorta-Allie-Lazar-b8f835dad3e741249e8edb950b2dce18.jpg',
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriePage(tabIndex: 0),
                          ),
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: CategoryWidget(
                      title: 'Flaky',
                      imageUrl:
                          'https://myloveofbaking.com/wp-content/uploads/2020/03/IMG_2446.jpg',
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriePage(tabIndex: 1),
                            ),
                          ),
                    ),
                  ),
                  CategoryWidget(
                    title: 'ShortCrust',
                    imageUrl:
                        'https://www.gamberorossointernational.com/wp-content/uploads/2022/05/donuts-colorate-1024x683.jpg',
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriePage(tabIndex: 2),
                          ),
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: CategoryWidget(
                      title: 'Choux',
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Bostoncreampie.jpg/250px-Bostoncreampie.jpg',
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriePage(tabIndex: 3),
                            ),
                          ),
                    ),
                  ),
                  CategoryWidget(
                    title: 'Filo',
                    imageUrl:
                        'https://myloveofbaking.com/wp-content/uploads/2020/03/IMG_2446.jpg',
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriePage(tabIndex: 4),
                          ),
                        ),
                  ),
                ],
              ),
            ),
      ],
    );
  }

  // Widget to display search results
  Widget _buildSearchResults() {
    if (serachBarController.text.isEmpty) {
      // If the user has tapped the field but not typed anything
      return _buildMainContent();
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 100.0),
      //     child: Text(
      //       'Start typing to search for pastries...',
      //       style: TextStyle(
      //         fontSize: 16,
      //         color: Theme.of(context).colorScheme.tertiary,
      //       ),
      //     ),
      //   ),
      // );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Text(
            'No results found for "${serachBarController.text}"',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      // Important: Use ShrinkWrap and NeverScrollableScrollPhysics inside a SingleChildScrollView
      // to allow the parent to scroll, not the inner list.
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final food = _searchResults[index];
        return CategoryFoodTile(
          food: food,
          // Placeholder for tap action on a search result
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodPage(food: food)),
              ),
        );
      },
    );
  }

  // The main content of the home page (excluding the search bar and header)
  Widget _buildMainContent() {
    final responsiveProvider = Provider.of<Responsive>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Sliding Carousel
        Container(
          height: MediaQuery.of(context).size.height * 0.125,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
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
            responsiveProvider.isTextEnormousAndLarge(context)
                ? responsiveProvider.isShorterThanNormal(context)
                    ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Popular Pasteries',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sora-SemiBold",
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            'See more',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                              fontSize: 15,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Pasteries',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sora-SemiBold",
                          ),
                        ),
                        SizedBox(width: 20),
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
                    )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Pasteries',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sora-SemiBold",
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'See more',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ],
                ),
            // CONDITIONAL RENDERING for GridView
            _isLoading ? const GridSkeleton() : MyGridView(),
          ],
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
        bottom: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello Emily!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sora-Bold",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // marker icon
                            const Icon(Iconsax.location),
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
                          hintText: 'Search for Cakes, Pies, Croissants...',
                          controller: serachBarController,
                          preIcon: const Icon(Iconsax.search_normal),

                          // --- Search Logic Implementation ---
                          // 1. Tapped: Triggers the blank screen/search mode
                          onTap: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                          // 2. Changed: Filters results as the user types
                          onChanged: _onSearchChanged,
                          // --- End Search Logic Implementation ---
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
                // const SizedBox(height: 10),
                // // Sliding Carousel
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.125,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   // CONDITIONAL RENDERING for Carousel
                //   child:
                //       _isLoading
                //           ? const SkeletonBlock(
                //             width: double.infinity,
                //             height: double.infinity,
                //           )
                //           : MyCarouselSlider(),
                // ),
                // spacing
                const SizedBox(height: 10),
                // Categories
                // 3. Conditional Content Area
                if (_isSearching)
                  _buildSearchResults() // Show search results or guidance
                else
                  _buildMainContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
