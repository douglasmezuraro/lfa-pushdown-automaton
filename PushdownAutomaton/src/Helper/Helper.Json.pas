unit Helper.Json;

interface

uses
  REST.Json, System.Classes, System.IOUtils, System.SysUtils;

type
  TJsonHelper = class Helper for TJson
  public
    class function OpenFromFile<T: class, constructor>(const FileName: string): T;
    class procedure SaveToFile<T: class>(const AObject: T; const FileName: string);
  end;

implementation

class function TJsonHelper.OpenFromFile<T>(const FileName: string): T;
var
  Json: string;
begin
  Json := TFile.ReadAllText(FileName);
  Result := JsonToObject<T>(Json);
end;

class procedure TJsonHelper.SaveToFile<T>(const AObject: T; const FileName: string);
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create(ObjectToJsonString(AObject));
  try
    Stream.SaveToFile(FileName);
  finally
    Stream.Free;
  end;
end;

end.
