unit Impl.AP;

interface

uses
  System.SysUtils, Impl.Stack, Impl.Types, Impl.Transitions;

type
  TAP = class sealed
  private
    FSymbols: TArray<TState>;
    FStates: TArray<TState>;
    FTransitions: TTransitions;
    FInitialState: TState;
    FBase: TSymbol;
    FAuxSymbols: TArray<TState>;
  public const
    Empty: TSymbol = 'ʎ';
  public
    procedure Clear;
    function Accept(const Word: TWord): Boolean;
  published
    property Symbols: TArray<TSymbol> read FSymbols write FSymbols;
    property States: TArray<TState> read FStates write FStates;
    property InitialState: TState read FInitialState write FInitialState;
    property AuxSymbols: TArray<TSymbol> read FAuxSymbols write FAuxSymbols;
    property Base: TSymbol read FBase write FBase;
    property Transitions: TTransitions read FTransitions write FTransitions;
  end;

implementation

{ TAP }

function TAP.Accept(const Word: TWord): Boolean;
begin
  result := true;
end;

procedure TAP.Clear;
begin
  SetLength(FSymbols, 0);
  SetLength(FStates, 0);
  SetLength(FAuxSymbols, 0);
  FTransitions.Clear;
  FInitialState := TState.Empty;
  FBase := TSymbol.Empty;
end;

end.

