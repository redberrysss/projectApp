import 'package:flutter/material.dart';
import 'booking_page.dart';
import 'package_page.dart';
import 'browse_hotel_page.dart';
import 'customer_support_page.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'my_booking_page.dart';
import 'state_select_page.dart';
import 'deal_page.dart';

class _ColoredQuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const _ColoredQuickActionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.30),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int? discount; // Optional discount property
  final String? country; // Optional country property

  FeaturedItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.discount, // Make discount optional
    this.country, // Make country optional
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<FeaturedItem> featuredItems = [
    FeaturedItem(
      title: 'Luxury Resort',
      subtitle: 'Exclusive offers on luxury stays',
      imageUrl: 'https://picsum.photos/600/400?random=1',
    ),
    FeaturedItem(
      title: 'City Hotels',
      subtitle: 'Best city hotels at great prices',
      imageUrl: 'https://picsum.photos/600/400?random=2',
    ),
    FeaturedItem(
      title: 'Beachside Escape',
      subtitle: 'Relax with an ocean view',
      imageUrl: 'https://picsum.photos/600/400?random=3',
    ),
  ];

  int currentFeatureIndex = 0;

  int _currentIndex = 0; // Track selected bottom tab

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    switch (_currentIndex) {
      case 1:
        bodyContent = const MyBookingsPage();
        break;
      case 2:
        bodyContent = const SettingsPage();
        break;
      default:
        bodyContent = _buildHomeContent();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Hotel Booking'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: 'Navigation Menu',
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal[700]),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('My Booking'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal[700],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Booking',
          ), // label changed here
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: bodyContent,
    );
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            _buildSearchBar(),
            const SizedBox(height: 24),
            // Featured slider
            _buildFeatureSlider(),
            const SizedBox(height: 16),
            _buildIndicatorDots(),
            const SizedBox(height: 30),
            // Quick Actions section with color play
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
            ),
            const SizedBox(height: 16),
            _buildQuickActions(),
            const SizedBox(height: 30),
            // Featured Deals section
            Text(
              'Featured Deals',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
            ),
            const SizedBox(height: 16),
            _buildFeaturedDealsList(),
          ],
        ),
      ),
    );
  }

  // Search bar widget
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for hotels...',
          filled: true,
          fillColor: Colors.teal[50],
          prefixIcon: const Icon(Icons.search, color: Colors.teal),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Search for "\$value" coming soon!')),
          );
        },
      ),
    );
  }

  // Widget for the horizontal featured slider with page controller
  Widget _buildFeatureSlider() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: featuredItems.length,
        onPageChanged: (index) {
          setState(() {
            currentFeatureIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = featuredItems[index];
          return GestureDetector(
            onTap: () {
              // Navigate to PackagePage with the selected package title
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PackagePage(packageTitle: item.title),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Indicator dots below the slider
  Widget _buildIndicatorDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        featuredItems.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: currentFeatureIndex == index ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                currentFeatureIndex == index
                    ? Colors.teal[700]
                    : Colors.teal[200],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Quick Actions section with colored buttons for better user friendliness
Widget _buildQuickActions() {
 // ...inside _buildQuickActions()...
final List<Map<String, dynamic>> actions = [
  {
    'icon': Icons.hotel,
    'title': 'Book Hotel',
    'color': Colors.teal[700], // Changed to teal
    'onTap': () => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const StateSelectionPage()),
    ),
  },
  {
    'icon': Icons.search,
    'title': 'Browse Hotels',
    'color': Colors.teal[600], // Changed to teal
    'onTap': () => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const BrowseHotelPage()),
    ),
  },
  {
    'icon': Icons.local_offer,
    'title': 'Hotel Deals',
    'color': Colors.teal[500], // Changed to teal
    'onTap': () => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hotel Deals clicked! Coming soon...'),
      ),
    ),
  },
  {
    'icon': Icons.favorite,
    'title': 'Favorites',
    'color': Colors.teal[400], // Changed to teal
    'onTap': () => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Favorites clicked! Coming soon...'),
      ),
    ),
  },
  {
    'icon': Icons.support_agent,
    'title': 'Support',
    'color': Colors.teal[300], // Changed to teal
    'onTap': () => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CustomerSupportPage()),
    ),
  },
];

  return Column(
    children: List.generate((actions.length / 2).ceil(), (rowIndex) {
      final rowItems = actions.skip(rowIndex * 2).take(2).toList();
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowItems.map((action) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _ColoredQuickActionCard(
                icon: action['icon'] as IconData,
                title: action['title'] as String,
                color: action['color'] as Color,
                onTap: action['onTap'] as VoidCallback,
              ),
            ),
          )).toList(),
        ),
      );
    }),
  );
}

  // Horizontal list of featured deals/hotels
  // Horizontal list of featured deals/hotels
  Widget _buildFeaturedDealsList() {
    final deals = [
      FeaturedItem(
        title: 'Travel to Malaysia',
        subtitle: 'Up to 20% OFF',
        imageUrl: 'https://picsum.photos/300/200?random=6',
        discount: 20,
        country: 'Malaysia',
      ),
      FeaturedItem(
        title: 'Travel te Thailand',
        subtitle: 'Up to 20% OFF',
        imageUrl: 'https://picsum.photos/300/200?random=6',
        discount: 20,
        country: 'Thailand',
      ),
      FeaturedItem(
        title: 'Beachside Escape',
        subtitle: 'Relax with an ocean view',
        imageUrl: 'https://picsum.photos/300/200?random=6',
        discount: null, // Ensure to set discount to null
        country: null, // Ensure to set country to null
      ),
    ];

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: deals.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final deal = deals[index];
          return GestureDetector(
            onTap: () {
              if (deal.discount != null && deal.country != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => DealsPage(
                          country: deal.country!,
                          maxDiscount:
                              deal.discount!.toDouble(), // Convert to double
                        ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Clicked on ${deal.title}')),
                );
              }
            },
 // ...inside _buildFeaturedDealsList()...
child: ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Container(
    width: 220,
    decoration: BoxDecoration(
      color: Colors.grey[300], // fallback color
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 5),
          blurRadius: 8,
        ),
      ],
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          deal.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Icon(Icons.broken_image, size: 48, color: Colors.grey[600]),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        // ...your existing text and badge widgets here...
        Positioned(
          left: 12,
          bottom: 12,
          right: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deal.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Colors.black,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
              Text(
                deal.subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              if (deal.discount != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: Text(
                      "Up to ${deal.discount!.toInt()}% OFF",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
}