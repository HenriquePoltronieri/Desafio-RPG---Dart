import 'dart:io';

class ManaInsuficienteException implements Exception {
  final String mensagem;
  ManaInsuficienteException(
      [this.mensagem = 'Mana insuficiente para usar esta habilidade!']);

  @override
  String toString() => 'ManaInsuficienteException: $mensagem';
}

abstract class Lutador {
  String nome;
  int vida;

  Lutador(this.nome, this.vida);

  void executarHabilidade(int escolha, Lutador alvo);

  bool estaVivo() => vida > 0;

  @override
  String toString() => '$nome (Vida: $vida)';
}

class Guerreiro extends Lutador {
  Guerreiro(String nome, int vida) : super(nome, vida);

  @override
  void executarHabilidade(int escolha, Lutador alvo) {
    switch (escolha) {
      case 1:
        print('  $nome usa SOCO em ${alvo.nome}! (-10 de vida)');
        alvo.vida -= 10;
        break;
      case 2:
        print('  $nome usa ESPADADA em ${alvo.nome}! (-25 de vida)');
        alvo.vida -= 25;
        break;
      default:
        print(' Habilidade inválida! Escolha 1 ou 2.');
    }
  }
}

class Mago extends Lutador {
  int mana;

  Mago(String nome, int vida, this.mana) : super(nome, vida);

  @override
  void executarHabilidade(int escolha, Lutador alvo) {
    switch (escolha) {
      case 1:
        print('🪄  $nome usa CAJADADA em ${alvo.nome}! (-5 de vida)');
        alvo.vida -= 5;
        break;
      case 2:
        if (mana < 20) {
          throw ManaInsuficienteException(
            '$nome precisa de 20 de mana, mas só tem $mana!',
          );
        }
        print(
            ' $nome usa BOLA DE FOGO em ${alvo.nome}! (-40 de vida, -20 mana)');
        alvo.vida -= 40;
        mana -= 20;
        break;
      default:
        print(' Habilidade inválida! Escolha 1 ou 2.');
    }
  }

  @override
  String toString() => '$nome (Vida: $vida | Mana: $mana)';
}

void main() {
  final guerreiro = Guerreiro('Aragorn', 100);
  final mago = Mago('Gandalf', 80, 60);

  final Map<int, Lutador> arena = {
    1: guerreiro,
    2: mago,
  };

  print('');

  print('BEM-VINDO À ARENA ║');

  print('');
  print('Lutadores:');
  print('  [1] ${guerreiro.nome} — Guerreiro (Vida: ${guerreiro.vida})');
  print('       Habilidade 1: Soco (-10)  |  Habilidade 2: Espadada (-25)');
  print('  [2] ${mago.nome} — Mago (Vida: ${mago.vida} | Mana: ${mago.mana})');
  print(
      '       Habilidade 1: Cajadada (-5)  |  Habilidade 2: Bola de Fogo (-40, custa 20 mana)');
  print('');

  int turno = 1;

  while (guerreiro.estaVivo() && mago.estaVivo()) {
    print(' TURNO $turno');
    print('');

    try {
      stdout.write(
          'Quem vai atacar? (1 = ${guerreiro.nome} | 2 = ${mago.nome}): ');
      final entradaId = stdin.readLineSync();
      final atacanteId = int.parse(entradaId!);

      if (!arena.containsKey(atacanteId)) {
        print(' ID inválido! Digite 1 ou 2.');
        continue;
      }

      final atacante = arena[atacanteId]!;

      if (!atacante.estaVivo()) {
        print(' ${atacante.nome} já está fora de combate!');
        continue;
      }

      final alvoId = atacanteId == 1 ? 2 : 1;
      final alvo = arena[alvoId]!;

      // Leitura da habilidade
      stdout.write('Qual habilidade? (1 ou 2): ');
      final entradaHabilidade = stdin.readLineSync();
      final habilidade = int.parse(entradaHabilidade!);
      print('');
      atacante.executarHabilidade(habilidade, alvo);
    } on FormatException {
      print('');
      print('  ERRO: Entrada inválida! Por favor, digite apenas números.');
    } on ManaInsuficienteException catch (e) {
      print('');
      print(' MANA INSUFICIENTE: ${e.mensagem}');
      print('   ${mago.nome} perde a vez!');
    } catch (e) {
      print('');
      print(' Erro inesperado: $e');
    } finally {
      print('');
      print(' PLACAR ATUAL:');
      print('     ${guerreiro.nome}: ${guerreiro.vida} de vida');
      print('    ${mago.nome}: ${mago.vida} de vida | ${mago.mana} de mana');
      print('');
    }

    turno++;
  }

  print('FIM DE JOGO ');

  if (!guerreiro.estaVivo() && !mago.estaVivo()) {
    print(' EMPATE! Ambos os lutadores caíram ao mesmo tempo!');
  } else if (!guerreiro.estaVivo()) {
    print(' VENCEDOR: ${mago.nome} (${mago.vida} de vida restante)');
    print(' ${guerreiro.nome} foi derrotado!');
  } else {
    print(' VENCEDOR: ${guerreiro.nome} (${guerreiro.vida} de vida restante)');
    print(' ${mago.nome} foi derrotado!');
  }

  print('');
  print('Obrigado por jogar na Arena! ');
}
