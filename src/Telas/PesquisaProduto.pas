unit PesquisaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PesquisaBase, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Buttons, Vcl.ExtCtrls, Biblioteca, _Produto;

type
  TFormPesquisaProduto = class(TFormPesquisaBase)
    procedure FormCreate(Sender: TObject);
    procedure sgPesquisaEnter(Sender: TObject);
  end;

function PesquisarProduto: Integer;

implementation

uses Ambiente;

const
  cCodigo = 0;
  cNome   = 1;

{$R *.dfm}

procedure TFormPesquisaProduto.FormCreate(Sender: TObject);
begin
  IniciarGrid(sgPesquisa, ['Código', 'Nome']);
end;

function PesquisarProduto: Integer;
var
  form: TFormPesquisaProduto;
begin
  Result := -1;
  form := TFormPesquisaProduto.Create(Application);

  if form.ShowModal = mrOk then
    Result := ValorInt(form.sgPesquisa.Cells[0, form.sgPesquisa.Row]);

  form.Free;
end;

procedure TFormPesquisaProduto.sgPesquisaEnter(Sender: TObject);
var
  i: Integer;
  linha: Integer;
  filtro: string;
  dados: TArrayOfWebProduto;
begin
  inherited;
  eChave.Text := Trim(eChave.Text);

  filtro := 'where NOME like ''%' + eChave.Text + '%'' order by NOME';

  dados := _Produto.BuscarProdutos(Ambiente.con_banco, filtro);
  linha := sgPesquisa.FixedRows;
  for i := Low(dados) to High(dados) do begin
    sgPesquisa.Cells[cCodigo, linha] := FormatoMilharStr(dados[i].produto_id, 0);
    sgPesquisa.Cells[cNome, linha] := dados[i].nome;

    Inc(linha);
  end;

  if linha > sgPesquisa.RowCount then
    sgPesquisa.RowCount := linha;
end;

end.
