unit PesquisaPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PesquisaBase, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Buttons, Vcl.ExtCtrls, Biblioteca;

type
  TFormPesquisaPessoa = class(TFormPesquisaBase)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function PesquisarPessoa(tipo_pessoa: string): Integer;

implementation

{$R *.dfm}

procedure TFormPesquisaPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  IniciarGrid(
    sgPesquisa,
    [
      'Código', 60,
      'Nome', 150
    ]
  );
end;

function PesquisarPessoa(tipo_pessoa: string): Integer;
var
  form: TFormPesquisaPessoa;
begin
  Result := -1;
  form := TFormPesquisaPessoa.Create(Application);

  if tipo_pessoa = 'PRO' then
    form.caption := 'Pesquisa de Produtor'
  else
    form.caption := 'Pesquisa de Distribuidor';

  if form.ShowModal = mrOk then
    Result := StrToInt(form.sgPesquisa.Cells[form.sgPesquisa.Col, form.sgPesquisa.Row]);

  form.Free;
end;

end.
