unit Impl.Types;

interface

uses
  System.Generics.Collections;

type
  TSymbol = string;
  TState = string;
  TWord = string;
  TResult = Boolean;
  TMessage = string;
  TValidationResult = TPair<TResult, TMessage>;

const
  Lambda: TSymbol = 'ʎ';
  ResultMessage: array[TResult] of TMessage = ('Rejected', 'Accepted');

implementation

end.
