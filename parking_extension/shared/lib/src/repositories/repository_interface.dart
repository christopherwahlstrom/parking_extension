abstract interface class RepositoryInterface<T> {
  Future<T> create(T vehicle);
  Future<List<T>> getAll();
  Future<T?> getById(String id);
  Future<T> update(String id, T vehicle);
  Future<T> delete(String id);
}
