# Matsui-dotfiles

Esse projeto foi criado para compartilhar o meu rice e as configurações que eu uso no meu Linux. Ainda estou aprendendo a mexer no GitHub, então peço desculpas se algo estiver desorganizado. Qualquer sugestão é bem-vinda!

![rice](print.png)

**Plataforma:** Arch Linux + Hyprland

> Minha config do Hyprland é em Lua (`hyprland.lua`), então você precisa de uma versão do Hyprland que suporte esse formato.

---

## O que tem aqui

| Pasta / arquivo | Programa | Função |
|---|---|---|
| `hypr/` | Hyprland, Hyprpaper, Hyprlock | Compositor, wallpaper e tela de bloqueio |
| `waybar/` | Waybar | Barra |
| `rofi/` | Rofi | Launcher de aplicativos e menu de energia |
| `kitty/` | Kitty | Terminal |
| `dunst/` | Dunst | Notificações |
| `fastfetch/` | Fastfetch | Informações do sistema |
| `yazi/` | Yazi | Gerenciador de arquivos no terminal |
| `nvim/` | Neovim | Editor (plugins com lazy.nvim) |
| `starship.toml` | Starship | Prompt do terminal |
| `bin/` | Scripts | `print-watch.sh` e `controle-watch.sh`, chamados pelo Hyprland |
| `heaven.png` | Wallpaper | Imagem de fundo |

## Detalhes do setup

- **Fonte:** *(preencha: ex. JetBrainsMono Nerd Font)*
- **Tema de cores:** *(preencha: ex. Catppuccin Mocha)*
- **Wallpaper:** `heaven.png`

---

## Dependências

Instale os programas antes de copiar as configs:

```bash
sudo pacman -S hyprpaper hyprlock waybar rofi kitty dunst fastfetch yazi neovim starship git
```

Você também precisa de uma **Nerd Font** (senão os ícones da Waybar aparecem quebrados). eu uso a Iosevka (instale também a JetBrains):

```bash
sudo pacman -S ttf-iosevka-nerd ttf-jetbrains-mono-nerd
```
---

## Instalação

**1. Faça backup da sua config atual** (importante, os arquivos serão sobrescritos):

```bash
cp -r ~/.config ~/config-backup
```

**2. Clone o repositório:**

```bash
git clone https://github.com/Nikkiis7/Matsui-dotfiles
cd Matsui-dotfiles
```

**3. Copie as configs:**

```bash
cp -r dunst fastfetch hypr kitty nvim rofi waybar yazi ~/.config/
cp starship.toml ~/.config/
```

**4. Instale os scripts** (o Hyprland procura eles em `~/.local/bin`):

```bash
mkdir -p ~/.local/bin
cp bin/*.sh ~/.local/bin/
chmod +x ~/.local/bin/*.sh
```

**5. Wallpaper:** copie o `heaven.png` para uma pasta sua e edite o caminho em `~/.config/hypr/hyprpaper.conf`:

Se você não quiser editar o arquivo, basta criar uma pasta chamada "Imagens" e colar o wallpaper com o nome "heaven.png" que irá funcionar.

```bash
cp heaven.png ~/Imagens/
```

**6. Reinicie o Hyprland** (saia da sessão e entre de novo) ou rode:

```bash
hyprctl reload
```

Na primeira vez que abrir o Neovim, os plugins serão instalados automaticamente pelo lazy.nvim.

---

## Observações

- Se algo não funcionar, confira se todos os programas da lista de dependências estão instalados.
- Os atalhos de teclado estão no arquivo `hypr/hyprland.lua`.
- Monitores, teclado e outras configurações específicas do meu PC podem precisar de ajuste no `hyprland.lua`.

Feito por [Ryan Matsui](https://github.com/Nikkiis7)
