# Fase 1 — Fundação do Kysam Game

## Objetivo
Criar a primeira base jogável: uma arena 3D pequena onde o jogador controla Kysam e pode correr livremente dentro dos limites.

## Estrutura inicial

```text
kysam-game/
├── docs/
│   ├── fase-1.md
│   └── personagens.md
├── game/
│   ├── scenes/
│   │   └── arena-inicial.md
│   ├── scripts/
│   │   ├── jogador.md
│   │   └── camera.md
│   └── systems/
│       └── combate.md
└── README.md
```

## Regras da arena

- Área compacta e 3D.
- O jogador pode andar e correr em qualquer direção.
- Limites físicos impedem que o personagem saia da arena.
- A câmera acompanha o personagem.
- O combate será adicionado sem substituir o sistema de movimento.

## Android

A primeira meta é Android 5.0 (API 21+) e o projeto deve evitar dependências desnecessariamente pesadas.

## Próximo marco

Transformar esta especificação em uma cena/protótipo executável com personagem, chão, limites, câmera e controles básicos.
