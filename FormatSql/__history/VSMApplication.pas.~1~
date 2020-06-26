unit VSMApplication;

interface

uses
  Vcl.Forms, System.SysUtils, Winapi.Windows, Vcl.Controls, uIVSMForm;

type
  TVSMApplication = class
  private
    FFormAtivo: IVSMForm;
    FKBHook: HHOOK;
    FMHook: HHOOK;
    FfrmHookedForm: TForm;
    FCursor: TCursor;
    FinputBloqueadoLiberadoG: Boolean;
    FInputBloqueadoG: Boolean;
    procedure SetFormAtivo(const Value: IVSMForm);
    class var FInstance: TVSMApplication;
    procedure SetKBHook(const Value: HHOOK);
    procedure SetfrmHookedForm(const Value: TForm);
    procedure SetMHook(const Value: HHOOK);
    procedure SetCursor(const Value: TCursor);
    procedure SetinputBloqueadoLiberadoG(const Value: Boolean);
    procedure SetInputBloqueadoG(const Value: Boolean);
  { private declarations }
  protected
    constructor CreatePrivado;
  { protected declarations }
  public
    class function GetInstance: TVSMApplication;
    constructor Create;
    procedure EsconderStatus;
    procedure MostrarStatus(const sTextoF: string);
  { public declarations }
  published
    property KBHook: HHOOK read FKBHook write SetKBHook;
    property MHook: HHOOK read FMHook write SetMHook;
    property frmHookedForm: TForm read FfrmHookedForm write SetfrmHookedForm;
    property FormAtivo: IVSMForm read FFormAtivo write SetFormAtivo;
    property Cursor: TCursor read FCursor write SetCursor;
    property InputBloqueadoLiberadoG: Boolean read FinputBloqueadoLiberadoG write SetinputBloqueadoLiberadoG;
    property InputBloqueadoG: Boolean read FInputBloqueadoG write SetInputBloqueadoG;
  { published declarations }
  end;

implementation



{ TVSMApplication }

constructor TVSMApplication.Create;
begin
  raise Exception.Create('Construtor inutilizado utilizar a opção GetInstance');
end;

constructor TVSMApplication.CreatePrivado;
begin
  inherited Create;
end;

procedure TVSMApplication.EsconderStatus;
begin
  FormAtivo.EsconderStatus;
end;

class function TVSMApplication.GetInstance: TVSMApplication;
begin
  if not Assigned(FInstance) then
    FInstance := TVSMApplication.CreatePrivado;
  Result := FInstance;
end;

procedure TVSMApplication.MostrarStatus(const sTextoF: string);
begin
  FormAtivo.MostrarStatus(sTextoF);
end;

procedure TVSMApplication.SetCursor(const Value: TCursor);
begin
  FCursor := Value;
end;

procedure TVSMApplication.SetFormAtivo(const Value: IVSMForm);
begin
  FFormAtivo := Value;
end;

procedure TVSMApplication.SetfrmHookedForm(const Value: TForm);
begin
  FfrmHookedForm := Value;
end;

procedure TVSMApplication.SetInputBloqueadoG(const Value: Boolean);
begin
  FInputBloqueadoG := Value;
end;

procedure TVSMApplication.SetinputBloqueadoLiberadoG(const Value: Boolean);
begin
  FinputBloqueadoLiberadoG := Value;
end;

procedure TVSMApplication.SetKBHook(const Value: HHOOK);
begin
  FKBHook := Value;
end;

procedure TVSMApplication.SetMHook(const Value: HHOOK);
begin
  FMHook := Value;
end;

initialization

finalization

end.
