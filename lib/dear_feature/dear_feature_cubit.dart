import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/dear_feature/dear_feature_state.dart';

class DearFeatureCubit extends Cubit<DearFeatureState> {
  DearFeatureCubit() : super(DearFeatureDisabledState());

  void activateFeature() {
    emit(DearFeatureEnabledState());
  }

  void deactivateFeature() {
    emit(DearFeatureDisabledState());
  }
}
