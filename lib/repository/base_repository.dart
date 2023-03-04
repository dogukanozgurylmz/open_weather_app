abstract class BaseRepository<TModel> {
  Future<TModel?> fetchData();
}
