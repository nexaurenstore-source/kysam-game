# Kysam Game — Poderes e Armas Especiais

## Regra de design

Cada personagem deverá ter uma identidade de combate própria. Poderes e armas não serão apenas alterações de dano: devem mudar decisões, alcance, ritmo ou posicionamento.

## Kysam

**Estilo:** guerreiro equilibrado, agressivo e adaptável.

**Arma especial:** Lâmina de Kysam.
- Ataques rápidos de curta distância.
- Pode executar um golpe carregado.

**Poder único:** Ruptura de Energia.
- Consome energia.
- Libera um impacto concentrado à frente de Kysam.
- Causa dano elevado e knockback.

**Especial futuro:** Ascensão de Kysam.
- Sequência curta de golpes.
- Efeito visual próprio.
- Disponível apenas quando a energia estiver suficientemente carregada.

## Elian

**Estilo:** guerreira veloz, técnica e focada em mobilidade.

**Arma especial:** Lâminas Gêmeas de Elian.
- Combate rápido.
- Sequências de ataques curtos.
- Maior mobilidade durante combos.

**Poder único:** Dança Relâmpago.
- Avanço rápido em direção ao adversário.
- Pode atravessar uma pequena distância durante a execução.
- Causa vários impactos leves em sequência.

**Especial futuro:** Tempestade de Elian.
- Combinação de mobilidade e ataques consecutivos.
- Deve ter animação e efeitos próprios.

## Arquitetura para os restantes personagens

Cada novo personagem receberá um perfil contendo:

- nome;
- estilo de combate;
- arma especial;
- poder único;
- ataque especial;
- atributos;
- animações próprias;
- efeitos próprios;
- sons próprios.

Não criar personagens apenas como skins com números diferentes.

## Primeiros 10 personagens

1. Kysam — Lâmina de Kysam / Ruptura de Energia
2. Elian — Lâminas Gêmeas / Dança Relâmpago
3. Personagem 3 — a definir
4. Personagem 4 — a definir
5. Personagem 5 — a definir
6. Personagem 6 — a definir
7. Personagem 7 — a definir
8. Personagem 8 — a definir
9. Personagem 9 — a definir
10. Personagem 10 — a definir

## Ordem de implementação

1. Perfis e atributos.
2. Máquina de estados de combate.
3. Animações base: idle, andar, correr, ataque, defesa, esquiva, dano e derrota.
4. Animações de arma.
5. Poderes únicos.
6. Efeitos visuais.
7. Sons.
8. Balanceamento.

Os poderes devem continuar funcionais mesmo quando os modelos finais forem substituídos.