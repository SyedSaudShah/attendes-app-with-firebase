import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_dart_event.dart';
part 'image_dart_state.dart';

class ImageDartBloc extends Bloc<ImageDartEvent, ImageDartState> {
  ImageDartBloc() : super(ImageDartInitial()) {
    on<ImageEvent>((event, emit) {
      emit.call(ImageState(event.file));
    });
  }
}
