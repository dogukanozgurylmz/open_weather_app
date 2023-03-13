abstract class BaseRepository<TModel> {
  Future<TModel?> fetchData(String api);
}
