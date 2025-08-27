# 🎨 Transparencia y Wallpapers en Neodots

Esta guía te ayudará a configurar la transparencia completa en Neovim para mostrar wallpapers de fondo.

## ✨ Características

- **Transparencia completa**: Fondo transparente en todas las ventanas
- **Soporte para wallpapers**: Permite ver el fondo del escritorio
- **Toggle dinámico**: Alternar transparencia con un comando
- **Compatibilidad**: Funciona con todos los temas incluidos

## 🚀 Configuración Rápida

### 1. Verificar Soporte del Terminal

Usa el comando para verificar si tu terminal soporta transparencia:
```
<leader>us
```

### 2. Alternar Transparencia

Para activar/desactivar la transparencia:
```
<leader>ub
```

O usa el comando:
```
:ToggleTransparency
```

## 🖥️ Terminales Compatibles

### Windows
- **Windows Terminal** ✅ (Recomendado)
- **Alacritty** ✅
- **WezTerm** ✅
- **Hyper** ✅

### Linux/macOS
- **Alacritty** ✅
- **Kitty** ✅
- **WezTerm** ✅
- **iTerm2** ✅ (macOS)

## ⚙️ Configuración del Terminal

### Windows Terminal
1. Abre `settings.json`
2. Agrega en el perfil:
```json
{
    "opacity": 85,
    "useAcrylic": true
}
```

### Alacritty
En `alacritty.yml`:
```yaml
window:
  opacity: 0.85
```

### Kitty
En `kitty.conf`:
```
background_opacity 0.85
```

## 🎯 Keybindings

| Comando | Descripción |
|---------|-------------|
| `<leader>ub` | Alternar transparencia |
| `<leader>us` | Ver estado de transparencia |
| `<leader>th` | Cambiar tema (mantiene transparencia) |

## 🔧 Solución de Problemas

### Transparencia no funciona
1. Verifica que tu terminal soporte transparencia
2. Reinicia Neovim después de cambiar configuración del terminal
3. Usa `:ToggleTransparency` para forzar la aplicación

### Wallpaper no se ve
1. Asegúrate de que el terminal tenga transparencia habilitada
2. Verifica que el wallpaper esté configurado en tu sistema
3. Algunos gestores de ventanas requieren compositor

### Temas no mantienen transparencia
La configuración automáticamente aplica transparencia después de cambiar temas.

## 🎨 Personalización

### Cambiar Nivel de Transparencia del Terminal
Ajusta el valor de `opacity` en la configuración de tu terminal:
- `1.0` = Opaco
- `0.85` = Ligeramente transparente (recomendado)
- `0.7` = Muy transparente

### Transparencia Selectiva
Puedes modificar `lua/utils/transparency.lua` para personalizar qué elementos son transparentes.

## 📝 Notas Importantes

- La transparencia se aplica automáticamente al iniciar Neovim
- Todos los temas (Tokyo Night, Catppuccin, Kanagawa, Rose Pine) soportan transparencia
- La configuración persiste entre sesiones
- Compatible con todos los plugins incluidos

## 🤝 Soporte

Si tienes problemas con la transparencia:
1. Verifica la compatibilidad de tu terminal
2. Revisa la configuración del terminal
3. Usa los comandos de diagnóstico incluidos

¡Disfruta de tu Neovim transparente con wallpapers! 🚀