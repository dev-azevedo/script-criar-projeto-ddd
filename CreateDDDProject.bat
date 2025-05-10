@echo off
setlocal enabledelayedexpansion

:: Solicita o nome do projeto
set /p PROJECT_NAME=Digite o nome do projeto: 
if "%PROJECT_NAME%"=="" (
    echo Nome do projeto nao pode ser vazio!
    pause
    exit /b 1
) 

:: Solicita o local onde o projeto será criado
set /p PROJECT_LOCATION=Digite o caminho onde o projeto sera criado (deixe em branco para usar o diretorio atual): 
if "%PROJECT_LOCATION%"=="" (
    set PROJECT_LOCATION=%cd%
)

:: Configurações
set SOLUTION_NAME=%PROJECT_NAME%
set SRC_FOLDER=src
set TEST_FOLDER=test
set DOMAIN_FOLDER=%SRC_FOLDER%\%PROJECT_NAME%.Domain
set INFRA_FOLDER=%SRC_FOLDER%\%PROJECT_NAME%.Infra
set APPLICATION_FOLDER=%SRC_FOLDER%\%PROJECT_NAME%.Application
set API_FOLDER=%SRC_FOLDER%\%PROJECT_NAME%.Api

:: Criar pasta do projeto
echo ***Criando pasta do projeto em: %PROJECT_LOCATION%\%PROJECT_NAME%
mkdir "%PROJECT_LOCATION%\%PROJECT_NAME%"
if not exist "%PROJECT_LOCATION%\%PROJECT_NAME%" (
    echo Falha ao criar a pasta do projeto!
    pause
    exit /b 1
)

:: Entrar na pasta do projeto
cd /d "%PROJECT_LOCATION%\%PROJECT_NAME%"

:: Criar arquivo .gitignore
echo ***Criando arquivo .gitignore...
echo # Git ignore for .NET > .gitignore
echo bin/ >> .gitignore
echo obj/ >> .gitignore
echo .vs/ >> .gitignore
echo .vscode/ >> .gitignore
echo *.user >> .gitignore
echo *.suo >> .gitignore
echo *.cache >> .gitignore
echo *.swp >> .gitignore
echo packages/ >> .gitignore
echo TestResults/ >> .gitignore
echo [Dd]ebug/ >> .gitignore
echo [Rr]elease/ >> .gitignore
echo [Bb]in/ >> .gitignore
echo [Oo]bj/ >> .gitignore
echo appsettings.Development.json >> .gitignore
echo .DS_Store >> .gitignore
echo *.log >> .gitignore
echo *.env >> .gitignore
echo launchSettings.json >> .gitignore

:: Criar arquivo README.md
echo ***Criando README.md...
echo # %PROJECT_NAME% > README.md
echo. >> README.md
echo ## Descrição >> README.md
echo Projeto criado com arquitetura DDD (Domain-Driven Design) >> README.md
echo. >> README.md
echo ## Estrutura do Projeto >> README.md
echo - **Domain**: Contém os modelos e interfaces do domínio >> README.md
echo - **Application**: Lógica de aplicação, serviços, DTOs e validadores >> README.md
echo - **Infra**: Implementações de infraestrutura (Banco de dados, repositórios, Api's externas) >> README.md
echo - **Api**: Camada de apresentação (Web API) >> README.md
echo. >> README.md
echo ## Como Executar >> README.md
echo 1. Restaure os pacotes: ```dotnet restore``` >> README.md
echo 2. Execute a API: ```dotnet run --project src/Api``` >> README.md
echo. >> README.md
echo ## Tecnologias Utilizadas >> README.md
echo - .NET >> README.md
echo - ASP.NET Core >> README.md

:: Criar solution
echo ***Criando solution %SOLUTION_NAME%...
dotnet new sln -n %SOLUTION_NAME%

:: Criar pasta src
echo ***Criando pasta %SRC_FOLDER%...
mkdir %SRC_FOLDER%

:: Criar pasta test
echo ***Criando pasta %TEST_FOLDER%...
mkdir %TEST_FOLDER%

:: Criar projetos
echo ***Criando projetos...

:: Domain
echo ***Criando projeto Domain...
dotnet new classlib -n Domain -o %DOMAIN_FOLDER%
mkdir %DOMAIN_FOLDER%\Models
mkdir %DOMAIN_FOLDER%\Interfaces

:: Infra
echo ***Criando projeto Infra...
dotnet new classlib -n Infra -o %INFRA_FOLDER%
mkdir %INFRA_FOLDER%\Database
mkdir %INFRA_FOLDER%\Database\Context
mkdir %INFRA_FOLDER%\Database\Repositories

:: Application
echo ***Criando projeto Application...
dotnet new classlib -n Application -o %APPLICATION_FOLDER%
mkdir %APPLICATION_FOLDER%\Dto
mkdir %APPLICATION_FOLDER%\Interfaces
mkdir %APPLICATION_FOLDER%\Mappers
mkdir %APPLICATION_FOLDER%\Services
mkdir %APPLICATION_FOLDER%\Validator

:: Api
echo ***Criando projeto Api...
dotnet new webapi -n Api -o %API_FOLDER%
mkdir %API_FOLDER%\Setup

:: Adicionar projetos à solution
echo ***Adicionando projetos a solution...
dotnet sln add %DOMAIN_FOLDER%\Domain.csproj
dotnet sln add %INFRA_FOLDER%\Infra.csproj
dotnet sln add %APPLICATION_FOLDER%\Application.csproj
dotnet sln add %API_FOLDER%\Api.csproj

:: Adicionar referências entre projetos
echo ***Configurando dependencias entre projetos...

:: Application depende de Domain
dotnet add %APPLICATION_FOLDER%\Application.csproj reference %DOMAIN_FOLDER%\Domain.csproj

:: Infra depende de Domain e Application
dotnet add %INFRA_FOLDER%\Infra.csproj reference %DOMAIN_FOLDER%\Domain.csproj
dotnet add %INFRA_FOLDER%\Infra.csproj reference %APPLICATION_FOLDER%\Application.csproj

:: Api depende de Application e Infra
dotnet add %API_FOLDER%\Api.csproj reference %APPLICATION_FOLDER%\Application.csproj
dotnet add %API_FOLDER%\Api.csproj reference %INFRA_FOLDER%\Infra.csproj

echo ***Estrutura do projeto DDD criada com sucesso!
echo ***Solution: %SOLUTION_NAME%.sln
echo ***Local do projeto: %PROJECT_LOCATION%\%PROJECT_NAME%
echo ***Projetos criados em: %SRC_FOLDER%\
echo ***Tests criados em: %TEST_FOLDER%\
echo ***By: Jhonatan Azevedo - @dev-azevedo
pause