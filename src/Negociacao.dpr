program Negociacao;

uses
  Forms,
  Principal in 'Telas\Principal.pas' {FormPrincipal},
  _ConexaoBanco in 'Biblioteca\_ConexaoBanco.pas',
  Ambiente in 'Biblioteca\Ambiente.pas',
  Biblioteca in 'Biblioteca\Biblioteca.pas',
  _FormBase in 'Telas\_FormBase.pas' {FormBase},
  CadastroPadrao in 'Telas\CadastroPadrao.pas' {FormCadastroPadrao},
  CadastroProdutor in 'Telas\CadastroProdutor.pas' {FormCadastroProdutor},
  CadastroDistribuidor in 'Telas\CadastroDistribuidor.pas' {FormCadastroDistribuidor},
  CadastroProduto in 'Telas\CadastroProduto.pas' {FormCadastroProduto},
  CadastroNegociacao in 'Telas\CadastroNegociacao.pas' {FormCadastroNegociacao},
  ManutencaoNegociacao in 'Telas\ManutencaoNegociacao.pas' {FormManutencaoNegociacao},
  PesquisaBase in 'Telas\PesquisaBase.pas' {FormPesquisaBase},
  PesquisaPessoa in 'Telas\PesquisaPessoa.pas' {FormPesquisaPessoa},
  PesquisaNegociacao in 'Telas\PesquisaNegociacao.pas' {FormPesquisaNegociacao},
  PesquisaProduto in 'Telas\PesquisaProduto.pas' {FormPesquisaProduto},
  RelacaoNegociacoes in 'Telas\RelacaoNegociacoes.pas' {FormRelacaoNegociacoes},
  BuscarCaminhoBanco in 'Telas\BuscarCaminhoBanco.pas' {FormBuscarCaminhoBanco};

{$R *.res}

begin
  Application.Initialize;

  Ambiente.IniciarAplicacao;

  Application.MainFormOnTaskBar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
