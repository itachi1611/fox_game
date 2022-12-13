abstract class CoordinateRepositories {
  get y;
  get xs;
}

class CoordinateRepositoriesImpl extends CoordinateRepositories {
  final int? _y;
  final List<int>? _xs;

  CoordinateRepositoriesImpl(this._y, this._xs);

  @override
  get y => _y;
  
  @override
  get xs => _xs;
}