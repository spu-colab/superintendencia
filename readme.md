# SPU-SC

---
## Requisitos

- PHP 7.2 ou superior
- Acesso a uma base de dados MySQL
- Apache (ou qualquer servidor HTTP)
- Composer (Gerenciador de dependências/pacotes do PHP)

- Git (desejável)
- NPM/NodeJS (apenas para desenvolvimento front-end)

---
## Instalação

1. Baixar código fonte:
`git clone https://github.com/spu-colab/judiciais.git spu`
Este comando faz o download do código fonte do projeto na pasta `spu`, este diretório será chamado a partir de agora de 'diretório do projeto'.

2. Instalar as dependências do projeto:
no diretório do projeto:
`composer install`

3. Configurar o arquivo `.env` com:
    - nome da aplicação
    - a credencial de acesso à base de dados
    - [incrementar documentação aqui]

4. Executar script de instalação:
`php artisan spu:instalar`

5. Configure o servidor http para servir a pasta `public` como raiz do serviço.
    No Apache isso é feito através no arquivo `httpd.conf`, diretiva `DocumentRoot`.

6. Pronto! Reinicie o servidor http e acesse http://localhost .

---

## Resolução de Problemas 

Está encontrando algum problema na utilização/manutenção desse projeto? Visite a página de Wiki [https://github.com/spu-colab/judiciais/wiki].