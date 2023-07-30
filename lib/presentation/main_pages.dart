import 'package:digifest/presentation/pages/home_pages.dart';
import 'package:digifest/presentation/pages/transact_pages.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class MainPages extends StatefulWidget {
  const MainPages({Key? key}) : super(key: key);

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int currentIndex = 0;
  final screens = [
    const HomePages(),
    const Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadIndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: Colors.deepPurple,
          selectedItemColor: Colors.white,
          enableFeedback: false,
          unselectedItemColor: Colors.black38,
          showUnselectedLabels: false,
          // type: BottomNavigationBarType.fixed,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Statistik',
            )
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactPages(),
              ),
            ),
            // label: Text(''),
            child: const Icon(
              Icons.add,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
