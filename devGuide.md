# ☑ Guia de Desenvolvimento e Arquitetura

Olá, time! Este documento é nosso mapa para construir o Lumi. Ele explica nossa arquitetura, nosso fluxo de trabalho e quem é responsável por cada parte.

## 1. A Nossa Arquitetura (O "Porquê")

Para manter o projeto organizado, rápido e fácil de dar manutenção, nós separamos o código em duas categorias principais:

### 1. `lib/common/widgets/` (Os "Blocos de Montar")

* **O que são?** São nossos componentes reutilizáveis: botões, campos de texto, logo, etc.

* **Responsabilidade:** Eles são "burros". Eles não sabem o que fazem, apenas como se parecem. Um `PrimaryActionButton`, por exemplo, é só um botão amarelo. Ele não sabe se está sendo usado para "Login" ou "Criar Conta".

* **Regra de Ouro:** Se um widget vai ser usado em mais de uma tela, ele DEVE ser criado aqui.

### 2. `lib/features/.../screens/` (As "Telas")

* **O que são?** São as telas do aplicativo.

* **Responsabilidade:** Elas são "inteligentes". Elas pegam os "Blocos de Montar" da pasta `common/widgets/` e os juntam para montar o layout. É aqui que mora a lógica (ex: "Ao clicar neste `PrimaryActionButton`, chame o `auth_service.dart` para fazer login").

## 2. Como Construir sua Tela (O "Fluxo de Trabalho Padrão")

Este é o passo a passo que todos devem seguir para construir sua tela:

1. **Crie sua Branch:** Nunca trabalhe na `main`. Crie sua branch primeiro, um exemplo seria:
   `git checkout -b nome/feature-nome-da-sua-tela`

   *Exemplo específico:* `git checkout -b luccas/feature-home-screen`

2. **Abra sua Tela:** Vá até o arquivo da tela pela qual você é responsável (veja a tabela abaixo).
   *Ex: `lib/features/home/screens/home_screen.dart`*

3. **Identifique os Componentes:** Olhe o design e veja quais "Blocos de Montar" da pasta `lib/common/widgets/` você precisa.
   *Ex: "Eu preciso de um `WelcomeHeader` e uma `LumiBottomNavBar`."*

4. **Prioridade: Crie os Componentes Comuns:**

   * Verifique se os componentes que você precisa já existem em `lib/common/widgets/`.

   * **Se sim:** Ótimo! Apenas importe e use na sua tela.

   * **Se não:** Pare de fazer a tela e crie o componente comum primeiro! Vá até o arquivo (ex: `lib/common/widgets/layout/welcome_header.dart`), crie o widget lá, e depois volte para sua tela e importe-o.

5. **Monte o Layout:** Dentro do arquivo da sua tela, importe os componentes comuns e organize-os para montar o layout.

6. **Adicione a Lógica:** Conecte os botões e campos de formulário aos nossos serviços (como `auth_service.dart` ou `firestore_service.dart`) para dar vida à tela.

7. **Abra um Pull Request (PR):** Quando sua tela estiver pronta, envie um PR para a `main` e peça para alguém do time revisar.

## 3. Divisão de Tarefas (O "Quem" e "Onde")

Esta é a divisão de responsabilidades. Cada membro/dupla é responsável por construir o arquivo da tela e, se necessário, criar os componentes comuns que aquela tela utiliza.

### 1. Caio - Tela Inicial

* **Tela (Arquivo Principal):** `lib/features/authentication/screens/initial_screen.dart`

* **Componentes Comuns que você vai usar/criar:**

  * `lib/common/widgets/images/lumi_logo.dart`

  * `lib/common/widgets/text/screen_title.dart` (para o "LUMI")

  * `lib/common/widgets/text/body_text.dart` (para o texto de boas-vindas)

  * `lib/common/widgets/buttons/primary_action_button.dart` (para "Vamos Começar")

  * `lib/common/widgets/buttons/secondary_button.dart` (para "Já tenho uma conta")

### 2. Sarah e Pedro - Tela de Formulário (Autenticação)

* **Tela (Arquivo Principal):** `lib/features/authentication/screens/auth_form_screen.dart`

* **Componentes Comuns que vocês vão usar/criar:**

  * `lib/common/widgets/form_fields/email_form_field.dart`

  * `lib/common/widgets/form_fields/password_form_field.dart`

  * `lib/common/widgets/buttons/primary_action_button.dart` (para "Criar Conta")

  * `lib/common/widgets/buttons/google_sign_in_button.dart`

  * `lib/common/widgets/buttons/secondary_button.dart` (para "Já tenho uma conta")

### 3. Sergio e Luccas - Tela Principal (Home)

* **Tela (Arquivo Principal):** `lib/features/home/screens/home_screen.dart`

* **Componentes Comuns que vocês vão usar/criar:**

  * `lib/common/widgets/layout/welcome_header.dart` (cabeçalho com saudação)

  * `lib/common/widgets/layout/lumi_bottom_nav_bar.dart` (barra de navegação)

* **Widgets Específicos da Tela (dentro de `lib/features/home/widgets/`):**

  * `lib/features/home/widgets/daily_suggestion_card.dart`

  * `lib/features/home/widgets/content_carousel.dart` (para Músicas, Filmes, Livros)

### 4. Pedro E. - Tela de Humor

* **Tela (Arquivo Principal):** `lib/features/mood_tracker/screens/mood_entry_screen.dart`

* **Componentes Comuns que você vai usar/criar:**

  * `lib/common/widgets/layout/welcome_header.dart`

  * `lib/common/widgets/text/screen_title.dart` (para "Como você está se sentindo...?")

  * `lib/common/widgets/form_fields/multiline_text_field.dart`

### 5. Sara e Mari - Tela de Perfil

* **Tela (Arquivo Principal):** `lib/features/profile/screens/profile_screen.dart`

* **Componentes Comuns que vocês vão usar/criar:**

  * `lib/common/widgets/images/lumi_logo.dart` (o sol pequeno no topo)

  * `lib/common/widgets/images/user_profile_avatar.dart` (foto de perfil)

  * `lib/common/widgets/layout/lumi_bottom_nav_bar.dart`

  * `lib/common/widgets/text/body_text.dart` (para os campos de informação)