enum PostPageStatus { loading, fail, success }

class MainPageState {
  final int? currentPage;
  final PostPageStatus? pageStatus;
  final String? adminId;
  const MainPageState({
    this.currentPage = 0,
    this.adminId,
    this.pageStatus = PostPageStatus.loading,
  });

  MainPageState copyWith({
    String? adminId,
    int? currentPage,
    PostPageStatus? pageStatus,
  }) {
    return MainPageState(
      adminId: adminId ?? this.adminId,
      pageStatus: pageStatus ?? this.pageStatus,

      currentPage: currentPage ?? this.currentPage,
    );
  }
}
