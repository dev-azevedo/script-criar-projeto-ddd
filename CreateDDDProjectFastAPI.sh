#!/bin/bash

set -e  # Interrompe em caso de erro

# Pergunta nome do projeto
read -p "Digite o nome do projeto (ex: myapi): " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    echo "Nome do projeto não pode estar vazio!"
    exit 1
fi

# Pergunta local do projeto
read -e -p "Digite o caminho onde o projeto será criado (deixe em branco para usar o diretório atual): " PROJECT_LOCATION
PROJECT_LOCATION="${PROJECT_LOCATION:-$(pwd)}"
PROJECT_LOCATION="${PROJECT_LOCATION%/}"  # Remove barra final, se houver
PROJECT_LOCATION=$(realpath "$PROJECT_LOCATION")  # Resolve caminho absoluto

# Caminho final
PROJECT_PATH="$PROJECT_LOCATION/$PROJECT_NAME"

echo "Criando projeto em: $PROJECT_PATH"
mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH"

# Inicializar projeto com UV
echo "Inicializando projeto com Astral UV..."
uv init .

# Instalar dependências
echo "Instalando dependências..."
uv sync
uv add fastapi[standard] pydantic black

# Criar estrutura DDD
echo "Criando estrutura DDD..."
mkdir -p src/api/controllers
mkdir -p src/domain/models
mkdir -p src/domain/interfaces
mkdir -p src/application/services
mkdir -p src/application/interfaces
mkdir -p src/application/dtos
mkdir -p src/infra/database/repositories
mkdir -p tests

# main.py
cat <<EOF > src/api/main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from $PROJECT_NAME!"}
EOF

# Arquivos .env e __init__.py
touch .env
touch src/__init__.py
touch src/api/__init__.py
touch src/api/controllers/__init__.py
touch src/domain/__init__.py
touch src/domain/models/__init__.py
touch src/domain/interfaces/__init__.py
touch src/application/__init__.py
touch src/application/services/__init__.py
touch src/application/interfaces/__init__.py
touch src/application/dtos/__init__.py
touch src/infra/__init__.py
touch src/infra/database/__init__.py
touch src/infra/database/repositories/__init__.py
touch tests/__init__.py

# Remove hello.py criado automaticamente pelo uv
if [ -f hello.py ]; then
    echo "Removendo hello.py criado pelo uv..."
    rm -f hello.py
fi

# Final
echo
echo "✅ Projeto criado com sucesso usando Astral UV!"
echo
echo "📁 Caminho do projeto: $PROJECT_PATH"
echo
echo "Para iniciar:"
echo "cd \"$PROJECT_PATH\""
echo "uv run uvicorn src.api.main:app --reload"
