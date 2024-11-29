import 'package:app_hospital/widget/RatingDetail.dart';
import 'package:app_hospital/widget/RatingDoctorWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app_hospital/widget/CategoryDoctorWidget.dart';
import 'package:app_hospital/widget/CategoryWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app_hospital/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_hospital/services/Authservice.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

/// {@template favoriteScreen}
/// FavoriteScreen widget.
/// {@endtemplate}
class FavoriteScreen extends StatefulWidget {
  /// {@macro favoriteScreen}
  const FavoriteScreen({
    super.key, // ignore: unused_element
  });
  
  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _FavoriteScreenState? maybeOf(BuildContext context) =>
    context.findAncestorStateOfType<_FavoriteScreenState>();
  
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}


/// State for widget FavoriteScreen.
class _FavoriteScreenState extends State<FavoriteScreen> {
  // khai bao con tro focus cua textbox
   late FocusNode myFocusNode;
  /* #region Lifecycle */
  @override
  void initState() {
      //khoi tao con tro focus
    myFocusNode = FocusNode();
    super.initState();
  }
  
  @override
  void didUpdateWidget(covariant FavoriteScreen oldWidget) {
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
    // huy con tro textbox
    myFocusNode.dispose();
    super.dispose();
  }
  /* #endregion */
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double screenWidth  = MediaQuery.of(context).size.width;
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
              Text(
                'Danh Sách Bác Sĩ Y Khoa',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Container(
                  child: SingleChildScrollView(
                  
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingDoctorWidget(
                            imagePath: 'assets/image/avatabacsi2.png',
                            textDoctor: 'Bác Sĩ Cường',
                            textSpecialty: 'Chuyên Khoa Thần Kinh',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                           containerWidth: screenWidth * 0.84,
                            containerHeight: screenHeight * 0.22,
                            topLeft: 0,
                            topRight: 0,
                            boderRadiusAvt: 0,
                            boderRadiusBox: 10,
                            rating: 3,
                            expyear: '15 năm',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          RatingDoctorWidget(
                            imagePath: 'assets/image/avatabacsi.png',
                            textDoctor: 'Bác Sĩ Hùng',
                            textSpecialty: 'Chuyên Khoa Răng-Hàm-Mặt',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.84,
                            containerHeight: screenHeight * 0.22,
                             topLeft: 0,
                            topRight: 0,
                            boderRadiusAvt: 0,
                            boderRadiusBox: 10,
                            rating: 3,
                            expyear: '6 năm',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          RatingDoctorWidget(
                            imagePath: 'assets/image/BacSi01.png',
                            textDoctor: 'Bác Sĩ Nữ',
                            textSpecialty: 'Chuyên Khoa Tim Mạch',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.84,
                            containerHeight: screenHeight * 0.22,
                            topLeft: 0,
                            topRight: 0,
                            boderRadiusAvt: 0,
                            boderRadiusBox: 10,
                            rating: 3,
                            expyear: '3 năm',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          RatingDoctorWidget(
                            imagePath: 'assets/image/bacsi02.png',
                            textDoctor: 'Bác Sĩ Phượng',
                            textSpecialty: 'Chuyên Khoa Thân Thể',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.84,
                            containerHeight: screenHeight * 0.22,
                             topLeft: 0,
                            topRight: 0,
                            boderRadiusAvt: 0,
                            boderRadiusBox: 10,
                            rating: 3,
                            expyear: '2 năm',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetail',
                              );
                            },
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          RatingDoctorWidget(
                            imagePath: 'assets/image/avatabacsi2.png',
                            textDoctor: 'Bác Sĩ Quang',
                            textSpecialty: 'Chuyên Khoa Mắt',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            containerWidth: screenWidth * 0.84,
                            containerHeight: screenHeight * 0.22,
                             topLeft: 0,
                            topRight: 0,
                            boderRadiusAvt: 0,
                            boderRadiusBox: 10,
                            rating: 3,
                            expyear: '10 năm',
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
        );
  }
}
