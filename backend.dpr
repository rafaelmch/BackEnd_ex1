program backend;

{
developed by / desenvolvido por:
Rafael Hassegawa
rafaelmch@gmail.com
+55 31 998866863
}

{$APPTYPE CONSOLE}

{$R *.res}

uses Horse, System.SysUtils, Horse.Jhonson, System.JSON, Horse.BasicAuthentication;

begin
  THorse.Use(Jhonson);

  //basic authentication / autenticação básica
  THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
      // Here inside you can access your database and validate if username and password are valid
      Result := AUsername.Equals('rafaelmch') and APassword.Equals('Rafa1982;');
    end));

  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Writeln('Request GET / ping'); //log
      Res.Send('pong');
    end);

    //endpoint cliente
  THorse.Get('/cliente',
    procedure(Req: THorseRequest; Res: THorseResponse)
    var
      clientes : TJsonArray;
    begin
      try
        clientes := TJsonArray.Create;
        //adding a client / adicionando cliente
        clientes.add(TJsonObject.Create(TJsonPair.Create('nome','Rafael Hassegawa')));
        //adding a client / adicionando cliente
        clientes.add(TJsonObject.Create(TJsonPair.Create('nome','Lisa Hassegawa')));
        //adding a client / adicionando cliente
        clientes.add(TJsonObject.Create(TJsonPair.Create('nome','Emilio Hassegawa')));
        //adding a client / adicionando cliente
        clientes.add(TJsonObject.Create(TJsonPair.Create('nome','Lisa Hassegawa')));
        //adding a client / adicionando cliente
        clientes.add(TJsonObject.Create(TJsonPair.Create('nome','Marina Hassegawa')));

        //log
        Writeln('Request GET / ping');

        Res.Send<TJsonArray>(clientes);
      except on ex:exception do
        Res.Send(tjsonObject.Create.AddPair('Mensagem', ex.Message)).Status(500);
      end;
    end);

  THorse.Post('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LBody: TJSONObject;
    begin
      // Req.Body gives access to the content of the request in string format.
      // Req.Body dá acesso ao conteúdo do request em formato string
      // Using jhonson middleware, we can get the content of the request in JSON format.
      // Usando jhnson middleware, conseguimos obter o conteúdo do request em formato JSon.

      LBody := Req.Body<TJSONObject>;
      Res.Send<TJSONObject>(LBody);
    end);

  THorse.Listen(9000);
end.
