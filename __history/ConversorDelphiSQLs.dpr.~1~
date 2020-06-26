program ConversorDelphiSQLs;

uses
  Vcl.Forms,
  GeradorSQLDelphi in 'GeradorSQLDelphi.pas' {sqlForDelphi},
  Vcl.Themes,
  Vcl.Styles,
  VSM.Conversor.SQL in 'FormatSql\VSM.Conversor.SQL.pas',
  VSM.Rest in 'FormatSql\VSM.Rest.pas',
  uVSMAtributos in 'FormatSql\uVSMAtributos.pas',
  VSM.Model.RetornoJson in 'FormatSql\VSM.Model.RetornoJson.pas',
  VSMRestClientParamHeaderDto in 'FormatSql\VSMRestClientParamHeaderDto.pas',
  uLkJSON in 'FormatSql\uLkJSON.pas',
  VSM.Rest.Auth in 'FormatSql\VSM.Rest.Auth.pas',
  VSM.Rest.Enumeradores in 'FormatSql\VSM.Rest.Enumeradores.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TsqlForDelphi, sqlForDelphi);
  Application.Run;
end.
