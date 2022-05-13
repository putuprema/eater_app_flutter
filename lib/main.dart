import 'package:eater_app_flutter/pallete.dart';
import 'package:eater_app_flutter/widgets/product_card.dart';
import 'package:eater_app_flutter/widgets/skeleton_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const EaterApp());
}

class EaterApp extends StatelessWidget {
  const EaterApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eater',
      theme: ThemeData(
        primarySwatch: Pallete.eaterPrimary,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool _showTabs = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  void _toggleShowTabs() {
    setState(() {
      _showTabs = !_showTabs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        title: SvgPicture.asset(
          'assets/eater-logo-full.svg',
          height: 30,
        ),
        leading: TextButton(onPressed: () {}, child: const Icon(Icons.menu)),
        centerTitle: true,
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        bottom: _showTabs
            ? TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).primaryColor,
                isScrollable: true,
                tabs: const <Widget>[
                  Tab(text: "Nasi Goreng"),
                  Tab(text: "Sop"),
                  Tab(text: "Minuman"),
                  Tab(text: "Makanan"),
                  Tab(text: "Buah"),
                  Tab(text: "Sayuran"),
                  Tab(text: "Dessert"),
                  Tab(text: "Appetizer"),
                ],
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const SkeletonTabs(),
                ),
              ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: LayoutGrid(
                columnSizes: [1.fr, 1.fr],
                rowSizes: const [auto, auto, auto],
                rowGap: 8,
                columnGap: 8,
                children: const [
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: const <Widget>[
      //       Text(
      //         'No menu available!',
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleShowTabs,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
