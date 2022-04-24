abstract class MainFolderState{}

class MainFolderLoadingState extends MainFolderState{}

class MainFolderLoadedState extends MainFolderState{}

class MainFolderEmptyState extends MainFolderState{}

class MainFolderErrorState extends MainFolderState{
  String error;


  MainFolderErrorState({required this.error});
}

