part of 'image_dart_bloc.dart';

@immutable
abstract class ImageDartEvent {}

class ImageEvent extends ImageDartEvent{
  File file;
  ImageEvent({required this.file});
}
