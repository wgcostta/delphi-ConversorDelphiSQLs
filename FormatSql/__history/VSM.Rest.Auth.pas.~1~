unit VSM.Rest.Auth;

interface
  uses  VSM.Rest.Enumeradores;

type
   TSolucoesAuth = (VSMCard, VSMEcommerce, Orizon);

type TVSMRestAutentication = class
   private
      Furl: string;
      Fuser: string;
      Fpass: string;
      FtimeOut: Integer;
      FgrantType: string;
      FToken: string;
      FType_Authorizarion_API: TVSMRestTipoAutenticacao;
      FEncode: string;
      procedure Seturl(const Value: string);
      procedure Setuser(const Value: string);
      procedure Setpass(const Value: string);
      procedure SettimeOut(const Value: Integer);
      procedure SetgrantType(const Value: string);
      procedure SetToken(const Value: string);
      { private declarations }
   protected
      { protected declarations }
   public
      constructor Create;
      { public declarations }

   published
      property url: string read Furl write Seturl;
      property user: string read Fuser write Setuser;
      property pass: string read Fpass write Setpass;
      property Token: string read FToken write SetToken;
      property timeOut: Integer read FtimeOut write SettimeOut;
      property grantType: string read FgrantType write SetgrantType;
      property Type_Authorizarion_API : TVSMRestTipoAutenticacao read FType_Authorizarion_API write FType_Authorizarion_API;
      property Encode : string read FEncode write FEncode;
      { published declarations }
     end;


   type
   TVSMRestAuthFactory = class
   private
      { private declarations }
   protected
      { protected declarations }
   public
      class function GetRestAuth(solucao: TSolucoesAuth; bAutenticacaoToken : Boolean = False): TVSMRestAutentication;
      { public declarations }

   published
      { published declarations }
   end;


implementation

uses
  UN_WEBSERVICE, Soap.EncdDecd, UN_VSMLOGUTILS, System.SysUtils, VSM.Base.WebService.Utils, UN_VSMConfigService;

{ TVSMRestAutentication }

constructor TVSMRestAutentication.Create;
begin
   Self.FToken := '';
end;

procedure TVSMRestAutentication.SetgrantType(const Value: string);
begin
  FgrantType := Value;
end;

procedure TVSMRestAutentication.Setpass(const Value: string);
begin
  Fpass := Value;
end;

procedure TVSMRestAutentication.SettimeOut(const Value: Integer);
begin
  FtimeOut := Value;
end;

procedure TVSMRestAutentication.SetToken(const Value: string);
begin
  FToken := Value;
end;

procedure TVSMRestAutentication.Seturl(const Value: string);
begin
  Furl := Value;
end;

procedure TVSMRestAutentication.Setuser(const Value: string);
begin
  Fuser := Value;
end;

{ TVSMRestAuthFactory }

class function TVSMRestAuthFactory.GetRestAuth(solucao: TSolucoesAuth; bAutenticacaoToken : Boolean = False): TVSMRestAutentication;
var
   restAuth: TVSMRestAutentication;
   wsWebService : TWebService;
begin
   try
      restAuth := TVSMRestAutentication.Create();
      wsWebService := TWebService.Create;
      try
         case solucao of
            VSMCard      : wsWebService := TVSMWebServiceUtils.GetWebService('OAC');
            VSMEcommerce : wsWebService := TVSMWebServiceUtils.GetWebService('OAT');
            Orizon       : wsWebService := TVSMWebServiceUtils.GetWebService('ORZ');
         end;

         restAuth.Type_Authorizarion_API := TVSMRestTipoAutenticacao(wsWebService.Type_Authorizarion_API);

         case restAuth.Type_Authorizarion_API of
            tpBasicAuth :
               begin
                  restAuth.Encode    := 'Basic ' + EncodeString(TVSMConfigLojaService.getInstance.LerString('PBM_ORIZON_USER') +':'+TVSMConfigLojaService.getInstance.LerString('PBM_ORIZON_PASS'));
                  restAuth.Token     := TVSMConfigLojaService.getInstance.LerString('PBM_ORIZON_APIKEY') ;
               end;
            tpOAuth2 :
               begin
                  restAuth.User      := wsWebService.Usuario;
                  restAuth.Pass      := wsWebService.Senha;
               end;
            tpBearerToken :
               begin
//                  restAuth.Token     := 'Bearer ' + wsWebService.ApiKeyLoja;
               end;
         end;

         restAuth.Url       := wsWebService.Url;
         restAuth.TimeOut   := 10000;
         restAuth.grantType := 'grant_type=client_credentials';
      finally
         wsWebService.Free;
      end;

      Result := restAuth;
   except
      on E:Exception do
      begin
         TVSMLogUtils.GetInstance.LogE('TVSMRestAuthFactory.GetRestAuth - Ocorreu uma falha ao retornar o conteúdo do WebService. ' + E.Message);
         raise;
      end;
   end;
end;

end.
