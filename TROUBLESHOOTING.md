# 🔧 Solución de Problemas - Neodots

## 🚀 Solución Rápida

### 1. Ejecutar Script de Reparación
```powershell
# En PowerShell como administrador
.\fix-issues.ps1
```

### 2. Comandos Manuales en Neovim
```vim
:Lazy sync
:Mason
:checkhealth
:FixTransparency
```

## 🌙 Problema: Transparencia No Funciona

### Soluciones:
1. **Comando manual**: `:FixTransparency`
2. **Atajo de teclado**: `<leader>ut`
3. **Reiniciar Neovim** después de cambiar tema

### Verificar Terminal:
- Usar terminal con soporte de transparencia (Windows Terminal, Alacritty)
- Configurar transparencia en el terminal

## ⌨️ Problema: Which-Key No Aparece

### Soluciones:
1. **Presionar `<leader>` y esperar 200ms**
2. **Verificar que which-key esté instalado**: `:Lazy`
3. **Comando manual**: `:WhichKey`

### Atajos Principales:
- `<leader>?` - Mostrar ayuda de teclas
- `<leader>f` - Grupo de búsqueda
- `<leader>g` - Grupo de git
- `<leader>t` - Grupo de terminal/temas

## 📁 Problema: Navegación Entre Buffers Difícil

### Múltiples Opciones de Navegación:

#### Método 1: Tab/Shift-Tab
```
<Tab>       - Siguiente buffer
<Shift-Tab> - Buffer anterior
```

#### Método 2: Shift + H/L
```
<Shift-l>   - Siguiente buffer
<Shift-h>   - Buffer anterior
```

#### Método 3: Números con Leader
```
<leader>1   - Buffer 1
<leader>2   - Buffer 2
<leader>3   - Buffer 3
<leader>4   - Buffer 4
<leader>5   - Buffer 5
```

#### Método 4: Alt + Números
```
<Alt-1>     - Buffer 1
<Alt-2>     - Buffer 2
<Alt-3>     - Buffer 3
<Alt-4>     - Buffer 4
<Alt-5>     - Buffer 5
```

#### Método 5: Cybu (Visual)
```
<Ctrl-Tab>      - Siguiente buffer (visual)
<Ctrl-Shift-Tab> - Buffer anterior (visual)
<leader>bb      - Selector visual de buffers
```

#### Método 6: Telescope
```
<leader>fb  - Buscar buffers con Telescope
```

## 🎨 Cambio de Temas

### Métodos Disponibles:
1. **Selector visual**: `<leader>th`
2. **Siguiente tema**: `<leader>tn`
3. **Comandos directos**:
   - `:colorscheme tokyonight-night`
   - `:colorscheme catppuccin-mocha`
   - `:colorscheme dracula`

### Atajos Directos:
```
<leader>t1  - Tokyo Night
<leader>t2  - Catppuccin
<leader>t3  - Kanagawa
<leader>t4  - Rose Pine
<leader>t5  - Gruvbox Material
<leader>t6  - Dracula
<leader>t7  - One Dark
<leader>t8  - Nightfox
<leader>t9  - Cyberdream
```

## 🔍 Comandos de Diagnóstico

### Verificar Estado:
```vim
:checkhealth        " Verificar configuración general
:checkhealth lazy   " Verificar plugins
:checkhealth mason  " Verificar LSP servers
:checkhealth which-key " Verificar which-key
```

### Información de Plugins:
```vim
:Lazy               " Administrador de plugins
:Mason              " Administrador de LSP/herramientas
:LspInfo            " Información de LSP
```

## 🛠️ Reinstalación Completa

### Si nada funciona:
```powershell
# 1. Limpiar todo
Remove-Item -Recurse -Force ~\AppData\Local\nvim-data
Remove-Item -Recurse -Force ~\AppData\Local\nvim

# 2. Reiniciar Neovim
nvim

# 3. Esperar a que se instalen los plugins
# 4. Ejecutar comandos de verificación
```

## 📞 Ayuda Adicional

### Atajos de Ayuda:
- `<leader>?` - Mostrar todas las teclas disponibles
- `:help <comando>` - Ayuda específica
- `K` - Documentación del símbolo bajo el cursor

### Archivos de Configuración:
- `lua/config/keymaps.lua` - Todos los atajos de teclado
- `lua/plugins/ui.lua` - Configuración de temas
- `lua/utils/theme_manager.lua` - Administrador de temas

---

¡Con estas soluciones deberías tener Neodots funcionando perfectamente! 🎉