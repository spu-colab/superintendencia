# SPU-SC

---
## Requisitos

- PHP 7.2 ou superior
- Acesso a uma base de dados MySQL. É necessário que exista uma base de dados e um usuário associado com privilégio de administrador
    (o nome da base, usuário e senha serão usados instalação do aplicativo)

- Apache (ou qualquer servidor HTTP)
- Composer (Gerenciador de dependências/pacotes do PHP)

- Git (desejável)
- NPM/NodeJS (apenas para desenvolvimento front-end)

---
## Instalação

1. Baixar código fonte:
`git clone https://github.com/spu-colab/superintendencia.git spu`
Este comando faz o download do código fonte do projeto na pasta spu, este diretório será chamado a partir de agora de 'diretório do projeto'. 
Observe o caminho da pasta spu. Dependendo da forma de instalação, spu poderá ser uma subpasta. Ex. 'C:/xampp/spu'

2. No diretório do projeto, copie o arquivo .env.example como .env
    - Configure o arquivo `.env` com:
        - nome da aplicação
            - APP_NAME=escolha um nome. ex.:SPU-SC
        
        - credenciais de acesso à base de dados
            - DB_CONNECTION=mysql
		    - DB_HOST=127.0.0.1
	        - DB_PORT=3306
		    - DB_DATABASE=informe o nome da base aqui
		    - DB_USERNAME=usuário associado à base com privilégio de administrador
		    - DB_PASSWORD=senha do usuário
        
    - salve o arquivo .env e, no diretório do projeto, execute: php artisan key:generate
    
    - [incrementar documentação aqui]

3. Instalar as dependências do projeto:
no diretório do projeto:
`composer install`

4. Executar script de instalação:
`php artisan spu:instalar`

5. Configure o servidor http para servir a pasta `public` como raiz do serviço.
    No Apache isso é feito através no arquivo `httpd.conf`, diretiva `DocumentRoot`.
    * ex. substitua: 
		* DocumentRoot "/xampp/htdocs"
		* <Directory "/xampp/htdocs">
	* por 
		* DocumentRoot "/xampp/spu/public"
		* <Directory "/xampp/spu/public">

6. Pronto! Reinicie o servidor http e acesse http://localhost .

---

## Resolução de Problemas 

Está encontrando algum problema na utilização/manutenção desse projeto? Visite a página de Wiki [https://github.com/spu-colab/judiciais/wiki].
