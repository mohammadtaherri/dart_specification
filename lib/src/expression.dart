import 'predicate.dart';

PredicateExpressionSpecification expr(Predicate predicate) {
  return PredicateExpressionSpecification(predicate);
}

class PredicateExpressionSpecification<T> extends PredicateSpecification<T> {
  PredicateExpressionSpecification(Predicate<T> predicate) : super(predicate);

  bool call(T candidate) => isSatisfiedBy(candidate);
}
