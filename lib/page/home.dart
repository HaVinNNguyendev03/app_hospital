import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app_hospital/theme.dart';
import 'package:flutter/material.dart';

/// {@template home}
/// Home widget.
/// {@endtemplate}
class Home extends StatefulWidget {
  /// {@macro home}
  const Home({
    super.key, // ignore: unused_element
  });

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _HomeState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_HomeState>();

  @override
  State<Home> createState() => _HomeState();
}

/// State for widget Home.
class _HomeState extends State<Home> {
  /* #region Lifecycle */

  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }

  /* #endregion */
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    print(appBarHeight);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final Map<String, dynamic> userData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        gradient: AppTheme.backgroundGradient,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // Chiều cao của AppBar
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              actions: [
                Container(
                  height: appBarHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: screenWidth,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screenWidth * 0.15,
                        height: appBarHeight * 0.8,
                        decoration: BoxDecoration(
                          color: Colors
                              .blueAccent, // Chỉ hiển thị màu nền khi item được chọn
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 30.0,
                          alignment: Alignment.topCenter,
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text('Xin Chào: ${userData['name']}'),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            gradient: AppTheme.backgroundGradient,
          ),
          child: ListView(children: <Widget>[
            Text('Name: ${userData['name']}'),
            Text('Email: ${userData['email']}'),
            Text('Trang Home'),
          ]),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: _buildIcon(Icons.home, 0),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(Icons.favorite, 1),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(Icons.book, 2),
                  label: 'Book',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(Icons.person, 3),
                  label: 'User',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex =
                      index; // Cập nhật chỉ mục khi người dùng chọn mục mới
                });
              }),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index) {
    bool isSelected = _selectedIndex == index;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blueAccent
            : Colors.white, // Chỉ hiển thị màu nền khi item được chọn
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: isSelected ? Colors.white : Colors.grey),
    );
  }
}
// function
