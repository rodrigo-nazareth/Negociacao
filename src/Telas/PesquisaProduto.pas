unit PesquisaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PesquisaBase, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Buttons, Vcl.ExtCtrls, Biblioteca;

type
  TFormPesquisaProduto = class(TFormPesquisaBase)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFormPesquisaProduto.FormCreate(Sender: TObject);
begin
  IniciarGrid(
    sgPesquisa,
    [
      'Código', 60,
      'Nome', 150
    ]
  );
end;

end.
