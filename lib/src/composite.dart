import 'core.dart';

abstract class ICompositeSpecification<T> extends ISpecification<T> {
  ICompositeSpecification<T> and(ICompositeSpecification<T> other);
  ICompositeSpecification<T> or(ICompositeSpecification<T> other);
  ICompositeSpecification<T> xor(ICompositeSpecification<T> other);
  ICompositeSpecification<T> not();

  ICompositeSpecification<T> operator &(ICompositeSpecification<T> other);
  ICompositeSpecification<T> operator |(ICompositeSpecification<T> other);
  ICompositeSpecification<T> operator ^(ICompositeSpecification<T> other);
  ICompositeSpecification<T> operator ~();
}

abstract class CompositeSpecification<T> extends ICompositeSpecification<T> {
  @override
  bool isSatisfiedBy(T candidate);

  @override
  ICompositeSpecification<T> and(ICompositeSpecification<T> other) =>
      AndSpecification([this, other]);
  @override
  ICompositeSpecification<T> or(ICompositeSpecification<T> other) =>
      OrSpecification([this, other]);
  @override
  ICompositeSpecification<T> not() => NotSpecification(this);
  @override
  ICompositeSpecification<T> xor(ICompositeSpecification<T> other) =>
      (this | other) & ~(this & other);

  @override
  ICompositeSpecification<T> operator &(ICompositeSpecification<T> other) =>
      and(other);
  @override
  ICompositeSpecification<T> operator |(ICompositeSpecification<T> other) =>
      or(other);
  @override
  ICompositeSpecification<T> operator ^(ICompositeSpecification<T> other) =>
      xor(other);
  @override
  ICompositeSpecification<T> operator ~() => not();
}

class AndSpecification<T> extends CompositeSpecification<T> {
  final Iterable<ICompositeSpecification<T>> specs;
  AndSpecification(this.specs);

  @override
  bool isSatisfiedBy(T candidate) =>
      specs.every((spec) => spec.isSatisfiedBy(candidate));
}

class OrSpecification<T> extends CompositeSpecification<T> {
  final Iterable<ICompositeSpecification<T>> _specs;
  OrSpecification(this._specs);

  @override
  bool isSatisfiedBy(T candidate) =>
      _specs.any((spec) => spec.isSatisfiedBy(candidate));
}

class NotSpecification<T> extends CompositeSpecification<T> {
  final ICompositeSpecification<T> _spec;
  NotSpecification(this._spec);

  @override
  bool isSatisfiedBy(T candidate) => !_spec.isSatisfiedBy(candidate);
}
