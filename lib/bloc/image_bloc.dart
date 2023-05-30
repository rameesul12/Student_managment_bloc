import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<GetImageEvent>(((event, emit) async {
      emit(ImageLoadingState());
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(ImageLoadedState(File(pickedFile.path)));
      } else {
        emit(ImageErrorState('No Image Selected'));
      }
    }));
    on<RemoveImageEvent>(
      (event, emit) async {
        emit(ImageInitial());
      },
    );
  }
}
