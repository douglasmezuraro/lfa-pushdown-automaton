unit Impl.Types;

interface

uses
  System.SysUtils;

type
  TSymbol     = string;
  TState      = string;
  TTransition = string;
  TWord       = string;
  TMatrix     = TArray<TArray<string>>;
  ENotDefined = class(Exception);
  EDuplicated = class(Exception);
  ENotFound   = class(Exception);

implementation

end.

