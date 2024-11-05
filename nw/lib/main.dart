import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nw/bloc/news_bloc.dart';
import 'package:nw/pages/home_page.dart';
import 'package:nw/pages/setting.dart';
import 'package:nw/pages/splash_screen.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NewsBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Times Of India',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const SettingsPage(),
  ];

  void _onNavigationBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 180, 47, 37),
        title: const Center(
          child: Text(
            'Times Of India',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              //backgroundColor: Colors.white,
              radius: 20,
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      // appBar: AppBar(
      //   title: const Center(
      //     child: Text(
      //       "Time of India",
      //       style: TextStyle(
      //           color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.person),
      //       onPressed: () {
      //         // Handle user icon tap
      //       },
      //     ),
      //   ],
      //   backgroundColor: Colors.black,
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavigationBarItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'News',
          ),
        ],
      ),
    );
  }
}
