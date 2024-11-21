import 'package:flutter/material.dart';
/// {@template TextFiled}
/// TextFiled widget.
/// {@endtemplate}
class TextFieldWidget extends StatefulWidget {
  /// {@macro TextFieldWidget}
  const TextFieldWidget({
    super.key, // ignore: unused_element
    required this.textwidget,
    required this.textEditingController,
  });
  final String textwidget;
  final TextEditingController textEditingController;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}


/// State for widget TextFieldWidget.
class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode myFocusNode;
   @override
  void initState() {
    super.initState();
    print("Initializing text field");
    myFocusNode = FocusNode();
  }
    @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    print("Disposing controller textfield");
    widget.textEditingController.dispose();
    super.dispose();
  }
  @override
 Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => myFocusNode.requestFocus(),
          child: Padding(
             padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: TextField(
              controller: widget.textEditingController,
              focusNode: myFocusNode,
              decoration: InputDecoration(
                contentPadding : const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                labelText: widget.textwidget,
                labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 255, 242, 67),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
