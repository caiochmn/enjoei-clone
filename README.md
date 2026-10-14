# desapega

Clone de estudo de um marketplace de peças usadas (C2C): cada pessoa tem uma lojinha,
anuncia o que não usa mais e compra de outras lojinhas. O projeto reproduz o
funcionamento, sem usar marca, textos ou imagens de nenhum marketplace real.

## Stack

- Ruby 3.3 + Rails 8.1
- Hotwire (Turbo + Stimulus) e Tailwind CSS 4
- PostgreSQL
- Autenticação do próprio Rails 8 (`has_secure_password` + sessões em banco)
- Solid Queue, Solid Cache e Solid Cable (sem Redis)

## Rodando localmente

Pré-requisitos: Ruby 3.3, PostgreSQL rodando e acessível pelo usuário atual.

```sh
bin/setup          # instala gems, cria o banco, roda migrations e seeds
bin/dev            # sobe o Rails e o watcher do Tailwind em http://localhost:3000
```

Para recriar os dados de exemplo: `bin/rails db:seed:replant`.

Contas de exemplo (senha `senha1234`): `ana@example.com`, `bruno@example.com`,
`carla@example.com`, `diego@example.com`.

## Testes

```sh
bin/rails test           # modelos e controllers
bin/rails test:system    # fluxo no navegador (precisa do Chrome)
bin/rubocop
bin/brakeman
```

Em containers rodando como root, os testes de sistema precisam de
`CHROME_NO_SANDBOX=1`; `CHROME_BIN` aponta para um Chrome fora do PATH.

## Rotas

| Tela | Rota | Acesso |
| --- | --- | --- |
| Home com departamentos e lojinhas | `/` | público |
| Entrar / sair | `/entrar`, `DELETE /sair` | público |
| Criar conta | `/cadastro` | público |
| Esqueci a senha | `/senha/new` | público |
| Departamento | `/{departamento}/s` | público |
| Marcas | `/m` | público |
| Busca (placeholder) | `/s?q=` | público |
| Minha lojinha | `/perfil/minha-lojinha` | logado |
| Lojinha pública | `/{slug-da-lojinha}` | público |

## Modelo de dados (etapa 1)

- **User**: nome, email, senha. Ganha uma lojinha ao se cadastrar.
- **Store** (lojinha): nome, slug único (endereço público), bio, nota média.
  Slugs que colidem com rotas ou departamentos são recusados.
- **Category**: árvore departamento > categoria > subcategoria (`parent_id`);
  departamentos são as categorias sem pai.
- **Brand**: nome e slug.

## Roadmap

1. **Base** (este passo): projeto, autenticação, usuário e lojinha, layout com departamentos, seeds.
2. **Catálogo**: anunciar produto com fotos, página de produto, busca com `pg_search` e filtros.
3. **Social**: curtidas, ofertas e notificações por email.
4. **Compra**: sacola, checkout com frete por tabela e pagamento em modo de teste.
5. **Pós-venda**: envio, confirmação de recebimento, avaliação e saldo.
