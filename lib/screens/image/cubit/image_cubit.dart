import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/const/text.dart';
import 'package:noteapp/screens/image/model/image_model.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());
  final imageCtrl = TextEditingController();

  List<ImageModel> images = [];

  Future<String?> pickerCamera() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.camera);
      emit(PickImageSuccess());
      return image!.path;
    } on Exception {
      emit(PickImageFailure());
      return null;
    }
  }

  Future<String?> pickerGallery() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      emit(PickImageSuccess());
      return image!.path;
    } catch (e) {
      emit(PickImageFailure());
      return null;
    }
  }

  void addImage(ImageModel image) {
    try {
      var imageBox = Hive.box<ImageModel>(kImageBox);
      imageBox.add(image);
      imageCtrl.clear();
      fetchImages();
    } on Exception {
      emit(AddImageFailure());
    }
  }

  void deleteImage(ImageModel image) {
    image.delete();
    fetchImages();
  }

  void editImage(
      {required String imagePath,
      required String imageName,
      required ImageModel image}) {
    try {
      image.name = imageName;
      image.path = imagePath;
      image.save();
      imageCtrl.clear();
      emit(EditImageSuccess());
      fetchImages();
      emit(ImageInitial());
    } on Exception {
      emit(EditImageFailure());
    }
  }

  void editImageName({required ImageModel image}) {
    try {
      image.name = imageCtrl.text;
      image.save();
      imageCtrl.clear();
      emit(EditImageSuccess());
      fetchImages();
      emit(ImageInitial());
    } on Exception {
      emit(EditImageFailure());
    }
  }

  void fetchImages() {
    images.clear();
    var imageBox = Hive.box<ImageModel>(kImageBox);
    images.addAll(imageBox.values.toList());
    emit(ImageInitial());
  }
}
