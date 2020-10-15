<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\BaseZero;
use App\Permissao;
use App\UsuarioPermissao;

use App\User;
use Modules\Auth\Entities\DivisaoOrganograma;
use Modules\Auth\Entities\UsuarioDivisaoOrganograma;

class ConfiguracaoInicialCmd extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'spu:instalar';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Realiza a confiuração inicial do sistema';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
        $this->cabecalho = ["Script", "Situação"];
        $this->scripts = array();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $spu_conf = include(base_path('config/spu.php'));
        $this->config = $spu_conf['backup'];
        $this->efetuarConfiguracao();

    }

    private function efetuarConfiguracao() {
        $this->error("*** !!! ATENÇÃO !!! ***");
        $this->info("Este script inicializa todas as tabelas de banco de dados. Somente execute-o em uma instalação pré-existente caso realmente deseje limpar todos os dados do sistema.");

        # if($this->confirm("Deseja realmente continuar?")) {
            $this->executarScriptsBaseZero();
            $this->executarMigracoes();
            $this->alimentarTabelasApoio();
            $administrador = $this->criarUsuarioAdministrador();
            $this->concederPermissoes($administrador);
            $this->criarSuperintendencia();
            $this->info("Configuração finalizada");
        # }
    }

    private function executarScriptsBaseZero() {
        $this->info("Executando os scripts de criação das tabelas de banco de dados...");
        $files = scandir(base_path("sql/scripts/"));
        foreach ($files as $f => $file) {
            if(strpos($file, "base_zero") === 0 && strpos($file, ".sql") === strlen($file) - strlen(".sql")) {
                $this->scripts[] = [$file, "Aguardando"];
            }
        }
        $this->imprimeSituacaoScripts();
        
        foreach($this->scripts as $scriptRow) {
            $this->executarScript($scriptRow[0]);
        }
    }

    private function executarMigracoes() {
        $this->info("Executando migrações...");
        $this->call('migrate');
    }

    private function alimentarTabelasApoio() {
        $baseZero = new BaseZero();
        $baseZero->inserirRegistros();
    }

    private function concederPermissoes($usuario) {
        $permissoes = Permissao::all();
        foreach ($permissoes as $p => $permissao) {
            $usuarioPermissao = new UsuarioPermissao();
            $usuarioPermissao->idUsuario = $usuario->id;
            $usuarioPermissao->idPermissao = $permissao->id;
            $usuarioPermissao->saveOrFail();
        }
    }    

    private function executarScript($filename) {
        $query = file_get_contents(base_path("sql/scripts/") . $filename);
        $this->atualizarSituacaoScript($filename, "Executando");
        $query = str_replace("{{ORIGEM_PADRAO}}", User::ORIGEM_PADRAO, $query);

        DB::beginTransaction();
        $resultado = DB::unprepared($query);
        if($resultado) {
            $this->atualizarSituacaoScript($filename, "Pronto");
        } else {
            $this->atualizarSituacaoScript($filename, "Erro");
            DB::rollBack();
        }
        DB::commit();
    }

    private function imprimeSituacaoScripts() {
        if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
            system('cls');
        } else {
            system('clear');
        }
        $this->table($this->cabecalho, $this->scripts);
    }

    private function atualizarSituacaoScript($filename, $situacao) {
        foreach($this->scripts as $s => $script) {
            if($this->scripts[$s][0] == $filename) {
                $this->scripts[$s][1] = $situacao;
                break;
            }
        }
        $this->imprimeSituacaoScripts();
    }

    private function criarUsuarioAdministrador() {
        $this->info("Dados do Administrador do Sistema:");

        $name = $this->ask("Nome:", "Administrador");
        
        $email = $this->ask("E-mail:", "informe@email.valido");

        $cpf = "";
        while(@strlen($cpf) < 11) {
            $cpf = $this->ask("CPF (somente números):", "00000000000");
        }

        $password = "";
        while(@strlen($password) < 8) {
            $password = $this->secret("Senha:");
        }

        $user = User::create([
            'name' => $name,
            'email' => $email,
            'cpf' => $cpf,
            'password' => Hash::make($password)
        ]);
        $user->saveOrFail();
        $this->info("id do usuario criado " . $user->id);
        return $user;
    }

    private function criarSuperintendencia() {
        #$this->info("Dados da Superintendência");

        #$this->ask("Nome:", "Superintendência do Patrimônio da União em Santa Catarina");
        $nome = "Secretaria de Coordenação e Governança do Patrimônio da União";
        
        #$this->ask("Sigla:", "SPU-SC");
        $sigla = "SPU";

        $superintendencia = new DivisaoOrganograma([
            'nome' => $nome,
            'sigla' => $sigla,
            'snSuperintendencia' => 1
        ]);
        $superintendencia->saveOrFail();
        $this->info("id DivisaoOrganograma criado: " . $superintendencia->id);
        return $superintendencia;
    }
    
}
