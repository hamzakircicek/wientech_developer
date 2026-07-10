enum PostPageStatus { loading, fail, success }

class MainPageState {
  final int? currentPage;
  final PostPageStatus? pageStatus;
  const MainPageState({
    this.currentPage = 0,
    this.pageStatus = PostPageStatus.loading,
  });

  MainPageState copyWith({int? currentPage, PostPageStatus? pageStatus}) {
    return MainPageState(
      pageStatus: pageStatus ?? this.pageStatus,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
