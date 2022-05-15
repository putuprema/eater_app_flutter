import 'dart:async';

import 'package:eater_app_flutter/models/featured_products_header.dart';
import 'package:eater_app_flutter/models/product_category.dart';
import 'package:eater_app_flutter/services/product_service.dart';
import 'package:eater_app_flutter/widgets/featured_product_head.dart';
import 'package:eater_app_flutter/widgets/skeletons/featured_products_skeleton.dart';
import 'package:eater_app_flutter/widgets/skeletons/tabs_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _productService = GetIt.I.get<ProductService>();
  final _productScrollController = ItemScrollController();
  final _productPositionListener = ItemPositionsListener.create();
  final _productFirstPosStreamCtrl = StreamController<ItemPosition>();

  bool _tabTapped = false;
  StreamSubscription? _productFirstPosUpdtSubscription;
  TabController? _tabController;
  Timer? _setTabTappedFalseTimer;

  @override
  void initState() {
    super.initState();

    _productPositionListener.itemPositions.addListener(() {
      final itemPositions = _productPositionListener.itemPositions.value;

      final nextVisibleItems = itemPositions.where(
        (i) => i.itemLeadingEdge >= 0 && i.itemLeadingEdge <= 0.1,
      );

      if (nextVisibleItems.isNotEmpty) {
        final first = nextVisibleItems.first;
        _productFirstPosStreamCtrl.add(first);
      }
    });

    _productFirstPosUpdtSubscription = _productFirstPosStreamCtrl.stream
        .distinct((prev, next) => prev.index == next.index)
        .listen(
      (item) {
        if (!_tabTapped) {
          _tabController?.animateTo(item.index);
        }
      },
    );
  }

  void _initializeTabController(int tabCount) {
    final newTabController = TabController(
      length: tabCount,
      vsync: this,
      animationDuration: const Duration(milliseconds: 500),
    );

    newTabController.addListener(() {
      if (newTabController.indexIsChanging) {
        _setTabTappedFalseTimer?.cancel();
      } else {
        _setTabTappedFalseTimer = Timer(
          const Duration(milliseconds: 500),
          () {
            _tabTapped = false;
          },
        );
      }
    });

    _tabController?.dispose();
    _tabController = newTabController;
  }

  void _onTabBarTap(int index) async {
    _tabTapped = true;
    _tabController?.index = index;

    _productScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: SvgPicture.asset(
          'assets/eater-logo-full.svg',
          height: 30,
        ),
        leading: TextButton(onPressed: () {}, child: const Icon(Icons.menu)),
        centerTitle: true,
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: FutureBuilder<List<ProductCategory>>(
            future: _productService.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.requireData;

                // Initialize tab controller and the required listeners
                _initializeTabController(data.length);

                return TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColor,
                  isScrollable: true,
                  onTap: _onTabBarTap,
                  tabs: data.map((e) => Tab(text: e.name)).toList(),
                );
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const TabsSkeleton(),
              );
            },
          ),
        ),
      ),
      body: FutureBuilder<List<FeaturedProductsHeader>>(
        future: _productService.getFeaturedProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            if (data.isNotEmpty) {
              return ScrollablePositionedList.separated(
                itemScrollController: _productScrollController,
                itemPositionsListener: _productPositionListener,
                padding: const EdgeInsets.only(
                  bottom: 60,
                  top: 4,
                  left: 16,
                  right: 16,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) => FeaturedProductHead(
                  data: data[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'No menu available!',
                  )
                ],
              ),
            );
          }

          return const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: FeaturedProductsSkeleton(),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _toggleShowTabs,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  @override
  void dispose() async {
    _setTabTappedFalseTimer?.cancel();
    await _productFirstPosUpdtSubscription?.cancel();
    await _productFirstPosStreamCtrl.close();

    super.dispose();
  }
}
