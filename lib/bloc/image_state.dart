part of 'image_bloc.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoadingState extends ImageState {}

class ImageLoadedState extends ImageState {
  final File imageFile;

  ImageLoadedState(this.imageFile);
}

class ImageErrorState extends ImageState {
  final String errorMessage;

  ImageErrorState(this.errorMessage);
}
