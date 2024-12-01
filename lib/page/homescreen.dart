import 'package:app_hospital/widget/FavoriteDoctorWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app_hospital/widget/CategoryDoctorWidget.dart';
import 'package:app_hospital/widget/CategoryWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app_hospital/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_hospital/services/Authservice.dart';

/// {@template homescreen}
/// Homescreen widget.
/// {@endtemplate}
class Homescreen extends StatefulWidget {
  /// {@macro homescreen}
  const Homescreen({
    super.key, // ignore: unused_element
  });
  
  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _HomescreenState? maybeOf(BuildContext context) =>
    context.findAncestorStateOfType<_HomescreenState>();
  
  @override
  State<Homescreen> createState() => _HomescreenState();
}


/// State for widget Homescreen.
  class _HomescreenState extends State<Homescreen> {
  // khai báo 
  late FocusNode myFocusNode;
  /* #region Lifecycle */
  @override
  //khởi tạo
  void initState() {
    super.initState();
     myFocusNode = FocusNode();
    // Initial state initialization
  }
  
  @override
  void didUpdateWidget(covariant Homescreen oldWidget) {
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
  // hủy 
  void dispose() {
    // Permanent removal of a tree stent
    myFocusNode.dispose();
     print("Disposing controller textfield");
    super.dispose();
  }
  /* #endregion */
  
  @override
  Widget build(BuildContext context) {
    // khoi tao cac thuoc tinh
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
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
                          FavoriteDoctorWidget(
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
                            FavoriteDoctorWidget(
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
                          FavoriteDoctorWidget(
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
                           
                          )
                        ]),
                  ))
            ]),
          ),
        );
  }
}
