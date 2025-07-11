@echo off
setlocal enabledelayedexpansion

:: Pergunta nome do projeto
set /p PROJECT_NAME=Digite o nome do projeto (ex: myapi): 
if "%PROJECT_NAME%"=="" (
    echo Nome do projeto não pode estar vazio!
    pause
    exit /b 1
)

:: Pergunta local do projeto
set /p PROJECT_LOCATION=Digite o caminho onde o projeto sera criado (deixe em branco para usar o diretorio atual): 
if "%PROJECT_LOCATION%"=="" (
    set PROJECT_LOCATION=%cd%
)

:: Caminho final
set PROJECT_PATH=%PROJECT_LOCATION%\%PROJECT_NAME%

echo Criando projeto em: %PROJECT_PATH%
mkdir "%PROJECT_PATH%"
cd /d "%PROJECT_PATH%"

:: Inicializar projeto com UV
echo Inicializando projeto com Astral UV...
uv init .

:: Instalar dependências
echo Instalando dependências...
uv sync
uv add fastapi[standard] pydantic Black

:: Criar estrutura DDD
echo Criando estrutura DDD...
mkdir src\

mkdir src\api
mkdir src\api\controllers
echo. > src\api\main.py

mkdir src\domain
mkdir src\domain\models
mkdir src\domain\interfaces

mkdir src\application
mkdir src\application\services
mkdir src\application\interfaces
mkdir src\application\dtos

mkdir src\infra
mkdir src\infra\database
mkdir src\infra\database\repositories

mkdir tests

:: Criar arquivos básicos
echo Criando arquivos iniciais...

:: main.py
(
  echo from fastapi import FastAPI
  echo.
  echo app = FastAPI()
  echo.
  echo @app.get("/")
  echo def read_root():
  echo     return {"message": "Hello from %PROJECT_NAME%!"}
) > src\api\main.py

:: Create .env
echo. > .env


:: __init__.py
echo. > src\__init__.py
echo. > src\api\__init__.py
echo. > src\api\controllers\__init__.py

echo. > src\domain\__init__.py
echo. > src\domain\entities\__init__.py
echo. > src\domain\interfaces\__init__.py

echo. > src\application\__init__.py
echo. > src\application\services\__init__.py
echo. > src\application\interfaces\__init__.py
echo. > src\application\dtos\__init__.py

echo. > src\infra\__init__.py
echo. > src\infra\database\__init__.py
echo. > src\infra\database\repositories\__init__.py
echo. > tests\__init__.py

if exist hello.py (
    echo Removendo hello.py criado pelo uv...
    del /f /q hello.py
)

:: Final
echo.
echo Projeto criado com sucesso usando Astral UV!
echo.
echo Para iniciar:
echo cd "%PROJECT_PATH%"
echo uv run uvicorn src.%PROJECT_NAME%.main:app --reload
pause