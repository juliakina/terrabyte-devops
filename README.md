# 🌱 TerraByte - API REST em Nuvem com Docker e Oracle

---

## 📖 Conheça o TerraByte 

O TerraByte é uma solução desenvolvida para auxiliar agricultores na tomada de decisão frente aos impactos das mudanças climáticas na agricultura. A plataforma disponibiliza informações sobre tipos de solo, culturas agrícolas e características de terrenos, permitindo analisar a compatibilidade entre uma área de plantio e determinadas culturas.

Com isso, o sistema apoia produtores na escolha de cultivos mais adequados às condições ambientais e climáticas da região, contribuindo para uma produção mais eficiente, sustentável e resiliente aos desafios climáticos.  

---

## ☁️ Sobre o Projeto

O TerraByte é uma aplicação desenvolvida utilizando Java 21 e Spring Boot para gerenciamento de informações através de uma API REST.

A solução foi implantada na Microsoft Azure utilizando uma Máquina Virtual Ubuntu 22.04, Docker e Oracle Free Database.

A arquitetura foi construída seguindo conceitos de virtualização, conteinerização, persistência de dados e segurança em ambiente de nuvem.

---

## 👨‍💻 Equipe TerraByte
Carolina Nascimento Gonçalves
- RM: 564786
- 2TDSPJ
- [Github](https://github.com/carolnascgoncalves) 
- [Linkedin](http://linkedin.com/in/carolina-nascimento-906274364)

Emanuelly Ventura do Nascimento
- RM: 562339
- 2TDSPJ
- [Github](https://github.com/Emanuelly0ventura) 
- [Linkedin](https://www.linkedin.com/in/emanuelly-ventura-966135355) 

Julia Sayuri Kina
- RM: 564555
- 2TDSPJ
- [Github](https://github.com/juliakina) 
- [Linkedin](https://www.linkedin.com/in/julia-kina)

---

## 📂 Repositório do Projeto

O código-fonte completo da solução está disponível em:

🔗 https://github.com/juliakina/java-devops

O repositório contém:

- Código fonte da aplicação Java Spring Boot;
- Dockerfile da aplicação;
- Arquivo docker-compose.yml;

---

## 🏗️ Arquitetura da Solução

![Arquitetura Macro](/arquitetura-macro.png)

## 🛠️ Tecnologias Utilizadas

### Backend

* Java 21
* Spring Boot
* Maven

### Banco de Dados

* Oracle Free Database

### Conteinerização

* Docker
* Docker Compose

### Cloud

* Microsoft Azure
* Ubuntu 22.04 LTS

---

# 🚀 How To - Implantação da Solução

## 1. Enviar o Script para o Azure

Após acessar o Azure Cloud Shell ou um ambiente com Azure CLI configurada, faça o upload do arquivo disponibilizado neste repositório:

➡️[script.sh](https://github.com/juliakina/terrabyte-devops/blob/main/script.sh)

---

## 2. Provisionar a Infraestrutura Azure

Executar o script de provisionamento:

```bash
chmod +x script.sh
```

```bash
./script.sh
```

O script realiza automaticamente:

* Criação do Resource Group.
* Criação da VNET.
* Criação da Subnet.
* Criação do NSG.
* Criação da VM Ubuntu.
* Instalação do Docker.
* Clonagem do projeto.
* Inicialização dos containers.

---

## 3. Consulta do IP público da VM

```bash
az vm show -d -g rg-terrabyte -n vm-terrabyte --query publicIps -o tsv
```

---

## 4. Acessar a Máquina Virtual

```bash
ssh rm564555@IP_DA_VM
```

Senha de acesso:
```text
TerraByteGS$
```

---

## 5. Verificar os Containers

```bash
sudo docker ps
```

Containers esperados:

```text
rm564555_backend
rm564555_db
```

---

## 6. Verificar Usuário da Aplicação

A aplicação deve executar com usuário não-root.

```bash
sudo docker exec -it rm564555_backend sh
```

```bash
whoami
```

Resultado esperado:

```text
appuser
```

Sair do container:

```bash
exit
```

---

## 7. Verificar Persistência do Banco

```bash
sudo docker volume ls
```

Volume esperado:

```text
oracle-data
```

---

## 8. Acessar a Documentação Swagger

```text
http://IP_DA_VM:8080/swagger-ui/index.html
```

---

## 9. Executar os Testes da Aplicação

Através do Swagger é possível:

* Consultar registros;
* Inserir registros;
* Atualizar registros;
* Excluir registros.

Validando o funcionamento completo da API e da integração com o banco Oracle.

---

## 🔒 Boas Práticas Implementadas

### Segurança

* Aplicação executada com usuário não-root (`appuser`);
* Controle de acesso via NSG Azure;
* Containers isolados.

### Persistência

* Banco Oracle utilizando volume Docker nomeado (`oracle-data`);
* Dados preservados mesmo após reinicialização dos containers.

### Conteinerização

* Backend executado em container Docker;
* Banco Oracle executado em container Docker;
* Orquestração realizada via Docker Compose.

---

## 🎥 Vídeo Demonstrativo

Confira a demonstração completa!  
➡️[Clique aqui para assistir!](https://youtu.be/S6lDEbOUUMk)

---

## 📬 Contato
Caso tenha dúvidas, sugestões ou interesse em conhecer mais sobre o projeto, ficamos à disposição para conversar. Você pode entrar em contato com qualquer uma da nossa equipe:
- [Carolina Nascimento Gonçalves](http://linkedin.com/in/carolina-nascimento-906274364)
- [Emanuelly Ventura do Nascimento](https://www.linkedin.com/in/emanuelly-ventura-966135355) 
- [Julia Sayuri Kina](https://www.linkedin.com/in/julia-kina)
