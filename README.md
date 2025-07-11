# 💡 Script para criar projeto DDD com .Net ou FastAPI by:Jhonatan Azevedo💡

![GIF animado](https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZGEzYW95eWNmc3M3azk0eWw3aWM2ZzJzZ3djNmFuNWtzYTBvdmE3MSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/fw1im4D3MOLJnqm8TZ/giphy.gif)

## ⚙️ Requisitos
- .Net SDK 6.0 ou superior
 - Astral UV



## 📝 Descrição
Esse script cria um projeto DDD

### Estrutura do projeto com .Net com:
```

├── src
│   ├── Domain
│   │   ├── Domain.csproj
│   │   ├── Interfaces
│   │   └── Models
│   ├── Infra
│   │   ├── Infra.csproj
│   │   ├── Database
│   │   │   ├── Context
│   │   │   └── Repositories
│   ├── Application
│   │   ├── Application.csproj
│   │   ├── Dto
│   │   ├── Interfaces
|   |   ├── Validators
|   |   └── Services
│   │   └── Mappers
│   └── Api
│       ├── Api.csproj
│       ├── Setup
│       └── Controllers
│           
├── test
├── README.md
├── .gitignore
└── solution.sln
```

--- 

### Estrutura do projeto com FastAPI:
```

├── src
│   ├── domain
│   │   ├── interfaces
│   │   └── models
│   ├── infra
│   │   ├── database
│   │   │   └── repositories
│   ├── application
│   │   ├── dto
│   │   ├── interfaces
|   |   └── services
│   └── api
│       ├── main.py
│       └── controllers
│           
├── test
├── README.md
├── .gitignore
├── .python-version
├── pyproject.toml
└── uv.lock
```

--- 

## 💻 Como executar
1. Execute o script: ```CreateDDDProjectDotNet.bat || CreateDDDProjectFastAPI.bat```
2. Escreva o nome do projeto
3. Escreva o caminho onde o projeto será criado.

---
### 🚀 Development by: ✌🏼 Jhonatan Azevedo | [🔗 LinkedIn](https://www.linkedin.com/in/dev-azevedo/) | [🐱 GitHub](https://github.com/dev-azevedo)