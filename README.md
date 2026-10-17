# 🐾 PET SAÚDE DIGITAL
### Transformando o Tempo de Tela em Desenvolvimento

Jogo educativo desenvolvido para transformar o tempo de tela de crianças e adolescentes com Transtorno do Espectro Autista (TEA) em uma experiência de aprendizagem funcional.

A proposta utiliza **sequências visuais, repetição, reforço positivo e suporte progressivo** para trabalhar habilidades relacionadas às atividades do cotidiano.

---

## 🎮 Sobre o jogo

O jogo apresenta atividades baseadas em situações do cotidiano, nas quais o jogador deve organizar **cartões visuais em uma sequência correta**.

A mecânica principal consiste em arrastar cartões embaralhados para uma linha do tempo, reconstruindo uma determinada atividade passo a passo. Essa abordagem busca trabalhar habilidades como:

- 🧠 Sequenciamento;
- 📋 Planejamento;
- 🧩 Organização;
- 🔄 Reconhecimento de padrões;
- 🏠 Autonomia em atividades cotidianas.

A experiência foi projetada para ser simples, previsível e sem mecanismos de punição, derrota ou pressão por tempo.

---

## 🌎 Mundos

O jogo é dividido em quatro mundos, cada um relacionado a um conjunto de habilidades funcionais:

| Mundo | Tema | Exemplos |
|---|---|---|
| 🌱 **Mundo 1** | Atividades da Vida Diária | Escovar os dentes, tomar banho, organizar o quarto e vestir-se |
| 🍎 **Mundo 2** | Alimentação | Preparar um lanche simples e reconhecer escolhas alimentares |
| 💬 **Mundo 3** | Habilidades Sociais | Iniciar uma conversa, esperar a vez, reconhecer emoções e fazer pedidos |
| 🛡️ **Mundo 4** | Segurança | Atravessar a rua, pedir ajuda e identificar situações de risco |

---

## 🧩 Sistema de aprendizagem

Cada atividade utiliza cartões contendo uma ilustração e uma descrição curta da ação.

Por exemplo, na atividade **"Escovação dos dentes"**, o jogador deve organizar as etapas da rotina:

1. Pegar a escova e a pasta;
2. Molhar a escova;
3. Colocar a pasta;
4. Escovar os dentes de cima;
5. Escovar os dentes de baixo;
6. Escovar a língua;
7. Cuspir;
8. Enxaguar a boca e guardar a escova.

### 📈 Níveis de dificuldade

O jogo oferece suporte progressivo:

- **Nível 1 — Modelo completo:** sequência apresentada em ordem;
- **Nível 2 — Silhueta:** espaços apresentam uma referência visual discreta;
- **Nível 3 — Primeiro passo:** primeira etapa já posicionada;
- **Nível 4 — Sequência livre:** cartões totalmente embaralhados;
- **Nível 5 — Card intruso:** cartões incorretos são adicionados à atividade.

O objetivo é reduzir gradualmente o suporte conforme a autonomia do jogador aumenta.

---

## 💚 Feedback

O jogo utiliza **reforço positivo**, evitando punições por erros.

Quando uma etapa é realizada corretamente, o cartão é encaixado suavemente e o jogo fornece uma confirmação verbal.

Quando ocorre um erro:

- O cartão retorna ao conjunto inicial;
- Não há som de erro;
- Não há tela vermelha;
- Não há perda de vidas;
- Não há contador de tentativas;
- Uma dica visual ou sonora pode ser oferecida após tentativas repetidas.

Também não são utilizados cronômetros ou sistemas de derrota.

---

## ♿ Acessibilidade

O projeto segue uma abordagem de **baixa estimulação e alta previsibilidade**.

Entre as diretrizes:

- 🚫 Sem cronômetro;
- 🚫 Sem sons de erro;
- 🚫 Sem vidas ou derrota;
- 🔇 Botão de mudo sempre disponível;
- 🌿 Modo de baixo estímulo;
- 📍 Botões sempre nas mesmas posições;
- 🔊 Leitura em voz alta;
- 🔲 Alto contraste;
- 🔠 Fonte ampliável;
- 👆 Áreas de toque grandes;
- 🗣️ Linguagem literal;
- 🎯 Sessões curtas de aproximadamente 5–10 minutos.

---

## 🔄 Do jogo para a vida real

O objetivo não termina quando uma fase é concluída.

Após completar uma sequência, o jogo pode apresentar a mesma atividade como uma **agenda visual**, permitindo que a criança utilize o celular como apoio durante a realização da tarefa real.

Também está prevista a possibilidade de:

- 📱 Utilizar a sequência durante a atividade;
- 🖨️ Imprimir a rotina;
- 🏠 Utilizar os cartões fora do ambiente digital.

Assim, o jogo funciona como um mediador entre a aprendizagem digital e a prática cotidiana.

---

# 📁 Estrutura do projeto

O projeto foi desenvolvido utilizando **Godot**, com as cenas dos diferentes mundos organizadas separadamente.

```text
.
├── assets
│   ├── ex2.gd
│   └── ex2.gd.uid
│
├── index.tscn
├── project.godot
│
├── share
│   ├── ex.gd
│   └── ex.gd.uid
│
└── world
	├── world1
	│   └── main_world1.tscn
	│
	├── world2
	│   └── main_world2.tscn
	│
	├── world3
	│   └── main_world3.tscn
	│
	└── world4
		└── main_world4.tscn
```

### 📌 Diretórios

#### `assets/`

Contém scripts e recursos relacionados aos elementos do jogo.

#### `share/`

Contém scripts compartilhados pelo projeto.

#### `world/`

Contém a organização dos quatro mundos do jogo.

Cada mundo possui sua própria cena principal:

```text
world/
├── world1/
│   └── main_world1.tscn
├── world2/
│   └── main_world2.tscn
├── world3/
│   └── main_world3.tscn
└── world4/
	└── main_world4.tscn
```

#### `index.tscn`

Cena inicial do jogo, responsável pelo ponto de entrada da aplicação.

#### `project.godot`

Arquivo de configuração principal do projeto Godot.

---

## 🏗️ Arquitetura geral

A organização do jogo segue uma divisão baseada nos mundos:

```text
					┌─────────────────┐
					│   index.tscn    │
					│  Tela inicial   │
					└────────┬────────┘
							 │
			  ┌──────────────┼──────────────┐
			  │              │              │
			  ▼              ▼              ▼
		  🌱 Mundo 1      🍎 Mundo 2      💬 Mundo 3
		  Vida diária    Alimentação     Social
			  │              │              │
			  └──────────────┼──────────────┘
							 │
							 ▼
					   🛡️ Mundo 4
						 Segurança
```

Cada mundo pode conter diferentes atividades, mantendo a mesma mecânica central de **organização de sequências visuais**.

---

## 🎯 Objetivo do projeto

O PET Saúde Digital não busca simplesmente reduzir o tempo de tela.

A proposta é **ressignificar esse tempo**, transformando uma experiência potencialmente passiva em uma oportunidade de desenvolvimento de habilidades funcionais, autonomia e aprendizagem.

O projeto também prevê integração entre **criança, família e equipe da Atenção Primária à Saúde**, incluindo a possibilidade de acompanhamento agregado da utilização da ferramenta pela UBS.

---

## 🚀 Execução

Para executar o projeto, abra o arquivo:

```text
project.godot
```

utilizando o **Godot Engine**.

A cena inicial do projeto é:

```text
index.tscn
```

---

## 🛠️ Tecnologias

- **Godot Engine**
- **GDScript**
- **Godot Scene (`.tscn`)**

---

## 📌 Status

🚧 **Em desenvolvimento**

O projeto está sendo desenvolvido como um protótipo de jogo educativo, seguindo a proposta do PET Saúde Digital.

A metodologia prevista inclui desenvolvimento do protótipo, validação pela equipe multiprofissional, teste piloto e avaliação da utilização da ferramenta.

---

## 👥 Projeto

**PET Saúde Digital — Transformando o Tempo de Tela em Desenvolvimento**

Projeto voltado à utilização de tecnologias digitais como ferramenta complementar para educação em saúde, desenvolvimento de habilidades funcionais e promoção da autonomia.
