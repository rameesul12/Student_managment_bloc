part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class GetImageEvent extends ImageEvent {}

class RemoveImageEvent extends ImageEvent {}
