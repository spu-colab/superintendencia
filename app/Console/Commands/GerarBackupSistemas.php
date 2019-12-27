<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Str;

class GerarBackupSistemas extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'spu:backup';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Gera arquivos de backup conforme configuração contida em /config/spu.php';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
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
        $this->efetuarBackup();
    }

    private function efetuarBackup() {

        $this->ajustarConfiguracao();

        foreach ($this->config['origem']['arquivos'] as $nome_backup => $config) {
            $this->info("Efetuando backup dos arquivos de '$nome_backup'...");
            $arquivoGerado = $this->comprimirDiretorio(
                $nome_backup, 
                $config,
                \realpath($this->config['destino']));
            $this->limparAntigos($this->config['destino'], $arquivoGerado);
        }
    }
        
    private function comprimirDiretorio($nomeArquivoComprido, $config, $diretorioDestino) {
        $nomeArquivoComprido = date('Y-m-d_H_i') . '_' . $nomeArquivoComprido . '.zip';

        $zip = new \ZipArchive();
        $zip->open(
            $diretorioDestino . DIRECTORY_SEPARATOR . $nomeArquivoComprido, 
            \ZipArchive::CREATE | \ZipArchive::OVERWRITE);

        $diretorioOrigem = \realpath($config['caminho_origem']);
        $files = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($diretorioOrigem));
        $totalArquivos = 0;
        foreach($files as $name => $file) {
            if($this->ignorarArquivo($file, $config)) {
                continue;
            }
            if ($file->isFile()) {
                $filePath = $file->getRealPath();
                echo "\r";
                echo 'Arquivos encontrados ' . $totalArquivos;
                $relativePath = substr($filePath, strlen($diretorioOrigem) + 1);
                $zip->addFile($filePath, $relativePath);
                $totalArquivos++;
            }
        }
        $this->info('Comprimindo arquivos em ' . $diretorioDestino . DIRECTORY_SEPARATOR . $nomeArquivoComprido . '...');
        $zip->close();
        $this->info(' concluído.');
        return $diretorioDestino . DIRECTORY_SEPARATOR . $nomeArquivoComprido;
    }

    private function limparAntigos($diretorioBackup, $ultimoArquivoGerado)
    {
        $this->info('Iniciando a limpeza de arquivos antigos de backup em '. $diretorioBackup . PHP_EOL);

        $explode = explode(DIRECTORY_SEPARATOR, $ultimoArquivoGerado);
        $sufixoUltimoArquivoGerado = $explode[sizeof($explode)-1];
        $sufixoUltimoArquivoGerado = substr($sufixoUltimoArquivoGerado, 16);

        $files = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($diretorioBackup));
        foreach($files as $name => $file) {
            if(is_file($file)) {
                if(!Str::endsWith($name, $sufixoUltimoArquivoGerado)) {
                    continue;
                }
                $diasArquivo = $this->idadeDoArquivoEmDias($file);            
                if($diasArquivo > $this->config['idadeMaximaDosArquivosEmDias']) {
                    $this->excluirArquivo($file);
                }
            }
        }
    }
    
    private function idadeDoArquivoEmDias($arquivo) {
        $hoje = new \DateTime(date('Y-m-d'));
        $dataArquivo = date('Y-m-d', filemtime($arquivo));
        $dataArquivo = new \DateTime($dataArquivo);
        $idadeArquivo = $dataArquivo->diff($hoje);
        return $idadeArquivo->d;
    }
    
    private function excluirArquivo($arquivo) {
        $this->info('Excluindo ' . $arquivo . '...');
        unlink($arquivo);
    }

    private function ignorarArquivo($file, $config) {
        if(!is_array(@$config['ignorar'])) {
            return false;
        }
        foreach ($config['ignorar'] as $diretorioIgnorar) {
            if(\stripos($file, $diretorioIgnorar) === 0) {
                return true;
            }
        }
        return false;
     }

     private function ajustarConfiguracao() {
        foreach ($this->config['origem']['arquivos'] as $nome_backup => $config) {
            if(is_array(@$config['ignorar'])) {
                foreach ($config['ignorar'] as $i => $diretorioIgnorar) {
                    $diretorioIgnorar = $config['caminho_origem'] . DIRECTORY_SEPARATOR . $diretorioIgnorar;
                    $diretorioIgnorar = \realpath($diretorioIgnorar);
                    $this->config['origem']['arquivos'][$nome_backup]['ignorar'][$i] = $diretorioIgnorar;
                }
            }
        }
    }
}
