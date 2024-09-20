import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editor/screen/image_editor_screen.dart';
import 'package:image_editor/widgets/default_button.dart';
import 'package:image_editor/models/textInfo.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_editor/utilis/utilis.dart';

abstract class EditImageViewmodel extends State<ImageEditorScreen> {
  List<Textinfo> texts = [];
  TextEditingController textEditingController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  int currentIndex = 0;

  saveImageToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
      }).catchError((err) => print(err));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(",", "-")
        .replaceAll(":", "-");
    final name = "ScreenShort $time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(name: name, bytes);
  }

  selectForStyling(context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Selected for styling"),
      ),
    );
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontsize = texts[currentIndex].fontsize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontsize = texts[currentIndex].fontsize -= 2;
    });
  }

  changeColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  fontBold() {
    setState(() {
      texts[currentIndex].fontWeight = FontWeight.bold;
    });
  }

  fontItalic() {
    setState(() {
      texts[currentIndex].fontStyle = FontStyle.italic;
    });
  }

  lineBreak() {
    setState(() {
      texts[currentIndex].text = texts[currentIndex].text.replaceAll(" ", "\n");
    });
  }

  deleteText(context, index) {
    setState(() {
      texts.removeAt(index);
    });
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(Textinfo(
          text: textEditingController.text,
          left: 0,
          top: 0,
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontsize: 20,
          textAlign: TextAlign.center));
    });
    Navigator.of(context).pop();
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Please Write Text"),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: "Please write text here",
            suffixIcon: Icon(Icons.edit),
          ),
        ),
        actions: [
          DefaultButton(
            onPressed: () => addNewText(context),
            textcolor: Colors.white,
            backgroundColor: Colors.red,
            child: const Text("Add Text"),
          ),
          DefaultButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textcolor: Colors.black,
            backgroundColor: Colors.white,
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}





















