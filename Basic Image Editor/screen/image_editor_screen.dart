import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor/widgets/edit_image_viewModel.dart';
import 'package:image_editor/widgets/image_text.dart';
import 'package:screenshot/screenshot.dart';

class ImageEditorScreen extends StatefulWidget {
  final String selectedImage;
  const ImageEditorScreen({super.key, required this.selectedImage});
  @override
  State<ImageEditorScreen> createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends EditImageViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SafeArea(
        child: Screenshot(
          controller: screenshotController,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: <Widget>[
                _selectedImage,
                for (int i = 0; i < texts.length; i++)
                  Positioned(
                    top: texts[i].top,
                    left: texts[i].left,
                    child: GestureDetector(
                      onLongPress: () {
                        deleteText(context, i);
                      },
                      onTap: () => selectForStyling(context, i),
                      child: Draggable(
                        feedback: ImageText(text: texts[i]),
                        child: ImageText(text: texts[i]),
                        onDragEnd: (drag) {
                          final renderbox =
                              context.findRenderObject() as RenderBox;
                          Offset off = renderbox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy - 35;
                            texts[i].left = off.dx;
                          });
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _floatingActionButton,
    );
  }

  Widget get _selectedImage => Center(
        child: Image.file(
          File(widget.selectedImage),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );
  Widget get _floatingActionButton => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        child: const Icon(Icons.edit),
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  saveImageToGallery(context);
                },
                icon: const Icon(Icons.save),
                tooltip: "Save",
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {
                  increaseFontSize();
                },
                icon: const Icon(Icons.add),
                color: Colors.black,
                tooltip: "Increase Font Size",
              ),
              IconButton(
                onPressed: () {
                  decreaseFontSize();
                },
                icon: const Icon(Icons.remove),
                color: Colors.black,
                tooltip: "Decrease Font Size",
              ),
              IconButton(
                onPressed: () {
                  alignLeft();
                },
                icon: const Icon(Icons.format_align_left),
                color: Colors.black,
                tooltip: "Align Left",
              ),
              IconButton(
                onPressed: () {
                  alignCenter();
                },
                icon: const Icon(Icons.format_align_center),
                color: Colors.black,
                tooltip: "Align Center",
              ),
              IconButton(
                onPressed: () {
                  alignRight();
                },
                icon: const Icon(Icons.format_align_right),
                color: Colors.black,
                tooltip: "Align Right",
              ),
              IconButton(
                onPressed: () {
                  fontBold();
                },
                icon: const Icon(Icons.format_bold),
                color: Colors.black,
                tooltip: "Bold",
              ),
              IconButton(
                onPressed: () {
                  fontItalic();
                },
                icon: const Icon(Icons.format_italic),
                color: Colors.black,
                tooltip: "Italic",
              ),
              IconButton(
                onPressed: () {
                  lineBreak();
                },
                icon: const Icon(Icons.space_bar),
                color: Colors.black,
                tooltip: "Add new line",
              ),
              const SizedBox(
                width: 10,
              ),
              // Color Changing Section
              Tooltip(
                message: "Green",
                child: GestureDetector(
                  onTap: () {
                    changeColor(Colors.green);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "White",
                child: GestureDetector(
                  onTap: () {
                    changeColor(Colors.white);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Pink",
                child: GestureDetector(
                  onTap: () {
                    changeColor(Colors.pink);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Yellow",
                child: GestureDetector(
                  onTap: () {
                    changeColor(Colors.yellow);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Black",
                child: GestureDetector(
                  onTap: () {
                    changeColor(Colors.black);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Red",
                child: GestureDetector(
                  onTap: () {
                    changeColor(Colors.red);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: "Blue",
                child: GestureDetector(
                  onTap: () {
                    changeColor(Colors.blue);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      );
}

