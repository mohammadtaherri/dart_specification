import 'composite.dart';

typedef Predicate<T> = bool Function(T condidate);

class PredicateSpecification<T> extends CompositeSpecification<T> {
  final Predicate<T> _predicate;
  PredicateSpecification(this._predicate);

  @override
  bool isSatisfiedBy(T candidate) => _predicate(candidate);

  @override
  int get hashCode => _predicate.hashCode;

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! PredicateSpecification<T>) return false;
    return _predicate == other._predicate;
  }
}
