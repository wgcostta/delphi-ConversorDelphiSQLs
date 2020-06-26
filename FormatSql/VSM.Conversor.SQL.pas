unit VSM.Conversor.SQL;

interface

uses
  Cloud.Rest,
  Cloud.Dto.Tabela,
   Vcl.Graphics;

CONST 
TemplatePadrao =  ' <?xml version="1.0" encoding="utf-8" ?> ' +
                         '  ' +
                         ' <codetemplate	xmlns="http://schemas.borland.com/Delphi/2005/codetemplates" ' +
                         ' 				version="1.0.0"> ' +

                         ' 	<template name="#SUBSTITUIR01#" invoke="manual"> ' +
                         ' 		<point name="classname"> ' +
                         ' 			<text> ' +
                         ' 				MyClass ' +
                         ' 			</text> ' +
                         ' 			<hint> ' +
                         ' 				class name ' +
                         ' 			</hint> ' +
                         ' 		</point> ' +
                         ' 		<point name="ancestor"> ' +
                         ' 			<script language="Delphi"> ' +
                         ' 				InvokeCodeCompletion; ' +
                         ' 			</script> ' +
                         ' 			<hint> ' +
                         ' 				ancestor name ' +
                         ' 			</hint> ' +
                         ' 			<text> ' +
                         ' 				Object ' +
                         ' 			</text> ' +
                         ' 		</point> ' +
                         ' 		<description> ' +
                         ' 			#SUBSTITUIR02# ' +
                         ' 		</description> ' +
                         ' 		<author> ' +
                         ' 			VSM - Gerador Default ' +
                         ' 		</author> ' +
                         ' 		<script language="Delphi" onenter="false" onleave="true"> ' +
                         ' 			InvokeClassCompletion; ' +
                         ' 		</script> ' +
                         ' 		<code language="Delphi" context="typedecl" delimiter="|"><![CDATA[' ;
                      //   ' #SUBSTITUIR03# ' +

     TemplatePadraoFim = ' ]]> ' +
                         ' 		</code> ' +
                         ' 	</template> ' +
                         ' </codetemplate> ';


  type
  TVSMFormataSQL = class(TCloudTabela)
  private
    Fresult: string;

     { private declarations }
     function ToJsonString: string;
    procedure Setresult(const Value: string);

  protected
     { protected declarations }
  public
     { public declarations }
    property result : string read Fresult write Setresult;
    function ConsumirSQL(sSql: string): String;
   class function HexToTColor(sColor: string): string;
  published
     { published declarations }
  end;


implementation

uses
  REST.Json, System.JSON,  Winapi.Windows, System.SysUtils;

{ TVSMFormataSQL }

function TVSMFormataSQL.ConsumirSQL(sSql: string): String;
var
   RestRetorno : TCloudRestRetorno;
   JSonValue : TJSonValue;
begin
//   Result := '';

   RestRetorno := TCloudRest.New('https://sqlformat.org/api/v1/format')
                              .adicionarParametro('sql',sSql)
                              .adicionarParametro('reindent','1')
//                              .adicionarParametro('indent_width','1')
                              .build(POST)
                              .executar
                              .response;

//   Result := RestRetorno.converter.get<TVSMFormataSQL>;

   JsonValue := TJSonObject.ParseJSONValue(RestRetorno.response);

   Result := JsonValue.ToJSON;
end;

procedure TVSMFormataSQL.Setresult(const Value: string);
begin
  Fresult := Value;
end;

class function TVSMFormataSQL.HexToTColor(sColor: string): string;
begin
   Result :=
     RGB(
       StrToInt('$'+Copy(sColor, 1, 2)),
       StrToInt('$'+Copy(sColor, 3, 2)),
       StrToInt('$'+Copy(sColor, 5, 2))
     ).ToString;
end;

function TVSMFormataSQL.ToJsonString: string;
begin
   result := TJson.ObjectToJsonString(Self);
end;

end.
