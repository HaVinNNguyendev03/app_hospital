import 'package:app_hospital/widget/CategoryDoctorWidget.dart';
import 'package:app_hospital/widget/CategoryWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app_hospital/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_hospital/services/Authservice.dart';

AuthService authService = new AuthService();

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
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
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
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    print("Disposing controller textfield");
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
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hàng trên: Avatar, Xin chào, Logout
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
                              onPressed: () {
                                authService.logout(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => myFocusNode.unfocus(),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: AppTheme.backgroundGradient,
            ),
            child: ListView(children: <Widget>[
              // thanh tim kiem
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      focusNode: myFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (query) {
                        // Xử lý logic tìm kiếm
                        print("Search query: $query");
                      },
                    ),
                  ),
                ),
              ),
              // danh muc loai bac si
              Container(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //danh muc bac si mat
                        CategoryWidget(
                          backgroundColor:
                              const Color.fromARGB(255, 21, 0, 255),
                          imagePath: 'assets/image/Mat.png',
                          text: 'Mắt',
                          textColor: Colors.white,
                        ),
                        SizedBox(width: 10),
                        //danh muc bac si tim
                        CategoryWidget(
                          backgroundColor:
                              const Color.fromARGB(255, 21, 0, 255),
                          imagePath: 'assets/image/Rang.png',
                          text: 'Răng',
                          textColor: Colors.white,
                        ),
                        SizedBox(width: 10),
                        // danh muc bac si tim
                        CategoryWidget(
                          backgroundColor:
                              const Color.fromARGB(255, 21, 0, 255),
                          imagePath: 'assets/image/Tim.png',
                          text: 'Tim',
                          textColor: Colors.white,
                        ),
                        SizedBox(width: 10),
                        //danh muc bac si than the
                        CategoryWidget(
                          backgroundColor:
                              const Color.fromARGB(255, 21, 0, 255),
                          imagePath: 'assets/image/CoThe.png',
                          text: 'Cơ Thể',
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  )),
              // danh sach bac si trong lich
              Text(
                'Danh Sách Bác Sĩ Trống Lịch',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Container(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CategoryDoctorWidget(
                            imagePath: 'assets/image/bacsi02.png',
                            textDoctor: 'Bác Sĩ Phương',
                            textSpecialty: 'Chuyên Khoa Răng',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.4,
                            containerHeight: screenHeight * 0.3,
                            topLeft: 25,
                            topRight: 25,
                            boderRadiusBox: 25,
                            boderRadiusAvt: 0,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                          SizedBox(width: 10),
                          CategoryDoctorWidget(
                            imagePath: 'assets/image/BacSi01.png',
                            textDoctor: 'Bác Sĩ Thuý',
                            textSpecialty: 'Chuyên Khoa Tim',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.4,
                            containerHeight: screenHeight * 0.3,
                            topLeft: 25,
                            topRight: 25,
                            boderRadiusBox: 25,
                            boderRadiusAvt: 0,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                          SizedBox(width: 10),
                          CategoryDoctorWidget(
                            imagePath: 'assets/image/bacsi02.png',
                            textDoctor: 'Bác Sĩ Phương',
                            textSpecialty: 'Chuyên Khoa Răng',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.4,
                            containerHeight: screenHeight * 0.3,
                            topLeft: 25,
                            topRight: 25,
                            boderRadiusBox: 25,
                             boderRadiusAvt: 0,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                          SizedBox(width: 10),
                          CategoryDoctorWidget(
                            imagePath: 'assets/image/bacsi02.png',
                            textDoctor: 'Bác Sĩ Phương',
                            textSpecialty: 'Chuyên Khoa Răng',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.4,
                            containerHeight: screenHeight * 0.3,
                            topLeft: 25,
                            topRight: 25,
                            boderRadiusBox: 25,
                             boderRadiusAvt: 0,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                        ]),
                  )),
              // danh sach bac si yeu thich
              // danh sach bac si trong lich
              Text(
                'Danh Sách Bác Sĩ Yêu Thích',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Container(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CategoryDoctorWidget(
                            imagePath: 'assets/image/avatabacsi.png',
                            textDoctor: 'Bác Sĩ Phương',
                            textSpecialty: 'Chuyên Khoa Răng',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.4,
                            containerHeight: screenHeight * 0.3,
                             topLeft: 25,
                            topRight: 25,
                            boderRadiusAvt: 0,
                            boderRadiusBox: 25,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                          SizedBox(width: 10),
                           CategoryDoctorWidget(
                            imagePath: 'assets/image/avatabacsi.png',
                            textDoctor: 'Bác Sĩ Phương',
                            textSpecialty: 'Chuyên Khoa Răng',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.4,
                            containerHeight: screenHeight * 0.3,
                             topLeft: 25,
                            topRight: 25,
                            boderRadiusAvt: 0,
                            boderRadiusBox: 25,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                          SizedBox(width: 10),
                           CategoryDoctorWidget(
                            imagePath: 'assets/image/avatabacsi.png',
                            textDoctor: 'Bác Sĩ Phương',
                            textSpecialty: 'Chuyên Khoa Răng',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.4,
                            containerHeight: screenHeight * 0.3,
                             topLeft: 25,
                            topRight: 25,
                            boderRadiusAvt: 0,
                            boderRadiusBox: 25,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                        ]),
                  ))
            ]),
          ),
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
