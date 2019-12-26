<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

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
    protected $description = 'Gera um arquivo de backup contendo os dumps das bases de dados e o fonte da base de conhecimento (wordpress)';

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
        $diretorioBackup = env('BACKUP_PATH_WORDPRESS');
        $arquivosGerados = [];

        echo "Efetuando backup dos arquivos..." . PHP_EOL;

        // wordpress
        $arquivoGerado = $this->comprimirDiretorio(
            \realpath(base_path() . '/../htdocs/wordpress'),
            'wordpress', 
            $diretorioBackup);
        array_push($arquivosGerados, $arquivoGerado);

        // $arquivoGerado = TODO dump da base
        // array_push($arquivosGerados, $arquivoGerado);

        $this->limparAntigos($diretorioBackup, $arquivosGerados);
    }

    private function comprimirDiretorio($diretorioOrigem, $nomeArquivoComprido, $diretorioDestino) {
        $nomeArquivoComprido = date('Y-m-d_H_i') . '_' . $nomeArquivoComprido . '.zip';

        $zip = new \ZipArchive();
        $zip->open(
            $diretorioDestino . DIRECTORY_SEPARATOR . $nomeArquivoComprido, 
            \ZipArchive::CREATE | \ZipArchive::OVERWRITE);

        $files = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($diretorioOrigem));
        $totalArquivos = 0;
        foreach($files as $name => $file) {
            if (!$file->isDir()) {
                $filePath = $file->getRealPath();
                echo "\r";
                echo 'Arquivos encontrados ' . $totalArquivos;
                $relativePath = substr($filePath, strlen($diretorioOrigem) + 1);
                $zip->addFile($filePath, $relativePath);
                $totalArquivos++;
            }
        }
        echo PHP_EOL . 'Comprimindo arquivos em ' . $diretorioDestino . DIRECTORY_SEPARATOR . $nomeArquivoComprido . '...';
        $zip->close();
        echo ' concluído.'. PHP_EOL;
        return $diretorioDestino . DIRECTORY_SEPARATOR . $nomeArquivoComprido;
    }

    private function limparAntigos($diretorioBackup, $naoExcluirEstesArquivos = [])
    {
        echo 'Iniciando a limpeza de arquivos antigos de backup em '. $diretorioBackup . PHP_EOL;
        $files = new \DirectoryIterator($diretorioBackup);
        foreach($files as $fileInfo) {
            $file = $fileInfo->getPathname();
            if(is_file($file)) {
                $diasArquivo = $this->idadeDoArquivoEmDias($file);
                if($diasArquivo == 0) {
                    if(!\in_array($file, $naoExcluirEstesArquivos)) {
                        $this->excluirArquivo($file);
                    }
                } else {
                    if($diasArquivo > 7) {
                        $this->excluirArquivo($file);
                    }
                }
            }
        }
    }
    
    private function idadeDoArquivoEmDias($arquivo) {
        $hoje = new \DateTime(date('Y-m-d'));
        $dataArquivo = date('Y-m-d', filemtime($arquivo));
        $dataArquivo = new \DateTime($dataArquivo);
        $idadeArquivo = $dataArquivo->diff($hoje);
        $diasArquivo = $idadeArquivo->d;
    }
    
    private function excluirArquivo($arquivo) {
        echo 'Excluindo ' . $arquivo . '...' . PHP_EOL;
        unlink($arquivo);
    }
}
