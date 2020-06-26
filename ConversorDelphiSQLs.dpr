program ConversorDelphiSQLs;

uses
  Vcl.Forms,
  GeradorSQLDelphi in 'GeradorSQLDelphi.pas' {sqlForDelphi},
  Vcl.Themes,
  Vcl.Styles,
  VSM.Conversor.SQL in 'FormatSql\VSM.Conversor.SQL.pas',
  uLkJSON in 'FormatSql\uLkJSON.pas',
  Cloud.Rest in 'FormatSql\Cloud.Rest.pas',
  Cloud.Dto.Tabela in 'FormatSql\Cloud.Dto.Tabela.pas',
  Cloud.Rest.Client.ParamHeaderDto in 'FormatSql\Cloud.Rest.Client.ParamHeaderDto.pas',
  Cloud.Model.RetornoJson in 'FormatSql\Cloud.Model.RetornoJson.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TsqlForDelphi, sqlForDelphi);
  Application.Run;
end.
