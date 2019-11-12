unit Impl.Transition;

interface

uses
  Impl.Types;

type
  TTransition = class sealed
  strict private
    FSymbol: TSymbol;
    FSource: TState;
    FPush: TSymbol;
    FTarget: TState;
    FPop: TSymbol;
  public
    property Source: TState read FSource write FSource;
    property Target: TState read FTarget write FTarget;
    property Symbol: TSymbol read FSymbol write FSymbol;
    property Push: TSymbol read FPush write FPush;
    property Pop: TSymbol read FPop write FPop;
  end;

implementation

end.
