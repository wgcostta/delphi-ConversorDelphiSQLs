unit GeradorSQLDelphi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, RzEdit, Vcl.ExtCtrls, Vcl.ComCtrls, RzLabel, Vcl.Mask, System.Actions,
  Vcl.ActnList, VSMColorButton, Easysize;

  CONST TemplatePadrao =  ' <?xml version="1.0" encoding="utf-8" ?> ' +
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
  TsqlForDelphi = class(TForm)
    MemoSQL: TRzMemo;
    MemoResultado: TRzMemo;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    pgSQLDelphi: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    edtNomeTemplate: TRzEdit;
    edtDescricaoTemplate: TRzEdit;
    memoCodigoTemplate: TRzMemo;
    Panel2: TPanel;
    Panel3: TPanel;
    btnClear: TVSMColorButton;
    btnCopy: TVSMColorButton;
    ActionList1: TActionList;
    ACT_CLEAR: TAction;
    ACT_COPY: TAction;
    VSMColorButton9: TVSMColorButton;
    VSMColorButton1: TVSMColorButton;
    VSMColorButton2: TVSMColorButton;
    ACT_DELPHISQL: TAction;
    ACT_SQLDELPHI: TAction;
    ACT_TEMPLATE: TAction;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    chkUpper: TCheckBox;
    Panel4: TPanel;
    chkGerarArquivo: TCheckBox;
    lblArquivo: TLabel;
    chkFullScrean: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure ACT_CLEARExecute(Sender: TObject);
    procedure ACT_COPYExecute(Sender: TObject);
    procedure ACT_TEMPLATEExecute(Sender: TObject);
    procedure ACT_SQLDELPHIExecute(Sender: TObject);
    procedure ACT_DELPHISQLExecute(Sender: TObject);
    procedure chkFullScreanClick(Sender: TObject);
  private
   frmResizer: TFormResizer;
   procedure MontarSQLparaDelphi;
   procedure MontarDelphiParaSQL;
   procedure GerarTemplateDelphi;
   procedure GerarArquivo(sCaminho, sTexto : String);
   procedure MontarArquivo(sTextoArquivo: String);
    { Private declarations }

  public
    { Public declarations }
  end;

var
  sqlForDelphi: TsqlForDelphi;

implementation

uses
  Vcl.Clipbrd;

{$R *.dfm}

procedure TsqlForDelphi.ACT_CLEARExecute(Sender: TObject);
begin
   MemoResultado.Clear;
   MemoSQL.Clear;
   memoCodigoTemplate.Clear;
end;

procedure TsqlForDelphi.ACT_COPYExecute(Sender: TObject);
begin
   Clipboard.AsText := MemoResultado.Text;
end;

procedure TsqlForDelphi.ACT_DELPHISQLExecute(Sender: TObject);
begin
   MemoResultado.Clear;
   MontarDelphiParaSQL;
   MemoResultado.Enabled := True;
end;

procedure TsqlForDelphi.ACT_SQLDELPHIExecute(Sender: TObject);
begin
   MemoResultado.Clear;
   MontarSQLparaDelphi;
   MemoResultado.Enabled := True;
end;

procedure TsqlForDelphi.ACT_TEMPLATEExecute(Sender: TObject);
begin
   try
      if edtNomeTemplate.Text = EmptyStr then
      begin
         ShowMessage('Nome do Template deve ser informado');
         Exit;
      end;

      if edtDescricaoTemplate.Text = EmptyStr then
      begin
         ShowMessage('Descrição do Template deve ser informado');
         Exit;
      end;

      if memoCodigoTemplate.Text = EmptyStr then
      begin
         ShowMessage('Código para o Template deve ser informado');
         Exit;
      end;

      GerarTemplateDelphi;
      MemoResultado.Enabled := True;
   except
      ShowMessage('Ocorreu um erro');
   end;
end;

procedure TsqlForDelphi.chkFullScreanClick(Sender: TObject);
begin
   if chkFullScrean.Checked then
   begin
      frmResizer := TFormResizer.Create(Self);
      frmResizer.Name := 'frmResizer';
      frmResizer.ResizeFonts := True;
      frmResizer.MinFontSize := 7;
      frmResizer.MaxFontSize := 18;
      frmResizer.InitializeForm;
      frmResizer.FullScreen;
      frmResizer.ResizeAll;
      chkFullScrean.Enabled := False;
   end
   else
   begin
      if Assigned(frmResizer) then
         frmResizer.Free;
   end;
end;

procedure TsqlForDelphi.FormShow(Sender: TObject);
begin
   pgSQLDelphi.ActivePage := TabSheet1;
end;

procedure TsqlForDelphi.GerarArquivo(sCaminho, sTexto : String);
var
   Arquivo : TStringList;
begin
    Arquivo := TStringList.Create;
    try
        Arquivo.Add(sTexto);
        Arquivo.SaveToFile(sCaminho);
    finally
         Arquivo.Free;
    end;
end;

procedure TsqlForDelphi.GerarTemplateDelphi;
var
   sNome, sDescricao, sTempArquivo : string;
   i : Integer;
begin
   try
      sNome := StringReplace(edtNomeTemplate.Text,' ', EmptyStr, [rfReplaceAll]);
      sDescricao := edtDescricaoTemplate.Text;
      MemoResultado.Clear;

      for i := 0 to memoCodigoTemplate.Lines.Count -1 do
      begin
         MemoResultado.Lines.Add('|*|'  + memoCodigoTemplate.Lines.Strings[i]);
      end;

      sTempArquivo := StringReplace(TemplatePadrao,'#SUBSTITUIR01#',sNome,[rfReplaceAll, rfIgnoreCase]);
      sTempArquivo := StringReplace(sTempArquivo,'#SUBSTITUIR02#',sDescricao,[rfReplaceAll, rfIgnoreCase]);

      sTempArquivo := sTempArquivo + MemoResultado.Text + TemplatePadraoFim ;

      MemoResultado.Clear;
      MemoResultado.Text := sTempArquivo;
      GerarArquivo('C:\Program Files (x86)\Embarcadero\Studio\18.0\ObjRepos\en\Code_Templates\Delphi\' + sNome + '.xml',sTempArquivo);
      lblArquivo.Caption := 'Arquivo gerado com sucesso em: \Embarcadero\Studio\18.0\ObjRepos\en\Code_Templates\Delphi';

   except
      raise;
   end;

end;


procedure TsqlForDelphi.MontarDelphiParaSQL;
var
   Lista: TStringList;
   iRetorno:Integer;
   i : integer ;
   sTempSQL, sTextoArquivo : string;
begin
   for i := 0 to MemoSQL.Lines.Count -1 do
   begin
      sTempSQL := StringReplace(MemoSQL.Lines.Strings[i],'''#$D#$A#9''','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);  //Muda sujeira para remover depois
      sTempSQL := StringReplace(sTempSQL,'#$D#$A','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'#$D#','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'$A#9','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'#9','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'$D','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'$A','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'''#REMOVER#''','',[rfReplaceAll, rfIgnoreCase]);  //Remove a sujeira com as aspas que ficaram
      sTempSQL := StringReplace(sTempSQL,'#REMOVER#','',[rfReplaceAll, rfIgnoreCase]);

      sTempSQL := StringReplace(sTempSQL,'''','##',[rfReplaceAll, rfIgnoreCase]);   // Remove aspas duplas para ## para manipular depois
      sTempSQL := StringReplace(sTempSQL,'####','%%',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,') +',')',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,')+',')',[rfReplaceAll, rfIgnoreCase]);

      sTempSQL := StringReplace(sTempSQL,'#+',' ',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'+#',' ',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'+ #',' ',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'# +',' ',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'%%','''',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'#',' ',[rfReplaceAll, rfIgnoreCase]);
      MemoResultado.Lines.Add(sTempSQL);
      sTextoArquivo := sTextoArquivo + sTempSQL;
   end;

   MontarArquivo(sTextoArquivo);
end;

procedure TsqlForDelphi.MontarArquivo(sTextoArquivo: String);
var
   sNomeArq : string;
begin
   if chkGerarArquivo.Checked then
   begin
      sNomeArq := DateTimeToStr(Now) ;
      sNomeArq := StringReplace(sNomeArq, ':', '', [rfReplaceAll]);
      sNomeArq := StringReplace(sNomeArq, '/', '', [rfReplaceAll]);
      sNomeArq := StringReplace(sNomeArq, ' ', '', [rfReplaceAll]);
      sNomeArq :=  'C:\OUROFARMA\SQL_GERADOR_DELPHI_' + sNomeArq + '.sql';
      GerarArquivo(sNomeArq,sTextoArquivo);
      lblArquivo.Caption := sNomeArq ;
   end;
end;

procedure TsqlForDelphi.MontarSQLparaDelphi;
var
   Lista: TStringList;
   iRetorno:Integer;
   i : integer ;
   sTempSQL, sTextoArquivo : string;
begin
   sTextoArquivo := EmptyStr;
   for i := 0 to MemoSQL.Lines.Count -1 do
   begin
      sTempSQL := StringReplace(MemoSQL.Lines.Strings[i],'''','''''',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'`','',[rfReplaceAll, rfIgnoreCase]);
      sTempSQL := StringReplace(sTempSQL,'\','\\',[rfReplaceAll, rfIgnoreCase]);
      if not chkUpper.Checked then
         sTempSQL := UpperCase(sTempSQL);
      sTempSQL := ' '' ' + sTempSQL + ' '' + ' ;
      MemoResultado.Lines.Add(sTempSQL);
      sTextoArquivo := sTextoArquivo + sTempSQL;
   end;

   MontarArquivo(sTextoArquivo);
end;

end.
