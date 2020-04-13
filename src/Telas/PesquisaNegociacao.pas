unit PesquisaNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PesquisaBase, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Buttons, Vcl.ExtCtrls, Biblioteca;

type
  TFormPesquisaNegociacao = class(TFormPesquisaBase)
    procedure FormCreate(Sender: TObject);
    procedure sgPesquisaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function PesquisarNegociacao: Integer;

implementation

uses
  _Negociacao, Ambiente;

const
  cCodigo       = 0;
  cProdutor     = 1;
  cDistribuidor = 2;
  cStatus       = 3;

{$R *.dfm}

procedure TFormPesquisaNegociacao.FormCreate(Sender: TObject);
begin
  IniciarGrid(
    sgPesquisa,
    [
      'Código',
      'Produtor',
      'Distribuidor',
      'Status'
    ]
  );
end;

function PesquisarNegociacao: Integer;
var
  form: TFormPesquisaNegociacao;
begin
  Result := -1;
  form := TFormPesquisaNegociacao.Create(Application);

  with form do begin
    if ShowModal = mrOk then
      Result := ValorInt(sgPesquisa.Cells[0, sgPesquisa.Row]);
  end;

  form.Free;
end;

procedure TFormPesquisaNegociacao.sgPesquisaEnter(Sender: TObject);
var
  i: Integer;
  linha: Integer;
  filtro: string;
  dados: TArrayOfTDadosNegociacaoPesq;
begin
  inherited;

  if (cbFiltros.ItemIndex = 0) and (ValorInt(eChave.Text) = 0) then begin
    Exclamar('É necessário informar um código para pesquisa!');
    Abort;
  end;

  eChave.Text := Trim(eChave.Text);

  filtro := filtro + 'where 1=1';
  if cbFiltros.ItemIndex = 0 then
    filtro := filtro + ' and NEG.NEGOCIACAO_ID = ' + SomenteNumeros(eChave.Text)
  else if cbFiltros.ItemIndex = 1 then
    filtro := filtro + ' and PRD.RAZAO_SOCIAL like ''%' + eChave.Text + '%'''
  else
    filtro := filtro + ' and DIS.RAZAO_SOCIAL like ''%' + eChave.Text + '%''';

  dados := _Negociacao.BuscaNegociacaoTelaPesquisa(Ambiente.con_banco, filtro);
  linha := sgPesquisa.FixedRows;
  for i := Low(dados) to High(dados) do begin
    sgPesquisa.Cells[cCodigo, linha] := FormatoMilharStr(dados[i].negociacao_id, 0);
    sgPesquisa.Cells[cProdutor, linha] := dados[i].nome_produtor;
    sgPesquisa.Cells[cDistribuidor, linha] := dados[i].nome_distribuidor;
    sgPesquisa.Cells[cStatus, linha] := dados[i].status;

    Inc(linha);
  end;

  if linha > sgPesquisa.RowCount then
    sgPesquisa.RowCount := linha;
end;

end.
