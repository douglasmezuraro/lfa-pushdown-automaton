unit Impl.Transition;

interface

uses
  Impl.Types;

type
  TTransition = class sealed
  strict private
    FPop: TSymbol;
    FPush: TSymbol;
    FSource: TState;
    FSymbol: TSymbol;
    FTarget: TState;
  public
    constructor Create(const Source, Target: TState; const Symbol, Pop, Push: TSymbol); overload;
  public
    property Pop: TSymbol read FPop write FPop;
    property Push: TSymbol read FPush write FPush;
    property Source: TState read FSource write FSource;
    property Symbol: TSymbol read FSymbol write FSymbol;
    property Target: TState read FTarget write FTarget;
  end;

implementation

constructor TTransition.Create(const Source, Target: TState; const Symbol, Pop, Push: TSymbol);
begin
  FSource := Source;
  FTarget := Target;
  FSymbol := Symbol;
  FPop := Pop;
  FPush := Push;
end;

end.

