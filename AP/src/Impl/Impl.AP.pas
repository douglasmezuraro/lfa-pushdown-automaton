unit Impl.AP;

interface

uses
  Impl.Types, System.SysUtils;

type
  TAP = class sealed
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function IsDefined: Boolean;
    function AddSymbols(const Symbols: TArray<TSymbol>): TAP;
    function AddStates(const States: TArray<TState>): TAP;
    function AddTransitions(): TAP;
    function AddInitialState(const State: TState): TAP;
    function AddBase(const Base: TSymbol): TAP;
    function AddAuxSymbols(const Symbols: TArray<TSymbol>): TAP;
  end;

implementation

{ TAP }

constructor TAP.Create;
begin
  raise ENotImplemented.Create('The method "TAP.Create" is not implemented!');
end;

destructor TAP.Destroy;
begin
  raise ENotImplemented.Create('The method "TAP.Destroy" is not implemented!');
  inherited Destroy;
end;

function TAP.AddAuxSymbols(const Symbols: TArray<TSymbol>): TAP;
begin
  raise ENotImplemented.Create('The method "TAP.AddAuxSymbols" is not implemented!');
end;

function TAP.AddBase(const Base: TSymbol): TAP;
begin
  raise ENotImplemented.Create('The method "TAP.AddBase" is not implemented!');
end;

function TAP.AddInitialState(const State: TState): TAP;
begin
  raise ENotImplemented.Create('The method "TAP.AddInitialState" is not implemented!');
end;

function TAP.AddStates(const States: TArray<TState>): TAP;
begin
  raise ENotImplemented.Create('The method "TAP.AddStates" is not implemented!');
end;

function TAP.AddSymbols(const Symbols: TArray<TSymbol>): TAP;
begin
  raise ENotImplemented.Create('The method "TAP.AddSymbols" is not implemented!');
end;

function TAP.AddTransitions: TAP;
begin
  raise ENotImplemented.Create('The method "TAP.AddTransitions" is not implemented!');
end;

procedure TAP.Clear;
begin
  raise ENotImplemented.Create('The method "TAP.Clear" is not implemented!');
end;

function TAP.IsDefined: Boolean;
begin
  raise ENotImplemented.Create('The method "TAP.IsDefined" is not implemented!');
end;

end.
