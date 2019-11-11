program AP;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Main in '..\src\View\View.Main.pas' {Main},
  Impl.Stack in '..\src\Impl\Impl.Stack.pas',
  Impl.AP in '..\src\Impl\Impl.AP.pas';

{$R *.res}

var
  Main: TMain;

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;

  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := ByteBool(DebugHook);
  {$WARN SYMBOL_PLATFORM ON}
end.
