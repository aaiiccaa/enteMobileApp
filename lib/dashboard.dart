import 'package:flutter/material.dart';
import 'dart:async';
import 'detail.dart';
import 'profile.dart'; // Import the profile page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ENTe',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Inter'
      ),
      home: const MyHomePage(title: 'ENTe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> items = [
    {'title': 'Ayam Gepuk Pak Gembus', 'image': 'assets/image.png', 'location': 'Sukapura', 'type': 'Main Course'},
    {'title': 'Ayam Goreng Sukabirus', 'image': 'assets/image.png', 'location': 'Sukabirus', 'type': 'Main Course'},
    {'title': 'Haus', 'image': 'assets/image.png', 'location': 'Gapura', 'type': 'Beverage'},
    {'title': 'Ayam Geprek Mesir', 'image': 'assets/image.png', 'location': 'Sukabirus', 'type': 'Main Course'},
    {'title': 'Item 5', 'image': 'assets/image.png', 'location': 'Other', 'type': 'Main Course'},
  ];

  String? selectedLocation;
  String? selectedType;
  int _selectedIndex = 0;

  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_pageController.page == 2) {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      _buildHomePage(),
      Center(child: Text('Bookmarks Page')), // Dummy page for bookmarks
      ProfilePage(), // Profile page
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomePage() {
    final filteredItems = items.where((item) {
      final matchesLocation = selectedLocation == null || item['location'] == selectedLocation;
      final matchesType = selectedType == null || item['type'] == selectedType;
      return matchesLocation && matchesType;
    }).toList();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Slider
            Container(
              height: 200,
              child: PageView(
                controller: _pageController,
                children: [
                  Image.asset('assets/banner1.png', fit: BoxFit.cover),
                  Image.asset('assets/banner2.png', fit: BoxFit.cover),
                  Image.asset('assets/banner3.png', fit: BoxFit.cover),
                ],
              ),
            ),
            // Filter Dropdowns
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: DropdownButton<String>(
                      value: selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          selectedLocation = newValue;
                        });
                      },
                      items: ['Sukapura', 'Sukabirus', 'Gapura', 'Other']
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                          .toList(),
                      hint: const Text('Select Location'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: DropdownButton<String>(
                      value: selectedType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedType = newValue;
                        });
                      },
                      items: ['Main Course', 'Beverage']
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                          .toList(),
                      hint: const Text('Select Type'),
                    ),
                  ),
                ],
              ),
            ),
            // Filtered Items List
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          title: item['title']!,
                          image: item['image']!,
                          location: item['location']!,
                          type: item['type']!,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Text(
                                    item['title']!,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['location'] ?? "Location unknown",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                              ),
                              Row(
                                children: [
                                  Text(
                                    item['type'] ?? "Type unknown",
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
