unit GeradorSQLDelphi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,  Vcl.ExtCtrls, Vcl.ComCtrls,  Vcl.Mask, System.Actions,
  Vcl.ActnList, System.Generics.Collections;


type
  TsqlForDelphi = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    pgSQLDelphi: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
//    btnClear: TVSMColorButton;
//    btnCopy: TVSMColorButton;
    ActionList1: TActionList;
    ACT_CLEAR: TAction;
    ACT_COPY: TAction;
//    btnSQL: TVSMColorButton;
//    btnDelphi: TVSMColorButton;
//    VSMColorButton2: TVSMColorButton;
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
    chkFormatarSQL: TCheckBox;
    MemoSQL: TMemo;
    MemoResultado: TMemo;
    chkRemoverX: TCheckBox;
    memoCodigoTemplate: TMemo;
    edtDescricaoTemplate: TEdit;
    edtNomeTemplate: TEdit;
    RzButton5: TButton;
    btnDelphi: TButton;
    btnSQL: TButton;
    btnClear: TButton;
    btnCopy: TButton;
    procedure FormShow(Sender: TObject);
    procedure ACT_CLEARExecute(Sender: TObject);
    procedure ACT_COPYExecute(Sender: TObject);
    procedure ACT_TEMPLATEExecute(Sender: TObject);
    procedure ACT_SQLDELPHIExecute(Sender: TObject);
    procedure ACT_DELPHISQLExecute(Sender: TObject);
    procedure chkFullScreanClick(Sender: TObject);
  private
//   frmResizer: TFormResizer;

   procedure MontarSQLparaDelphi;
   procedure MontarDelphiParaSQL;
   function RemoveSujeirasDelphi(sArquivoTexto: String): string;
   function TratamentoSumCoalesceDelphi(sArquivoTexto: String): string;
   function RemoveFormatacoesDelphi(sArquivoTexto: String): string;
   function RetornaTratamentoSumCoalesceDelphi(sArquivoTexto: String): string;
   procedure FormatarSQLTentativa2(sArquivoTexto: String);
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
  Vcl.Clipbrd, VSM.Conversor.SQL;

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
//   if chkFullScrean.Checked then
//   begin
//      frmResizer := TFormResizer.Create(Self);
//      frmResizer.Name := 'frmResizer';
//      frmResizer.ResizeFonts := True;
//      frmResizer.MinFontSize := 7;
//      frmResizer.MaxFontSize := 18;
//      frmResizer.InitializeForm;
//      frmResizer.FullScreen;
//      frmResizer.ResizeAll;
//      chkFullScrean.Enabled := False;
//   end
//   else
//   begin
//      if Assigned(frmResizer) then
//         frmResizer.Free;
//   end;
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

      for i := 0 to Pred(memoCodigoTemplate.Lines.Count) do
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
   sTempSQL : string;
begin
   sTempSQL := RemoveSujeirasDelphi(MemoSQL.Text);
   sTempSQL := TratamentoSumCoalesceDelphi(sTempSQL);
   sTempSQL := RemoveFormatacoesDelphi(sTempSQL);
   sTempSQL := RetornaTratamentoSumCoalesceDelphi(sTempSQL);

   if chkFormatarSQL.Checked then
   begin
      FormatarSQLTentativa2(sTempSQL) ;
      MontarArquivo(MemoResultado.Text);
   end
   else
   begin
      MemoResultado.Text := sTempSQL;
      MontarArquivo(sTempSQL);
   end;
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
      sNomeArq :=  'C:\OUROFARMA\logs\SQL_GERADOR_DELPHI_' + sNomeArq + '.sql';
      GerarArquivo(sNomeArq,sTextoArquivo);
      lblArquivo.Caption := sNomeArq ;
   end;
end;

procedure TsqlForDelphi.MontarSQLparaDelphi;
var
   Lista: TStringList;
   iRetorno:Integer;
   i, iPosicaoN,iPosicaoRecortar : integer ;
   sTempSQL, sTextoArquivo, sString2 : string;
   list : TStringList;
begin
   if chkFormatarSQL.Checked then
   begin
      FormatarSQLTentativa2(MemoSQL.Text);
      MemoSQL.Text := MemoResultado.Text;
      MemoResultado.Clear;
   end;

   for i := 0 to Pred(MemoSQL.Lines.Count) do
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

function TsqlForDelphi.RemoveFormatacoesDelphi(sArquivoTexto: String): string;
begin
   if chkRemoverX.Checked then
   begin
      sArquivoTexto := StringReplace(sArquivoTexto,') +',')',[rfReplaceAll, rfIgnoreCase]);
      sArquivoTexto := StringReplace(sArquivoTexto,')+',')',[rfReplaceAll, rfIgnoreCase]);
      sArquivoTexto := StringReplace(sArquivoTexto,'#+',' ',[rfReplaceAll, rfIgnoreCase]);
      sArquivoTexto := StringReplace(sArquivoTexto,'+#',' ',[rfReplaceAll, rfIgnoreCase]);
      sArquivoTexto := StringReplace(sArquivoTexto,'+ #',' ',[rfReplaceAll, rfIgnoreCase]);
      sArquivoTexto := StringReplace(sArquivoTexto,'# +',' ',[rfReplaceAll, rfIgnoreCase]);
   end;

   // Jogada feita na Sujeira para remoção correta.
   sArquivoTexto := StringReplace(sArquivoTexto,'%%','''',[rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(sArquivoTexto,'#',' ',[rfReplaceAll, rfIgnoreCase]);
end;

function TsqlForDelphi.RemoveSujeirasDelphi(sArquivoTexto: String): string;
begin
   sArquivoTexto := StringReplace(sArquivoTexto,'''#$D#$A#9''','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);  //Muda sujeira para remover depois
   sArquivoTexto := StringReplace(sArquivoTexto,'#$D#$A','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'#$D#','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'$A#9','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'''#9#9#9''',' #REMOVER#',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'''#9#9''','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'''#9''',' #REMOVER#',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'#9','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'$D','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'$A','#REMOVER#',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'''#REMOVER#''','',[rfReplaceAll, rfIgnoreCase]);  //Remove a sujeira com as aspas que ficaram
   sArquivoTexto := StringReplace(sArquivoTexto,'#REMOVER#','',[rfReplaceAll, rfIgnoreCase]);

   sArquivoTexto := StringReplace(sArquivoTexto,'''','##',[rfReplaceAll, rfIgnoreCase]);   // Remove aspas duplas para ## para manipular depois

   Result := StringReplace(sArquivoTexto,'####','%%',[rfReplaceAll, rfIgnoreCase]);
end;

function TsqlForDelphi.RetornaTratamentoSumCoalesceDelphi(sArquivoTexto: String): string;
begin
   sArquivoTexto := StringReplace(sArquivoTexto,'SUM2SUM','+ SUM',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'SUM3SUM','+ (SUM',[rfReplaceAll, rfIgnoreCase]);

   Result := StringReplace(sArquivoTexto,'COALESCE4COALESCE','+ COALESCE',[rfReplaceAll, rfIgnoreCase]);
end;

procedure TsqlForDelphi.FormatarSQLTentativa2(sArquivoTexto: String);
var
  Lista: TStringList;
  srvConversor : TVSMFormataSQL;
  iContador : Integer;
  sVarTexto : string;

begin
  MemoResultado.Clear;

  Lista := TStringList.Create;
  srvConversor := TVSMFormataSQL.Create;
  try
     sArquivoTexto := srvConversor.ConsumirSQL(UpperCase(sArquivoTexto));
     sArquivoTexto := StringReplace(sArquivoTexto,'\n',';',[rfReplaceAll]);
     sArquivoTexto := StringReplace(sArquivoTexto,'"}','',[rfReplaceAll, rfIgnoreCase]);
     sArquivoTexto := StringReplace(sArquivoTexto,'{"result":"','      ',[rfReplaceAll, rfIgnoreCase]);


     Lista.Delimiter := ';';
     Lista.StrictDelimiter := True;
     Lista.DelimitedText := sArquivoTexto;

     MemoResultado.Lines.AddStrings(Lista);
  finally
     srvConversor.Free;
     Lista.Free;
  end;


end;

function ObterStringEmLinhas(StringOrigem: string;
                               QtdeCaracteresLin: integer): string;
  var
    i, p, q: integer;
    StringProc, s: string;
    Lista: TStringList;
  begin
    Result := EmptyStr;
    Lista  := TStringList.Create;
    try
        q := QtdeCaracteresLin + 1;
        i := 1;
        StringProc := Trim(StringOrigem);
        while StringProc <> EmptyStr do
          begin
            s := Copy(StringProc, i, q);
            if Length(s) < q then
              begin
                Lista.Add(s);
                Delete(StringProc, 1, q);
              end
            else
              begin
//                p := Pos(' ', ReverseString(s));
                Lista.Add(Copy(s, 1, q - p));
                Delete(StringProc, 1, q - p);
              end;
            StringProc := Trim(StringProc);
          end;
        Result := Lista.Text;
    finally
        Lista.Free;
    end;
  end;

function TsqlForDelphi.TratamentoSumCoalesceDelphi(sArquivoTexto: String): string;
begin
   sArquivoTexto := StringReplace(sArquivoTexto,'+SUM','SUM2SUM',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'+ SUM','SUM2SUM',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'+  SUM','SUM2SUM',[rfReplaceAll, rfIgnoreCase]);

   sArquivoTexto := StringReplace(sArquivoTexto,'+(SUM','SUM3SUM',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'+ (SUM','SUM3SUM',[rfReplaceAll, rfIgnoreCase]);
   sArquivoTexto := StringReplace(sArquivoTexto,'+  (SUM','SUM3SUM',[rfReplaceAll, rfIgnoreCase]);

   Result := StringReplace(sArquivoTexto,'+ COALESCE','COALESCE4COALESCE',[rfReplaceAll, rfIgnoreCase]);
end;

end.
