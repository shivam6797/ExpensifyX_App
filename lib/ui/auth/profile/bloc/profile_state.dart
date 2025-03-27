abstract class ProfileState{}

class ProfileInitialState extends ProfileState{}
class ProfileLoadingState extends ProfileState{}
class ProfileSuccessState extends ProfileState{}
class ProfileFailureState extends ProfileState{
  final String errorMsg;
  ProfileFailureState({required this.errorMsg});
}