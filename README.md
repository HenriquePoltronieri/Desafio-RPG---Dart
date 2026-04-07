# ⚔️ Torneio RPG - Dart

Desafio desenvolvido em Dart com foco em Orientação a Objetos e tratamento de exceções customizadas, simulando uma arena de combate por turnos entre dois lutadores.

O projeto coloca frente a frente um Guerreiro e um Mago em uma batalha interativa via terminal. A cada turno, o jogador escolhe quem ataca e qual habilidade usar, enquanto o sistema valida entradas, controla mana e exibe o placar após cada rodada.

---

## ⚔️ Lutadores

**Aragorn (Guerreiro)** — 100 de vida
Habilidade 1: Soco (-10 de vida) | Habilidade 2: Espadada (-25 de vida)

**Gandalf (Mago)** — 80 de vida | 60 de mana
Habilidade 1: Cajadada (-5 de vida) | Habilidade 2: Bola de Fogo (-40 de vida, custa 20 de mana)

---

## 📤 Saída esperada

```
BEM-VINDO À ARENA

Lutadores:
  [1] Aragorn — Guerreiro (Vida: 100)
  [2] Gandalf — Mago (Vida: 80 | Mana: 60)

TURNO 1
Quem vai atacar? (1 = Aragorn | 2 = Gandalf): 1
Qual habilidade? (1 ou 2): 2

  Aragorn usa ESPADADA em Gandalf! (-25 de vida)

  PLACAR ATUAL:
  Aragorn: 100 de vida
  Gandalf: 55 de vida | 60 de mana
```

---

## 🛠️ Tecnologia

- Dart

---

## 👨‍💻 Autor

Henrique Poltronieri
