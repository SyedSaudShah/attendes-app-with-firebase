part of 'image_dart_bloc.dart';

@immutable
abstract class ImageDartState {}

class ImageDartInitial extends ImageDartState {}

class ImageState extends ImageDartState{
  File file;
  ImageState(this.file);
}
