program AP;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Main in '..\src\View\View.Main.pas' {Main},
  Impl.Stack in '..\src\Impl\Impl.Stack.pas',
  Impl.AP in '..\src\Impl\Impl.AP.pas',
  Impl.Types in '..\src\Impl\Impl.Types.pas',
  Impl.Transitions in '..\src\Impl\Impl.Transitions.pas',
  Impl.Dialogs in '..\src\Impl\Impl.Dialogs.pas',
  Helper.FMX in '..\src\Helper\Helper.FMX.pas';

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
