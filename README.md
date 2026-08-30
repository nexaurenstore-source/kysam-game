# Kysam Game

Jogo de ação, luta e aventura desenvolvido primeiro para Android.

## Idioma

🇵🇹 **Português** é o idioma padrão do projeto nesta fase.

## Visão

Kysam começa como uma experiência de luta 3D focada, inspirada na sensação de jogos como Tekken e Shadow Fight, mas com identidade própria.

O jogador luta em arenas compactas com limites claros. Os personagens podem correr, reposicionar-se, esquivar-se e atacar livremente dentro da arena, sem ficar presos a uma única linha de combate.

No futuro, a base de combate poderá crescer para exploração, caça, missões e áreas maiores de mundo aberto.

## Plataforma

- Android 5.0 (API 21) e superior
- Controles pensados para toque
- Renderização 3D otimizada para dispositivos móveis

## Direção visual

- Personagens e ambientes 3D realistas/semi-realistas
- Apresentação cinematográfica do combate
- Proporções e materiais realistas
- Evitar estética de desenho animado puro
- Objetivo visual ambicioso, adaptado ao hardware móvel

## Fase 1 — Fundação

- Estrutura inicial do projeto
- Base compatível com Android 5+
- Arena 3D compacta
- Limites da arena
- Movimento livre dentro da arena
- Base do controlador do jogador
- Base da câmera
- Arquitetura preparada para combate
- Treino com inimigo básico

## Personagens

A primeira versão terá **10 personagens**, incluindo Kysam e Elian.

Consulte `docs/personagens.md` para o elenco inicial.

### Kysam
Protagonista e caçador central do universo.

### Elian
Namorada de Kysam e uma guerreira importante. É uma excelente lutadora, especializada em combate corpo a corpo, com estilo, habilidades e progressão próprios.

## Roadmap

1. **Fase 1 — Fundação:** estrutura, arena, movimento e câmera.
2. **Fase 2 — Combate:** ataques, defesa, esquiva, vida, stamina, combos e IA.
3. **Fase 3 — 10 personagens:** seleção, estilos e integração dos personagens.
4. **Fase 4 — Apresentação:** modelos 3D, animações, iluminação, efeitos, áudio, menus e HUD.
5. **Fase 5 — Primeira versão jogável:** gerar APK e testar no Android.
6. **Fase 6 — Expansão:** novas arenas, sistemas e conteúdo.
7. **Fase 7 — Mundo aberto:** caça, missões, exploração e áreas maiores.

## Princípio de desenvolvimento

Construímos primeiro uma base de combate funcional. O mundo aberto vem depois. Os sistemas devem ser modulares para que as arenas iniciais possam evoluir para o futuro mundo de Kysam sem reconstruir o projeto do zero.
