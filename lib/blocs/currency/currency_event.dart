
part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}

class CurrencyLoadStarted extends CurrencyEvent {}

class CurrencyLoadServer extends CurrencyEvent {
  final WooCurrency currency;

  CurrencyLoadServer(this.currency) : assert(currency != null);

  @override
  List<Object> get props => [currency];
}

class CurrencySelected extends CurrencyEvent {
  final WooCurrency currency;

  CurrencySelected(this.currency) : assert(currency != null);

  @override
  List<Object> get props => [currency];
}
