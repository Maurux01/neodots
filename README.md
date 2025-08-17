# Neodots - Neovim Configuration

Una configuración moderna y completa de Neovim con todas las características que necesitas para programar de manera eficiente.

## 🚀 Características

### ✨ Funcionalidades Principales

- **🎨 Dashboard personalizado**: Pantalla de inicio con acceso rápido
- **📸 Capturas de pantalla**: Toma capturas directamente desde el editor
- **⚠️ Errores y advertencias visuales**: Muestra errores de forma clara y atractiva
- **💡 Autocompletado inteligente**: Sugerencias en tiempo real para código y comandos
- **🤖 Chat con IA integrado**: Asistente de programación con ChatGPT
- **🎭 Transparencia graduable**: Control de transparencia del editor
- **🖼️ Wallpaper personalizable**: Cambia el fondo de escritorio desde el editor
- **🎬 Grabación de video**: Graba todo lo que escribes y ejecutas
- **🖼️ Visualización de imágenes**: Soporte para ver imágenes y SVG en el editor
- **🐙 Integración Git/Docker**: LazyGit y LazyDocker integrados
- **🐛 Debugging avanzado**: Depurador integrado para múltiples lenguajes
- **🧪 Testing framework**: Ejecución y gestión de tests
- **📊 Análisis de código**: Herramientas de diagnóstico avanzadas
- **🎯 Formateo automático**: Formateo de código al guardar
- **📚 Gestión de proyectos**: Detección y navegación de proyectos
- **📝 Notas y documentación**: Sistema de notas integrado
- **🎨 UI mejorada**: Interfaz moderna y responsive

### 🔧 Herramientas Integradas

- **LSP**: Soporte completo para múltiples lenguajes
- **Telescope**: Búsqueda y navegación avanzada
- **Treesitter**: Syntax highlighting mejorado
- **LazyGit**: Gestión de Git visual
- **LazyDocker**: Gestión de contenedores
- **ChatGPT**: Asistente de IA para programación
- **nvim-dap**: Debugging avanzado
- **neotest**: Framework de testing
- **Trouble**: Análisis de problemas
- **Conform**: Formateo automático
- **Neorg/Vimwiki**: Sistema de notas
- **Noice**: UI mejorada
- **Aerial**: Outline de código

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

### 🎨 Cambio Rápido de Temas
- `<leader>tn` - Siguiente tema oscuro
- `<leader>tp` - Tema anterior
- `<leader>ts` - Seleccionar tema con Telescope
- `<leader>tc` - Mostrar tema actual

### Git y Docker
- `<leader>gg` - Abrir LazyGit
- `<leader>gd` - Abrir LazyDocker

### Gestión de Buffers
- `<leader>bd` - Cerrar buffer
- `<leader>bn` - Siguiente buffer
- `<leader>bp` - Buffer anterior

### Comentarios Mejorados
- `<leader>cc` - Comentar/descomentar línea
- `<leader>cb` - Comentar/descomentar bloque
- `<leader>c` - Comentar selección (modo visual)
- `<leader>b` - Comentar bloque (modo visual)

### Brackets y Sintaxis
- **Rainbow brackets**: Colores automáticos para paréntesis/brackets
- **Auto-tags**: Cierre automático de tags HTML/JSX/XML
- **Resaltado de colores**: Visualización de códigos de color

## 🎨 Personalización

### 🎨 Temas Oscuros Disponibles

Tu configuración incluye **15 temas oscuros** preconfigurados que puedes cambiar rápidamente:

#### Temas Incluidos:
1. **Catppuccin** - Tema principal (por defecto)
2. **Tokyo Night** - Elegante y moderno
3. **One Dark** - Inspirado en Atom
4. **Gruvbox** - Clásico y cálido
5. **Nord** - Frío y minimalista
6. **Dracula** - Vibrante y colorido
7. **Nightfox** - Suave y elegante
8. **Carbonfox** - Oscuro y sofisticado
9. **Kanagawa** - Inspirado en el arte japonés
10. **Rose Pine** - Romántico y suave
11. **Everforest** - Natural y relajante
12. **Sonokai** - Vibrante y moderno
13. **Material** - Inspirado en Material Design
14. **Monokai** - Clásico y colorido
15. **Palenight** - Suave y elegante

#### Cambio Rápido de Temas:
- **`<leader>tn`** - Cambiar al siguiente tema
- **`<leader>tp`** - Cambiar al tema anterior
- **`<leader>ts`** - Seleccionar tema con Telescope
- **`<leader>tc`** - Ver tema actual

#### Características:
- **Transparencia habilitada** en todos los temas
- **Cambio instantáneo** sin reiniciar Neovim
- **Notificaciones visuales** al cambiar tema
- **Integración con dashboard** para cambio rápido

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

## 🐛 Debugging Avanzado

### nvim-dap
Configuración completa de debugging para múltiples lenguajes:

- **Python**: debugpy
- **JavaScript/TypeScript**: node-debug2-adapter
- **C/C++**: cppdbg
- **Go**: delve
- **Lua**: nlua

### Comandos de Debugging
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Continue
- `<leader>di` - Step into
- `<leader>do` - Step over
- `<leader>dO` - Step out
- `<leader>dr` - Toggle REPL
- `<leader>dl` - Run last
- `<leader>du` - Toggle DAP UI

## 🧪 Testing Framework

### neotest
Framework de testing para múltiples lenguajes:

- **Python**: pytest
- **JavaScript**: jest
- **Go**: go test
- **Rust**: cargo test

### Comandos de Testing
- `<leader>tt` - Run test
- `<leader>tf` - Run test file
- `<leader>td` - Debug test
- `<leader>ts` - Toggle test summary
- `<leader>to` - Open test output

## 📊 Análisis de Código

### Trouble
Herramienta avanzada para análisis de problemas:

- `<leader>xx` - Toggle trouble
- `<leader>xw` - Workspace diagnostics
- `<leader>xd` - Document diagnostics
- `<leader>xl` - Location list
- `<leader>xq` - Quickfix list

## 🎯 Formateo Automático

### Conform
Formateo automático al guardar para:

- **Lua**: stylua
- **Python**: isort + black
- **JavaScript/TypeScript**: prettier
- **JSON/YAML**: prettier
- **HTML/CSS**: prettier
- **Rust**: rustfmt
- **Go**: gofmt
- **C/C++**: clang_format

### Comandos
- `<leader>cf` - Format code manually

## 📚 Gestión de Proyectos

### project.nvim
Detección automática de proyectos:

- `<leader>pp` - Project picker
- Detección por patrones: .git, package.json, Makefile, etc.
- Navegación rápida entre proyectos

## 📝 Sistema de Notas

### Neorg
Sistema de notas avanzado con:

- Workspaces organizados
- Conceal mejorado
- Gestión de directorios

### Vimwiki
Sistema de notas alternativo:

- `<leader>ww` - Vimwiki index
- `<leader>wt` - Vimwiki tab index
- `<leader>ws` - Vimwiki UI select

### Markdown Preview
- `<leader>mp` - Toggle markdown preview

## 🎨 UI Mejorada

### Noice
Interfaz moderna con:

- Mejor presentación de LSP
- Command palette mejorado
- Notificaciones elegantes

### Scrollbar
Scrollbar inteligente con:

- Marcadores de errores
- Indicadores de búsqueda
- Gestión de folds

### Aerial
Outline de código:

- `<leader>aa` - Toggle aerial
- `<leader>an` - Next aerial
- `<leader>ap` - Previous aerial

## 💾 Gestión de Sesiones

### Auto-session
Gestión automática de sesiones:

- `<leader>ss` - Save session
- `<leader>sl` - Load session
- `<leader>sd` - Delete session
- Auto-save al salir
- Restauración automática

## 🖥️ Terminal Mejorado

### Toggleterm
Terminal flotante con:

- `<C-\>` - Toggle terminal
- Navegación con Ctrl+h/j/k/l
- Terminal flotante
- Múltiples terminales

## 📁 Explorador de Archivos

### Nvim-tree
Explorador de archivos alternativo:

- `<leader>e` - Toggle file explorer
- `<leader>ef` - Focus file explorer
- Vista adaptativa
- Filtros inteligentes

## ⚡ Utilidades Avanzadas

### Emmet
Expansión rápida de HTML/CSS:

- `<C-y>,` - Expandir emmet
- Snippets personalizados
- Soporte para múltiples frameworks

### Legendary
Command palette avanzado:

- `<leader>:` - Legendary command palette
- Registro automático de comandos
- Búsqueda inteligente

### Text Objects
Objetos de texto avanzados:

- `af/if` - Function
- `ac/ic` - Class
- `aa/ia` - Parameter
- `ab/ib` - Block
- `al/il` - Loop
- `as/is` - Statement

### Movimiento Avanzado
- `]m/[m` - Next/previous function
- `]c/[c` - Next/previous class
- `]a/[a` - Next/previous parameter
- `]b/[b` - Next/previous block

## 🌈 Mejoras de Sintaxis y Brackets

### Rainbow Delimiters
Los paréntesis, corchetes y llaves se muestran en diferentes colores según su nivel de anidamiento:
- **Rojo**: Primer nivel
- **Amarillo**: Segundo nivel  
- **Azul**: Tercer nivel
- **Naranja**: Cuarto nivel
- **Verde**: Quinto nivel
- **Violeta**: Sexto nivel
- **Cian**: Séptimo nivel

### Auto-tags Mejorado
- **HTML/JSX/XML**: Cierre automático de tags
- **Tags auto-cerrados**: `img`, `br`, `hr`, `input`, etc.
- **Soporte para**: React, Vue, Svelte, Astro

### Resaltado de Colores
- **CSS/SCSS**: Visualización de códigos de color
- **HTML**: Colores en atributos style
- **Tailwind**: Soporte para clases de Tailwind CSS
- **Colores nombrados**: Red, blue, green, etc.

### Comentarios Inteligentes
- **Contexto-aware**: Detecta el tipo de archivo automáticamente
- **Formato mejorado**: Espaciado y formato consistente
- **Soporte multilínea**: Comentarios de bloque para todos los lenguajes
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