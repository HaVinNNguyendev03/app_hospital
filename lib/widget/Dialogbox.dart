import 'package:app_hospital/widget/TextFiled.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:app_hospital/widget/Buttonwidget.dart';

class Dialogbox extends StatefulWidget {
  const Dialogbox(
      {super.key,
      required this.title,
      required this.labeltext,
      required this.content,
      required this.screenHeight,
      required this.screenWidth});
  final String title;
  final String labeltext;
  final String content;
  final double screenHeight;
  final double screenWidth;
  @override
  State<Dialogbox> createState() => _DialogboxState();
}

class _DialogboxState extends State<Dialogbox> {
  final TextEditingController _emailController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.screenWidth); 
    print(widget.screenHeight);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); 
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
           padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
          child:
             Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.content,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(textwidget: "Email",textEditingController: _emailController,),
                Container(
                  width: widget.screenWidth * 0.9,
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Buttonwidget(
                          onPressed: () {},
                          paddinghorizontal: widget.screenWidth * 0.05,
                          paddingvertical: widget.screenHeight * 0.015,
                          textbutton: "Cancel",
                        ),
                        Buttonwidget(
                          onPressed: () {},
                          paddinghorizontal: widget.screenWidth * 0.05,
                          paddingvertical: widget.screenHeight * 0.015,
                          textbutton: "Send",
                        ),
                      ]),
                )
              ],
            ),
          ],
        ),
          
        )
       
      ),
    );
  }
}
