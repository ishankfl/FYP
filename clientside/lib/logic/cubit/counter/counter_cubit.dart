import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:bookme/logic/bloc_export.dart';

class StoreImageCubit extends Cubit<ImageStorage> {
  StoreImageCubit() : super(ImageStorage());
  void addition({required File image}) => emit(ImageStorage(image: image));

  void clear() => emit(ImageStorage());
}

class CertificateStoreImageCubit extends Cubit<CertificateImageStorage> {
  CertificateStoreImageCubit() : super(CertificateImageStorage());
  void addition({required File image}) =>
      emit(CertificateImageStorage(image: image));
}
