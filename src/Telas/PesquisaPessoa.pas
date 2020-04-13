unit PesquisaPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PesquisaBase, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Buttons, Vcl.ExtCtrls, Biblioteca;

type
  TFormPesquisaPessoa = class(TFormPesquisaBase)
    procedure FormCreate(Sender: TObject);
    procedure sgPesquisaEnter(Sender: TObject);
  private
    tipo_pessoa: string;
  end;

function PesquisarPessoa(_tipo_pessoa: string): Integer;

implementation

uses
  _Pessoa, Ambiente;

const
  cCodigo = 0;
  cNome   = 1;

{$R *.dfm}

procedure TFormPesquisaPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  IniciarGrid(
    sgPesquisa,
    [
      'Código',
      'Nome'
    ]
  );
end;

function PesquisarPessoa(_tipo_pessoa: string): Integer;
var
  form: TFormPesquisaPessoa;
begin
  Result := -1;
  form := TFormPesquisaPessoa.Create(Application);

  with form do begin
    if _tipo_pessoa = 'PRO' then
      caption := 'Pesquisa de Produtor'
    else
      caption := 'Pesquisa de Distribuidor';

    tipo_pessoa := _tipo_pessoa;

    if ShowModal = mrOk then
      Result := ValorInt(sgPesquisa.Cells[0, sgPesquisa.Row]);
  end;

  form.Free;
end;

procedure TFormPesquisaPessoa.sgPesquisaEnter(Sender: TObject);
var
  i: Integer;
  linha: Integer;
  filtro: string;
  dados: TArrayOfTDadosPessoaPesq;
begin
  inherited;

  if tipo_pessoa = 'PRO' then
    filtro := 'where TIPO_PESSOA = ''PRO'''
  else
    filtro := 'where TIPO_PESSOA = ''DIS''';

  eChave.Text := Trim(eChave.Text);
  if cbFiltros.ItemIndex = 0 then
    filtro := filtro + ' and RAZAO_SOCIAL like ''%' + eChave.Text + '%'''
  else if cbFiltros.ItemIndex = 1 then
    filtro := filtro + ' and NOME_FANTASIA like ''%' + eChave.Text + '%'''
  else
    filtro := filtro + ' and CPF_CNPJ = ' + QuotedStr(eChave.Text);


  filtro := filtro + ' order by RAZAO_SOCIAL';

  dados := _Pessoa.BuscaPessoaTelaPesquisa(Ambiente.con_banco, filtro);
  linha := sgPesquisa.FixedRows;
  for i := Low(dados) to High(dados) do begin
    sgPesquisa.Cells[cCodigo, linha] := FormatoMilharStr(dados[i].pessoa_id, 0);
    sgPesquisa.Cells[cNome, linha] := dados[i].nome;

    Inc(linha);
  end;

  if linha > sgPesquisa.RowCount then
    sgPesquisa.RowCount := linha;
end;

end.
