import 'package:flutter/material.dart';
import 'package:participa/presentation/pages/home/home_view.dart';
import 'package:participa/presentation/pages/news/news_page.dart';
import 'package:participa/presentation/pages/pauta/pauta_page.dart';
import 'package:participa/presentation/pages/transmission/transmission_page.dart';
import 'package:participa/presentation/pages/voting/voting_page.dart';
import 'package:participa/presentation/widgets/custom_navigation_bar/navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomeView(
        onNavigate: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      const NewsPage(),
      const VotingPage(),
      const TransmissionPage(),
      const PautaPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCenterButtonTap() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onCenterButtonTap: _onCenterButtonTap,
      ),
      floatingActionButton: centerButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  SizedBox centerButton(BuildContext context) {
    return SizedBox(
      width: _selectedIndex == 2 ? 90 : 80,
      height: _selectedIndex == 2 ? 90 : 80,
      child: FloatingActionButton(
        onPressed: _onCenterButtonTap,
        backgroundColor: Theme.of(context).colorScheme.primary,

        elevation: 2,
        shape: const CircleBorder(),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.how_to_vote,
              size: _selectedIndex == 2 ? 36 : 32,
              color: _selectedIndex == 2 ? Colors.white : Colors.white70,
            ),
            const SizedBox(height: 4),
            Text(
              "Votação",
              style: TextStyle(
                fontSize: 12,
                fontWeight: _selectedIndex == 2
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
