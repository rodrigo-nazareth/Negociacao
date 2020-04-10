unit PesquisaNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PesquisaBase, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Buttons, Vcl.ExtCtrls, Biblioteca;

type
  TFormPesquisaNegociacao = class(TFormPesquisaBase)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPesquisaNegociacao: TFormPesquisaNegociacao;

implementation

{$R *.dfm}

procedure TFormPesquisaNegociacao.FormCreate(Sender: TObject);
begin
  IniciarGrid(
    sgPesquisa,
    [
      'Código', 60,
      'Nome', 300
    ]
  );
end;

end.
