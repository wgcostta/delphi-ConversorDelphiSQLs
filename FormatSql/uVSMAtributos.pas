{******************************************************************************}
{ Projeto: ORM - Básico do Blog do Luiz                                        }
{ Este projeto busca agilizar o processo de manipulação de dados (DAO/CRUD),   }
{ ou seja,  gerar inserts, updates, deletes nas tabelas de forma automática,   }
{ sem a necessidade de criarmos classes DAOs para cada tabela. Também visa     }
{ facilitar a transição de uma suite de componentes de acesso a dados para     }
{ outra.                                                                       }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014 Luiz Carlos Alves                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{    Luiz Carlos Alves - contato@luizsistemas.com.br                           }
{                                                                              }
{ Você pode obter a última versão desse arquivo no repositório                 }
{ https://github.com/luizsistemas/ORM-Basico-Delphi                            }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{ Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Luiz Carlos Alves - contato@luizsistemas.com.br -  www.luizsistemas.com.br   }
{                                                                              }
{******************************************************************************}
unit uVSMAtributos;

interface

uses
  Rtti, System.Classes, System.SysUtils, System.Generics.Collections;
type
  TVSMTabela = class
  end;

  TVSMTabelaDataSet = class helper for TVSMTabela

  end;

TResultArray = array of string;

  type
  TClasseAnonima = record
    NomeTabela: string;
    Sep: string;
    PKs: TResultArray;
    TipoRtti: TRttiType;
    Query: string;
    Tabela: TVSMTabela;
  end;

  //trecords
type
  TFuncReflexao = reference to function(ACampos: TClasseAnonima): Boolean;

  AttTabela = class(TCustomAttribute)
  private
    FNome: string;
  public
    constructor Create(ANomeTabela: string);
    property Nome: string read FNome write FNome;
  end;

  AttNamedQuery = class(TCustomAttribute)
  private
    FQuery: string;
    FNome: string;
    procedure SetQuery(const Value: string);
    procedure SetNome(const Value: string);
  public
    constructor Create(Nome, Query: string);
    property Nome: string read FNome write SetNome;
    property Query: string read FQuery write SetQuery;
  end;

  /// <summary>
  /// Atributos de Chave Primaria e Relacionamentos
  /// </summary>

  AttPK = class(TCustomAttribute)
  end;
  AttComposicao = class(TCustomAttribute)
  end;

  AttAgregacao = class(TCustomAttribute)
  end;

  AttOneToMany = class(TCustomAttribute)
  end;

  AttChaveEstrangeira = class(TCustomAttribute)
  private
    FChaveEstrangeira: string;
    FChave: string;
  public
    constructor Create(Chave, ChaveEstrangeira: string);
    property ChaveEstrangeira: string read FChaveEstrangeira write FChaveEstrangeira;
    property Chave: string read FChave write FChave;
  end;

  AttColumn = class(TCustomAttribute)
  private
    FNome: string;
    FTamanho: Integer;
    procedure SetTamanho(const Value: Integer);
  public
    constructor Create(NomeCampo: string; Tamanho: Integer = 0);
    property Nome: string read FNome write FNome;
    property Tamanho: Integer read FTamanho write SetTamanho default 0;
  end;

  AttInUpdate = class(TCustomAttribute)
  private
    FUpDate: Boolean;
  public
    constructor Create(UpDate: Boolean = True);
    property UpDate: Boolean read FUpDate write FUpDate;
  end;

  AttInHidden= class(TCustomAttribute)
   private
      FHidden: Boolean;
   public
      constructor Create(Hidden: Boolean = True);
   property Hidden: Boolean read FHidden write FHidden;
   end;

   AttAutoInc = class(TCustomAttribute)
   private

    FAutoInc: Boolean;
    FControlSeq: Boolean;
    procedure SetAutoInc(const Value: Boolean);
    procedure SetControlSeq(const Value: Boolean);
   public
      constructor Create(AutoInc: Boolean = True; ControlSeq: Boolean = False);
   property AutoInc: Boolean read FAutoInc write SetAutoInc;
   property ControlSeq: Boolean read FControlSeq write SetControlSeq;
   end;

   AttPermiteNulo = class(TCustomAttribute)
   private
      FPermiteNulo: Boolean;
   public
      constructor Create(PermiteNulo: Boolean = True);
      property PermiteNulo: Boolean read FPermiteNulo write FPermiteNulo;
   end;

type
TVSMChaveEstrangeira = class
private
    FChaveEStrangeira: string;
    FChave: string;
    procedure SetChave(const Value: string);
    procedure SetChaveEStrangeira(const Value: string);
   { private declarations }
protected
   { protected declarations }
public
   { public declarations }

published
   property Chave: string read FChave write SetChave;
   property ChaveEStrangeira: string read FChaveEStrangeira write SetChaveEStrangeira;
   { published declarations }
end;

   TVSMAutoIncremento = class
   private
    FisControlSeq: Boolean;
    FisAutoInc: Boolean;
    procedure SetisAutoInc(const Value: Boolean);
    procedure SetisControlSeq(const Value: Boolean);
   public
    property isAutoInc: Boolean read FisAutoInc write SetisAutoInc;
    property isControlSeq: Boolean read FisControlSeq write SetisControlSeq;
   end;

type
TVSMCampo = class
   private
    FNomeCampo: string;
    FUpDate: Boolean;
    FPK: Boolean;
    FHidden: Boolean;
    FisAgregacao: Boolean;
    FRelacionamento: TObjectList<TVSMChaveEstrangeira>;
    FisComposicao: Boolean;
    FisOneToMany: Boolean;
    FAutoIncremento: TVSMAutoIncremento;
    FPermiteNulo: Boolean;
    FTamanho: Integer;
    procedure SetNomeCampo(const Value: string);
    procedure SetPK(const Value: Boolean);
    procedure SetUpDate(const Value: Boolean);
    procedure SetHidden(const Value: Boolean);
    procedure SetisAgregacao(const Value: Boolean);
    procedure SetRelacionamento(const Value: TObjectList<TVSMChaveEstrangeira>);
    procedure SetisComposicao(const Value: Boolean);
    procedure SetisOneToMany(const Value: Boolean);
    procedure SetAutoIncremento(const Value: TVSMAutoIncremento);
    procedure SetPermiteNulo(const Value: Boolean);
    procedure SetTamanho(const Value: Integer);
      { private declarations }
   protected
      { protected declarations }
   public
      Constructor Create;
    destructor Destroy; override;
   class function RetornaCampo(PropRtti: TRttiProperty; var Campo: TVSMCampo): TVSMCampo;
      { public declarations }

   published
      property PK: Boolean read FPK write SetPK;
      property NomeCampo: string read FNomeCampo write SetNomeCampo;
      property UpDate:Boolean read FUpDate write SetUpDate;
      property Hidden: Boolean read FHidden write SetHidden;
      property isAgregacao: Boolean read FisAgregacao write SetisAgregacao;
      property isComposicao: Boolean read FisComposicao write SetisComposicao;
      property isOneToMany: Boolean read FisOneToMany write SetisOneToMany;
      property Relacionamento: TObjectList<TVSMChaveEstrangeira> read FRelacionamento write SetRelacionamento;
      //property AutoInc: Boolean;
      property AutoIncremento: TVSMAutoIncremento read FAutoIncremento write SetAutoIncremento;
      property PermiteNulo: Boolean read FPermiteNulo write SetPermiteNulo;
      property Tamanho: Integer read FTamanho write SetTamanho;

      { published declarations }
end;

  TRecParams = record
    Prop: TRttiProperty;
    Campo: TVSMCampo;
    Tabela: TVSMTabela;
    Qry: TObject;
    Query: TStringBuilder;
  end;

  /// <summary>
  /// Atributos de Validação
  /// </summary>

  AttBaseValidacao = class(TCustomAttribute)
  private
    FMensagemErro: string;
    procedure SetMessagemErro(const Value: string);
  public
    property MessagemErro: string read FMensagemErro write SetMessagemErro;
  end;

  AttNotNull = class(AttBaseValidacao)
  public
    constructor Create(const ANomeCampo: string);
    function ValidarString(Value: string): Boolean;
    function ValidarInteger(Value: Integer): Boolean;
    function ValidarFloat(Value: Double): Boolean;
    function ValidarData(Value: Double): Boolean;
  end;

  AttMinValue = class(AttBaseValidacao)
  private
    FValorMinimo: Double;
  public
    constructor Create(ValorMinimo: Double; const ANomeCampo: string);
    function Validar(Value: Double): Boolean;
  end;

  AttMaxValue = class(AttBaseValidacao)
  private
    FValorMaximo: Double;
  public
    constructor Create(ValorMaximo: Double; const ANomeCampo: string);
    function Validar(Value: Double): Boolean;
  end;

       // Reflection para os comandos Sql
    function ReflexaoSQL(Tabela: TVSMTabela; AnoniComando: TFuncReflexao): Boolean;

    function PegaNomeTab(Tabela: TVSMTabela): string;
    function RetornaQuery(Tabela: TVSMTabela; NomeQuery: string): string;
    function PegaPks(Tabela: TVSMTabela): TResultArray;
    function PegaAutoInc(Tabela: TVSMTabela): String;
//    procedure SetarPropriedade(AObj: TObject; AProp: string; AValor: Variant);

implementation

uses
  System.TypInfo, Winapi.Windows, System.Variants;

//procedure SetarPropriedade(AObj: TObject; AProp: string; AValor: Variant);
//var
//  Contexto: TRttiContext;
//  TipoRtti: TRttiType;
//  PropRtti: TRttiProperty;
//begin
//   Contexto := TRttiContext.Create;
//   try
//      TipoRtti := Contexto.GetType(AObj.ClassType);
//      for PropRtti in TipoRtti.GetProperties do
//      begin
//         if CompareText(PropRtti.Name, AProp) = 0 then
//         begin
//           PropRtti.SetValue(AObj, System.Variants.VarToStr(AValor));
//         end;
//      end;
//   finally
//    Contexto.free;
//   end;
//end;

function ReflexaoSQL(Tabela: TVSMTabela; AnoniComando: TFuncReflexao): Boolean;
var
  ACampos: TClasseAnonima;
  Contexto: TRttiContext;
begin
   ACampos.NomeTabela := PegaNomeTab(Tabela);

   if ACampos.NomeTabela = EmptyStr then
      raise Exception.Create('Informe o Atributo NomeTabela na classe ' + Tabela.ClassName);

   ACampos.PKs := PegaPks(Tabela);

   if Length(ACampos.PKs) = 0 then
      raise Exception.Create('Informe campos da chave primária na classe ' +  Tabela.ClassName);


   ACampos.Tabela := Tabela;

   Contexto := TRttiContext.Create;
   try
      ACampos.TipoRtti := Contexto.GetType(Tabela.ClassType);

      // executamos os comandos Sql através do método anônimo
      ACampos.Sep := '';
      Result := AnoniComando(ACampos);

   finally
      Contexto.free;
   end;


end;

function RetornaQuery(Tabela: TVSMTabela; NomeQuery: string): string;
var
  Contexto: TRttiContext;
  TipoRtti: TRttiType;
  AtribRtti: TCustomAttribute;
  sno: string;
begin
  Result := '';
  Contexto := TRttiContext.Create;
  TipoRtti := Contexto.GetType(Tabela.ClassType);
  try
    for AtribRtti in TipoRtti.GetAttributes do
      if AtribRtti Is AttNamedQuery then
      begin
         if UpperCase((AtribRtti as AttNamedQuery).Nome) = UpperCase(NomeQuery) then
         begin
            Result := (AtribRtti as AttNamedQuery).Query;
            Break;
         end;
      end;
  finally
    Contexto.free;
  end;
end;

function PegaNomeTab(Tabela: TVSMTabela): string;
var
  Contexto: TRttiContext;
  TipoRtti: TRttiType;
  AtribRtti: TCustomAttribute;
  sno: string;
begin
  Contexto := TRttiContext.Create;
  TipoRtti := Contexto.GetType(Tabela.ClassType);
  try
    for AtribRtti in TipoRtti.GetAttributes do
      if AtribRtti Is AttTabela then
      begin
        Result := (AtribRtti as AttTabela).Nome;
        Break;
      end;
  finally
    Contexto.free;
  end;
end;

function PegaPks(Tabela: TVSMTabela): TResultArray;
var
  Contexto: TRttiContext;
  TipoRtti: TRttiType;
  PropRtti: TRttiProperty;
  AtribRtti: TCustomAttribute;
  i: Integer;
begin
   Contexto := TRttiContext.Create;
   try
      TipoRtti := Contexto.GetType(Tabela.ClassType);
      i := 0;
      for PropRtti in TipoRtti.GetProperties do
      begin
         for AtribRtti in PropRtti.GetAttributes do
         begin
            if AtribRtti Is AttPK then
            begin
               SetLength(Result, i + 1);
               Result[i] := PropRtti.Name;
               inc(i);
            end;
         end;
      end;
   finally
      Contexto.free;
   end;
end;

function PegaAutoInc(Tabela: TVSMTabela): String;
var
  Contexto: TRttiContext;
  TipoRtti: TRttiType;
  PropRtti: TRttiProperty;
  Campo: TVSMCampo;
begin
   Contexto := TRttiContext.Create;
   TipoRtti := Contexto.GetType(Tabela.ClassInfo);
   try
      for PropRtti in TipoRtti.GetProperties do
      begin
         Campo := TVSMCampo.Create;
         try
            TVSMCampo.RetornaCampo(PropRtti, Campo);
            if Campo.AutoIncremento.isAutoInc then
            begin
               Result := Campo.NomeCampo;
               Break;
            end;
         finally
            Campo.Free;
         end;
      end;
   finally
      Contexto.free;
   end;
end;

{ TNomeTabela }

constructor AttTabela.Create(ANomeTabela: string);
begin
  FNome := ANomeTabela;
end;

{ TBaseValidacao }

procedure AttBaseValidacao.SetMessagemErro(const Value: string);
begin
  FMensagemErro := Value;
end;

{ TValidaIntegerMinimo }

constructor AttMinValue.Create(ValorMinimo: Double; const ANomeCampo: string);
begin
  FValorMinimo := ValorMinimo;
  FMensagemErro := 'Campo ' + ANomeCampo + ' com valor inválido!';
end;

function AttMinValue.Validar(Value: Double): Boolean;
begin
  Result := Value >= FValorMinimo;
end;

constructor AttMaxValue.Create(ValorMaximo: Double; const ANomeCampo: string);
begin
  FValorMaximo := ValorMaximo;
  FMensagemErro := 'Campo ' + ANomeCampo + ' com valor inválido!';
end;

function AttMaxValue.Validar(Value: Double): Boolean;
begin
  Result := Value <= FValorMaximo;
end;

{ TValidaStringNaoNulo }

constructor AttNotNull.Create(const ANomeCampo: string);
begin
  FMensagemErro := 'Campo obrigatório não informado: ' + ANomeCampo ;
end;

function AttNotNull.ValidarString(Value: string): Boolean;
begin
  Result := not(Value = EmptyStr);
end;

function AttNotNull.ValidarInteger(Value: Integer): Boolean;
begin
  Result := not(Value <= 0);
end;

function AttNotNull.ValidarFloat(Value: Double): Boolean;
begin
  Result := not(Value <= 0);
end;

function AttNotNull.ValidarData(Value: Double): Boolean;
begin
  Result := not(Value = 0);
end;

{ AttColumn }

constructor AttColumn.Create(NomeCampo: string; Tamanho: Integer);
begin
   FNome := NomeCampo;
   FTamanho := Tamanho;
end;

procedure AttColumn.SetTamanho(const Value: Integer);
begin
  FTamanho := Value;
end;

{ AttChaveEstrangeira }

constructor AttChaveEstrangeira.Create(Chave, ChaveEstrangeira: string);
begin
   FChaveEstrangeira := ChaveEstrangeira;
   FChave := Chave;
end;

{ AttInUpdate }

constructor AttInUpdate.Create(UpDate: Boolean);
begin
   FUpDate := UpDate;
end;

{ TVSMCampo }

constructor TVSMCampo.Create;
begin
   Self.PK := False;
   Self.NomeCampo := '';
   Self.UpDate := True;
   Relacionamento := TObjectList<TVSMChaveEstrangeira>.Create;
   Self.AutoIncremento := TVSMAutoIncremento.Create;
   Self.PermiteNulo := False;
end;

destructor TVSMCampo.Destroy;
begin
   inherited;
   AutoIncremento.Free;
   Relacionamento.Free;
end;

class function TVSMCampo.RetornaCampo(PropRtti: TRttiProperty; var Campo: TVSMCampo): TVSMCampo;
var
   AtribRtti : TCustomAttribute;
   chaveEstrangeira: TVSMChaveEstrangeira;
begin
   Campo.NomeCampo := PropRtti.Name;
   for AtribRtti in PropRtti.GetAttributes do
   begin
      if AtribRtti is AttPK then
         Campo.PK := True
      else if AtribRtti is AttColumn then
      begin
         Campo.NomeCampo := (AtribRtti as AttColumn).Nome;
         Campo.Tamanho   := (AtribRtti as AttColumn).Tamanho;
      end
      else if AtribRtti is AttInUpdate then
         Campo.UpDate := (AtribRtti as AttInUpdate).UpDate
      else if AtribRtti is AttInHidden then
         Campo.Hidden := (AtribRtti as AttInHidden).Hidden
      else if AtribRtti is AttAgregacao then
         Campo.isAgregacao := (AtribRtti is AttAgregacao)
      else if AtribRtti is AttComposicao then
         Campo.isAgregacao := (AtribRtti is AttComposicao)
      else if AtribRtti is AttChaveEstrangeira then
      begin
         chaveEstrangeira := TVSMChaveEstrangeira.Create;
         chaveEstrangeira.Chave := (AtribRtti as AttChaveEstrangeira).Chave;
         chaveEstrangeira.ChaveEStrangeira := (AtribRtti as AttChaveEstrangeira).ChaveEstrangeira;
         Campo.Relacionamento.Add(chaveEstrangeira);
      end
      else if AtribRtti is AttAutoInc then
      begin
         Campo.AutoIncremento.isAutoInc     := (AtribRtti as AttAutoInc).FAutoInc;
         Campo.AutoIncremento.isControlSeq  := (AtribRtti as AttAutoInc).ControlSeq;
      end
      else if AtribRtti is AttPermiteNulo then
      begin
         Campo.PermiteNulo := (AtribRtti as AttPermiteNulo).PermiteNulo;
      end

   end;
   Result := Campo;
end;

procedure TVSMCampo.SetAutoIncremento(const Value: TVSMAutoIncremento);
begin
  FAutoIncremento := Value;
end;

procedure TVSMCampo.SetHidden(const Value: Boolean);
begin
  FHidden := Value;
end;

procedure TVSMCampo.SetisAgregacao(const Value: Boolean);
begin
  FisAgregacao := Value;
end;

procedure TVSMCampo.SetisComposicao(const Value: Boolean);
begin
  FisComposicao := Value;
end;

procedure TVSMCampo.SetisOneToMany(const Value: Boolean);
begin
  FisOneToMany := Value;
end;

procedure TVSMCampo.SetNomeCampo(const Value: string);
begin
  FNomeCampo := Value;
end;

procedure TVSMCampo.SetPermiteNulo(const Value: Boolean);
begin
  FPermiteNulo := Value;
end;

procedure TVSMCampo.SetPK(const Value: Boolean);
begin
  FPK := Value;
end;

procedure TVSMCampo.SetRelacionamento(
  const Value: TObjectList<TVSMChaveEstrangeira>);
begin
  FRelacionamento := Value;
end;

procedure TVSMCampo.SetTamanho(const Value: Integer);
begin
  FTamanho := Value;
end;

procedure TVSMCampo.SetUpDate(const Value: Boolean);
begin
  FUpDate := Value;
end;

{ AttInHidden }

constructor AttInHidden.Create(Hidden: Boolean);
begin
   FHidden := Hidden;
end;

{ TVSMChaveEstrangeira }

procedure TVSMChaveEstrangeira.SetChave(const Value: string);
begin
  FChave := Value;
end;

procedure TVSMChaveEstrangeira.SetChaveEStrangeira(const Value: string);
begin
  FChaveEStrangeira := Value;
end;

{ AttNamedQuery }

constructor AttNamedQuery.Create(Nome, Query: string);
begin
   Self.Nome := Nome;
   Self.Query := Query;
end;

procedure AttNamedQuery.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure AttNamedQuery.SetQuery(const Value: string);
begin
  FQuery := Value;
end;

{ AttAutoInc }

constructor AttAutoInc.Create(AutoInc, ControlSeq: Boolean);
begin
   FAutoInc    := AutoInc;
   FControlSeq := ControlSeq;
end;

procedure AttAutoInc.SetAutoInc(const Value: Boolean);
begin
  FAutoInc := Value;
end;

procedure AttAutoInc.SetControlSeq(const Value: Boolean);
begin
  FControlSeq := Value;
end;

{ TVSMAutoIncremento }

procedure TVSMAutoIncremento.SetisAutoInc(const Value: Boolean);
begin
  FisAutoInc := Value;
end;

procedure TVSMAutoIncremento.SetisControlSeq(const Value: Boolean);
begin
  FisControlSeq := Value;
end;

{ AttPermiteNulo }

constructor AttPermiteNulo.Create(PermiteNulo: Boolean = True);
begin
   FPermiteNulo := PermiteNulo;
end;

end.
