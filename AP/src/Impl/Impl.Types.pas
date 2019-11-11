unit Impl.Types;

interface

uses
  System.SysUtils;

type
  TSymbol        = string;
  TState         = string;
  TWord          = string;
  ENotDefined    = class(Exception);
  EDuplicated    = class(Exception);
  ENotFound      = class(Exception);
  EInvalidFormat = class(Exception);

implementation

end.

