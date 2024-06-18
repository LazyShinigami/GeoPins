import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geopins/models/location.dart';
import 'package:geopins/widgets/commons.dart';
import 'package:image_picker/image_picker.dart';

class AddLocationDialog extends StatefulWidget {
  const AddLocationDialog({super.key});

  @override
  State<AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<AddLocationDialog> {
  double popupBorderRadius = 15;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  bool hasError = false;
  String hasChosenLocation = '';
  List<File?> imageList = [];

  Map locationToSave = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(popupBorderRadius),
      ),
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(popupBorderRadius),
                  topRight: Radius.circular(popupBorderRadius),
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/appBarBg.avif'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 60,
              child: Center(
                child: MyText(
                  'Add New Location',
                  size: 22,
                  color: Colors.white,
                  weight: FontWeight.bold,
                  spacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
      content: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextField(
                controller: _nameController,
                label: 'Name',
                hint: 'Enter Name',
                color: (hasError) ? Colors.red : Colors.grey,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _addressController,
                label: 'Address (optional)',
                hint: 'Enter Address',
                maxLines: 3,
                maxLength: 100,
              ),
              const SizedBox(height: 20),

              // Location Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  locationPickerButtonBuilder(option: 'Current Location'),
                  locationPickerButtonBuilder(option: 'Select On Map'),
                ],
              ),
              const SizedBox(height: 20),

              // Image Picker
              // title
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Divider(
                        color: Color.fromARGB(255, 207, 207, 207),
                        thickness: 2,
                      ),
                    ),
                  ),
                  MyText(
                    'Add Images (optional, upto 4)',
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Divider(
                        color: Color.fromARGB(255, 207, 207, 207),
                        thickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
              // buttons
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  imagePickerButtonBuilder(option: 'Camera'),
                  imagePickerButtonBuilder(option: 'Gallery'),
                ],
              ),

              // Image preview boxes
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: (imageList.length == 1)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  if (imageList.isNotEmpty)
                    for (int i = 0; i < imageList.length; i++)
                      imagePreviewBoxBuilder(imageList[i],
                          index: i), // index i to change a specific image

                  // imagePreviewBoxBuilder(),
                  // imagePreviewBoxBuilder(),
                  // imagePreviewBoxBuilder(),
                  // imagePreviewBoxBuilder(),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            setState(() {
              // Change this condition to your validation logic
              hasError = _nameController.text.isEmpty;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: AssetImage('assets/tileBg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: MyText(
              'Submit',
              color: Colors.white,
              weight: FontWeight.w600,
              spacing: 1,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: MyText(
              'Cancel',
              color: Colors.red,
              weight: FontWeight.w600,
              spacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget imagePreviewBoxBuilder(File? file, {required int index}) {
    double imagePreviewBoxSize = MediaQuery.of(context).size.width * 0.15;
    return GestureDetector(
      onTap: () async {
        print(index);
        var x = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (x != null) {
          File temp = File(x.path);
          imageList[index] = temp;
          setState(() {});
        } else {
          print('No file chosen!');
        }
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: imagePreviewBoxSize,
        width: imagePreviewBoxSize,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.file(
          file!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  imagePickerButtonBuilder({required String option}) {
    Icon icon = (option == 'Camera')
        ? const Icon(
            Icons.camera_alt_rounded,
            color: Colors.white,
          )
        : const Icon(
            Icons.photo_size_select_actual_rounded,
            color: Colors.white,
          );
    MyText optionTitle = MyText(
      option,
      color: Colors.white,
      weight: FontWeight.w600,
      size: 14,
      spacing: 1,
    );
    ImageSource source =
        (option == 'Camera') ? ImageSource.camera : ImageSource.gallery;

    return GestureDetector(
      onTap: () {
        print('$option button pressed');
        if (imageList.length < 4) {
          imagePickerFunction(source);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.5),
          image: const DecorationImage(
            image: AssetImage('assets/appBarBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 5),
            optionTitle,
          ],
        ),
      ),
    );
  }

  imagePickerFunction(ImageSource source) async {
    if (source == ImageSource.gallery) {
      var x = await ImagePicker().pickMultiImage(requestFullMetadata: false);
      if (x.isNotEmpty) {
        for (var i = 0; i < x.length; i++) {
          if (imageList.length < 4) {
            print('------------------->> $i');
            File temp = File(x[i].path);
            imageList.add(temp);
            setState(() {});
          }
        }
      } else {
        print('No file chosen!');
      }
    } else {
      var x = await ImagePicker().pickImage(source: source);
      if (x != null) {
        File temp = File(x.path);
        imageList.add(temp);
        setState(() {});
      } else {
        print('No file chosen!');
      }
    }
  }

  locationPickerButtonBuilder({required String option}) {
    Map? locationParameters;
    Widget icon = (option == 'Current Location' && hasChosenLocation.isEmpty)
        ? Image.asset(
            'assets/pin.png',
            color: Colors.white,
            height: 20,
            width: 20,
          )
        : Image.asset(
            'assets/crosshair.png',
            color: Colors.grey,
            height: 20,
          );
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            print("yooo");
            locationParameters = await LocationService().getCurrentLocation();

            if (locationParameters != null) {
              locationToSave = locationParameters!;
              hasChosenLocation = option;
              print('Location to save: $locationToSave');
              setState(() {});
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: (option == 'Current Location')
                  ? const DecorationImage(
                      image: AssetImage('assets/appBarBg.png'),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: (option != 'Current Location')
                  ? const Color.fromARGB(82, 158, 158, 158)
                  : null,
            ),
            child: Center(
              child: (hasChosenLocation != option)
                  ? icon
                  : const Icon(Icons.done_rounded,
                      color: Colors.white, size: 30),
            ),
          ),
        ),
        const SizedBox(height: 5),
        MyText(
          option,
          size: 12,
          color: const Color(0xFF787878),
          spacing: 0.5,
        ),
      ],
    );
  }
}
