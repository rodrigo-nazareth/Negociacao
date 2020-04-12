program Negociacao;

uses
  Forms,
  Principal in 'Telas\Principal.PAS' {FormPrincipal},
  _ConexaoBanco in 'Biblioteca\_ConexaoBanco.pas',
  Ambiente in 'Biblioteca\Ambiente.pas',
  Biblioteca in 'Biblioteca\Biblioteca.pas',
  _FormBase in 'Telas\_FormBase.pas' {FormBase},
  CadastroBase in 'Telas\CadastroBase.pas' {FormCadastroBase},
  CadastroPessoa in 'Telas\CadastroPessoa.pas' {FormCadastroPessoa},
  CadastroProduto in 'Telas\CadastroProduto.pas' {FormCadastroProduto},
  CadastroNegociacao in 'Telas\CadastroNegociacao.pas' {FormCadastroNegociacao},
  ManutencaoNegociacao in 'Telas\ManutencaoNegociacao.pas' {FormManutencaoNegociacao},
  PesquisaBase in 'Telas\PesquisaBase.pas' {FormPesquisaBase},
  PesquisaPessoa in 'Telas\PesquisaPessoa.pas' {FormPesquisaPessoa},
  PesquisaNegociacao in 'Telas\PesquisaNegociacao.pas' {FormPesquisaNegociacao},
  PesquisaProduto in 'Telas\PesquisaProduto.pas' {FormPesquisaProduto},
  RelacaoNegociacoes in 'Telas\RelacaoNegociacoes.pas' {FormRelacaoNegociacoes},
  BuscarCaminhoBanco in 'Telas\BuscarCaminhoBanco.pas' {FormBuscarCaminhoBanco},
  _Pessoa in 'Banco\_Pessoa.pas';

{$R *.res}

begin
  Application.Initialize;

  Ambiente.IniciarAplicacao;

  Application.MainFormOnTaskBar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
