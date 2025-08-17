# Neodots - Neovim Configuration

Una configuración moderna y completa de Neovim con todas las características que necesitas para programar de manera eficiente.

## 🚀 Características

### ✨ Funcionalidades Principales

- **🎨 Capturas de pantalla**: Toma capturas directamente desde el editor
- **⚠️ Errores y advertencias visuales**: Muestra errores de forma clara y atractiva
- **💡 Autocompletado inteligente**: Sugerencias en tiempo real para código y comandos
- **🤖 Chat con IA integrado**: Asistente de programación con ChatGPT
- **🎭 Transparencia graduable**: Control de transparencia del editor
- **🖼️ Wallpaper personalizable**: Cambia el fondo de escritorio desde el editor
- **🎬 Grabación de video**: Graba todo lo que escribes y ejecutas
- **🖼️ Visualización de imágenes**: Soporte para ver imágenes y SVG en el editor
- **🐙 Integración Git/Docker**: LazyGit y LazyDocker integrados

### 🔧 Herramientas Integradas

- **LSP**: Soporte completo para múltiples lenguajes
- **Telescope**: Búsqueda y navegación avanzada
- **Treesitter**: Syntax highlighting mejorado
- **LazyGit**: Gestión de Git visual
- **LazyDocker**: Gestión de contenedores
- **ChatGPT**: Asistente de IA para programación

## 📋 Requisitos Previos

### Software Necesario

1. **Neovim** (versión 0.8.0 o superior)
2. **Git**
3. **Node.js** (para LSP)
4. **Python** (para algunos LSP)
5. **Rust** (opcional, para rust-analyzer)

### Herramientas Opcionales

- **fd** (para búsqueda rápida de archivos)
- **ripgrep** (para búsqueda en archivos)
- **fzf** (para fuzzy finding)
- **Kitty** (para visualización de imágenes)
- **ffmpeg** (para grabación de video)
- **feh** (Linux, para wallpapers)

## 🛠️ Instalación

### 1. Clonar la configuración

```bash
git clone https://github.com/tu-usuario/neodots.git ~/.config/nvim
cd ~/.config/nvim
```

### 2. Instalar dependencias del sistema

#### Windows (PowerShell)
```powershell
# Instalar Chocolatey si no lo tienes
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Instalar herramientas
choco install git nodejs python rust fd ripgrep fzf
```

#### macOS
```bash
# Instalar Homebrew si no lo tienes
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar herramientas
brew install git node python rust fd ripgrep fzf ffmpeg
```

#### Linux (Ubuntu/Debian)
```bash
# Instalar herramientas
sudo apt update
sudo apt install git nodejs npm python3 python3-pip rustc cargo fd-find ripgrep fzf ffmpeg feh

# Instalar fd como fd
sudo ln -s /usr/bin/fd-find /usr/bin/fd
```

### 3. Configurar variables de entorno

```bash
# Configurar API key de OpenAI para ChatGPT
export OPENAI_API_KEY="tu-api-key-aqui"
```

### 4. Iniciar Neovim

```bash
nvim
```

La primera vez que inicies Neovim, se instalarán automáticamente todos los plugins y LSP necesarios.

## ⌨️ Atajos de Teclado

### Navegación General
- `<Space>` - Tecla líder
- `<C-h/j/k/l>` - Navegar entre ventanas
- `<leader>ff` - Buscar archivos
- `<leader>fg` - Buscar en archivos
- `<leader>fb` - Listar buffers
- `<leader>e` - Explorador de archivos

### LSP y Autocompletado
- `gd` - Ir a definición
- `gr` - Ver referencias
- `K` - Ver información (hover)
- `<leader>ca` - Acciones de código
- `<leader>rn` - Renombrar símbolo
- `<C-Space>` - Activar autocompletado
- `<Tab>` - Siguiente sugerencia
- `<S-Tab>` - Sugerencia anterior

### IA y Asistencia
- `<leader>ai` - Abrir chat con IA
- `<leader>ae` - Editar con instrucciones de IA

### Capturas y Grabación
- `<leader>ss` - Tomar captura de pantalla
- `<leader>sr` - Iniciar/Detener grabación
- `<leader>srs` - Iniciar grabación
- `<leader>srt` - Detener grabación

### Transparencia y Wallpaper
- `<leader>t+` - Aumentar transparencia
- `<leader>t-` - Disminuir transparencia
- `<leader>tr` - Resetear transparencia
- `<leader>tw` - Toggle wallpaper
- `<leader>ws` - Seleccionar wallpaper
- `<leader>wr` - Wallpaper aleatorio

### Git y Docker
- `<leader>gg` - Abrir LazyGit
- `<leader>gd` - Abrir LazyDocker

### Gestión de Buffers
- `<leader>bd` - Cerrar buffer
- `<leader>bn` - Siguiente buffer
- `<leader>bp` - Buffer anterior

## 🎨 Personalización

### Colores y Temas

La configuración usa el tema Catppuccin por defecto. Puedes cambiar el tema editando `lua/plugins.lua`:

```lua
-- Cambiar a otro tema
vim.cmd.colorscheme "tokyonight"
```

### Configuración de Transparencia

Ajusta la transparencia por defecto en `lua/transparency.lua`:

```lua
local current_transparency = 0.8  -- Cambiar este valor
```

### Directorios de Wallpapers

Los wallpapers se guardan en `~/Pictures/wallpapers/`. Puedes cambiar esto editando `lua/wallpaper.lua`:

```lua
local wallpaper_dir = vim.fn.expand("~/tu/ruta/personalizada")
```

## 🔧 Configuración de LSP

Los siguientes LSP se instalan automáticamente:

- **Lua**: lua_ls
- **JavaScript/TypeScript**: tsserver
- **Python**: pyright
- **Rust**: rust_analyzer
- **Go**: gopls
- **C/C++**: clangd
- **JSON**: jsonls
- **YAML**: yamlls
- **HTML**: html
- **CSS**: cssls
- **Tailwind**: tailwindcss

### Instalar LSP adicionales

Para instalar LSP adicionales, edita `lua/lsp.lua` y agrega el LSP a la lista `ensure_installed`.

## 🖼️ Visualización de Imágenes

### Configuración de Kitty

Para ver imágenes en la terminal, asegúrate de usar Kitty y tener la configuración correcta:

```bash
# En tu kitty.conf
term xterm-kitty
```

### Formatos Soportados

- PNG, JPG, JPEG, GIF, WebP
- SVG (con soporte de Kitty)
- Imágenes en Markdown

## 🎬 Grabación de Video

### Herramientas por Sistema Operativo

- **Windows**: OBS Studio
- **macOS**: QuickTime Player
- **Linux**: ffmpeg

### Configuración

Los videos se guardan en `~/Videos/neovim_recordings/`. Puedes cambiar esto editando `lua/recording.lua`.

## 🤖 Configuración de ChatGPT

### API Key

Configura tu API key de OpenAI:

```bash
export OPENAI_API_KEY="tu-api-key-aqui"
```

### Modelos Disponibles

- GPT-3.5-turbo (por defecto)
- GPT-4 (cambiar en configuración)

### Personalización

Edita la configuración de ChatGPT en `lua/plugins.lua` para personalizar el comportamiento.

## 🐛 Solución de Problemas

### Plugins no se instalan

```bash
# Limpiar cache de Lazy
rm -rf ~/.local/share/nvim/lazy
nvim --headless -c "Lazy! sync" -c "qa"
```

### LSP no funciona

```bash
# Verificar instalación de Mason
:Mason
# Instalar LSP manualmente si es necesario
```

### Transparencia no funciona

Asegúrate de que tu terminal soporte transparencia:
- **Windows**: Windows Terminal
- **macOS**: iTerm2 o Terminal.app
- **Linux**: Cualquier terminal moderno

### Imágenes no se muestran

1. Verifica que uses Kitty
2. Asegúrate de que `image.nvim` esté configurado correctamente
3. Verifica que las imágenes estén en formatos soportados

## 📝 Contribuir

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Crea un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🙏 Agradecimientos

- [Lazy.nvim](https://github.com/folke/lazy.nvim) - Gestor de plugins
- [Catppuccin](https://github.com/catppuccin/nvim) - Tema de colores
- [ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim) - Integración de IA
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) - Búsqueda y navegación
- [LazyGit](https://github.com/kdheepak/lazygit.nvim) - Git visual
- [LazyDocker](https://github.com/lazytanuki/nvim-docker) - Docker visual

---

**¡Disfruta programando con Neodots! 🚀**