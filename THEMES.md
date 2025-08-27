# 🎨 Esquemas de Colores Oscuros - Neodots

Esta configuración incluye una amplia colección de esquemas de colores oscuros modernos y populares para Neovim.

## 🌙 Temas Disponibles

### 1. **Tokyo Night** 
- **Variantes**: night, storm, moon, day
- **Descripción**: Tema oscuro inspirado en la noche de Tokio
- **Comando**: `:colorscheme tokyonight-night`

### 2. **Catppuccin**
- **Variantes**: mocha, macchiato, frappe, latte  
- **Descripción**: Tema suave con colores pastel
- **Comando**: `:colorscheme catppuccin-mocha`

### 3. **Kanagawa**
- **Variantes**: wave, dragon, lotus
- **Descripción**: Inspirado en las obras de Katsushika Hokusai
- **Comando**: `:colorscheme kanagawa-wave`

### 4. **Rose Pine**
- **Variantes**: main, moon, dawn
- **Descripción**: Tema natural con toques vintage
- **Comando**: `:colorscheme rose-pine`

### 5. **Gruvbox Material**
- **Variantes**: hard, medium, soft
- **Descripción**: Gruvbox con paleta Material Design
- **Comando**: `:colorscheme gruvbox-material`

### 6. **Dracula**
- **Variantes**: default
- **Descripción**: Tema clásico inspirado en Dracula
- **Comando**: `:colorscheme dracula`

### 7. **One Dark**
- **Variantes**: dark, darker, cool, deep, warm, warmer
- **Descripción**: Inspirado en Atom One Dark
- **Comando**: `:colorscheme onedark`

### 8. **Nightfox**
- **Variantes**: nightfox, carbonfox, duskfox, nordfox, terafox
- **Descripción**: Familia de temas altamente personalizables
- **Comando**: `:colorscheme nightfox`

### 9. **Sonokai**
- **Variantes**: default, atlantis, andromeda, shusia, maia, espresso
- **Descripción**: Esquema de alto contraste y colores vívidos
- **Comando**: `:colorscheme sonokai`

### 10. **Everforest**
- **Variantes**: hard, medium, soft
- **Descripción**: Esquema basado en colores verdes
- **Comando**: `:colorscheme everforest`

### 11. **Oxocarbon**
- **Variantes**: default
- **Descripción**: Tema oscuro oficial de IBM
- **Comando**: `:colorscheme oxocarbon`

### 12. **Cyberdream**
- **Variantes**: default
- **Descripción**: Tema cyberpunk de alto contraste
- **Comando**: `:colorscheme cyberdream`

## ⌨️ Atajos de Teclado

### Cambio de Temas
| Atajo | Descripción |
|-------|-------------|
| `<leader>th` | Abrir selector de temas (Telescope) |
| `<leader>tn` | Cambiar al siguiente tema |
| `:ThemePicker` | Comando para abrir selector |
| `:NextTheme` | Comando para siguiente tema |
| `:SetTheme <nombre>` | Establecer tema específico |

### Atajos Directos
| Atajo | Tema |
|-------|------|
| `<leader>t1` | Tokyo Night |
| `<leader>t2` | Catppuccin |
| `<leader>t3` | Kanagawa |
| `<leader>t4` | Rose Pine |
| `<leader>t5` | Gruvbox Material |
| `<leader>t6` | Dracula |
| `<leader>t7` | One Dark |
| `<leader>t8` | Nightfox |
| `<leader>t9` | Cyberdream |

## 🎯 Características Especiales

### Transparencia
Todos los temas están configurados con:
- Fondo transparente
- Ventanas flotantes transparentes
- Barras laterales transparentes
- Compatibilidad con terminales transparentes

### Integración
Los temas están integrados con:
- **Lualine**: Actualización automática de la barra de estado
- **Telescope**: Interfaz de selección visual
- **Nvim-tree**: Iconos y colores consistentes
- **Bufferline**: Pestañas con colores del tema
- **Notify**: Notificaciones con colores del tema

## 🔧 Personalización

### Cambiar Tema por Defecto
Edita `lua/plugins/ui.lua` y modifica la configuración del tema principal:

```lua
vim.cmd.colorscheme("tu-tema-favorito")
```

### Agregar Nuevos Temas
1. Agrega el plugin en `lua/plugins/ui.lua`
2. Actualiza la lista en `lua/utils/theme_manager.lua`
3. Agrega el atajo en `lua/config/keymaps.lua`

### Configuración Avanzada
Cada tema puede personalizarse individualmente en su configuración dentro de `ui.lua`.

## 🚀 Instalación Automática

Los temas se instalan automáticamente con Lazy.nvim cuando inicias Neovim por primera vez. Si quieres instalar un tema específico manualmente:

```vim
:Lazy install nombre-del-plugin
```

## 💡 Consejos

1. **Usa el selector**: `<leader>th` para probar diferentes temas visualmente
2. **Experimenta con variantes**: Cada tema tiene múltiples variantes
3. **Personaliza transparencia**: Modifica `transparent = true/false` en cada tema
4. **Combina con wallpapers**: Los temas transparentes se ven mejor con wallpapers oscuros

---

¡Disfruta explorando todos estos hermosos esquemas de colores oscuros! 🌙✨