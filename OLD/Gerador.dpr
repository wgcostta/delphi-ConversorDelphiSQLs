program Gerador;

uses
  Vcl.Forms,
  GeradorSQLDelphi in 'GeradorSQLDelphi.pas' {sqlForDelphi};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TsqlForDelphi, sqlForDelphi);
  Application.Run;
end.
