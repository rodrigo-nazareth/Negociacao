unit _PesquisaGenericaFrame;

interface

uses
  _ConexaoBanco;

type
  TRetornoFrameConsulta = record
    codigo: Integer;
    nome: string;
  end;
  TArrayOfTRetornoFrameConsulta = array of TRetornoFrameConsulta;

function BuscarDadosFrame(con: TConexaoBanco; consulta: string): TArrayOfTRetornoFrameConsulta;

implementation

function BuscarDadosFrame(con: TConexaoBanco; consulta: string): TArrayOfTRetornoFrameConsulta;
var
  i: Integer;
  pesq: TPesquisa;
begin
  Result := nil;
  pesq := con.NovaPesquisa;

  pesq.SQL.Add(consulta);
  pesq.SQL.Add('order by');
  pesq.SQL.Add('  NOME');

  if pesq.Pesquisar then begin
    i := 0;
    pesq.First;
    while not pesq.Eof do begin
      SetLength(Result, Length(Result) + 1);

      Result[i].codigo := pesq.AsColunaInt('CODIGO');
      Result[i].nome := pesq.AsColunaString('NOME');

      Inc(i);
      pesq.Next;
    end;
  end;

  pesq.Active := False;
  pesq.Free;
end;

end.
