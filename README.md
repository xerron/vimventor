
     ___  __
    |   ||  |
     | | / /                    __
     | |/ (_)_ _ _  _____ ___  / /____  ____
     |   / /  ' \ |/ / -_) _ \/ __/ _ \/ __/
     |__/_/_/_/_/___/\__/_//_/\__/\___/_/
                                  BY XERRON©

Vimventor es una moderna distribucion de plugins y recursos de Vim.

Vimventor ofrece caracteristicas fantasticas para la creación de contenido (Markdown, ReStructuredText, Latex), toma de notas (Note taking) y desarrollo de software (PHP, Python, Javascript, html5, css3, Sass, etc). Es totalmente personalizable y extensible,  

Libre de distracciones realice:  

- Corriga la ortográfia y la gramatica (LanguageTools)
- Consulte diccionarios.
- Cree y use plantillas (Ultisnips).
- Escriba con la ayuda del autocompletado (Neocomplete)
- Recupere sus notas rapidamente.
- Versionalice su trabajo (Git, Mercurial, etc). 
- Edite codigo facilmente.
- Navegue rapidamente entre archivos. (Unite)
- Navegue a traves de la estructura del archivo. (Tagbar)
- Explore su carpeta de trabajo (VimFiler)
- Invoque herramientas rapidamente y facilmente.

## Instalación 

**Dependencias**

- (g)Vim 7.4  
- Git
- Fuentes de [powerline](https://github.com/Lokaltog/powerline-fonts).
- LuaJit 
- Python 2.7.x

**Recomendado**

- [Ag](https://github.com/ggreer/the_silver_searcher)
- [Exuberant-ctags](http://ctags.sourceforge.net/)

### GNU/Linux

1. clone este repositorio en el directorio ~/.vim
 
        git clone https://github.com/xerron/vimventor.git ~/.vim

2. Ingrese en ~/.vim

        cd ~/.vim

3. Instale los submodulos 

        git submodule init && git submodule update

4. Haga un Backup de su antiguo .vimrc

        mv ~/.vimrc ~/.vimrc.backup

5. Cree un .vimrc nuevo con este contenido
    
        " Estas usando Vimventor by XERRON©
        source ~/.vim/vimrc

6. Ingrese a vim e instale los plugin por NeoBundle

        :NeoBundleInstall

7. Disfrutalo! 

### Windows

Instalar [gVim](http://www.kaoriya.net/software/vim/) (32bits) especificando que el archivo de configuracion va estar dentro de la carpeta de instalación. ($VIM)

1. clone este repositorio en el directorio donde se instalo Vim (**$VIM**) por defecto **"Archivos de programas/Vim"**
    
        git clone https://github.com/xerron/vimventor.git C:/path/to/Vim

2. Ingrese en $VIM

        cd C:/path/to/Vim

3. Instale los submodulos 

        git submodule init && git submodule update

4. Haga un Backup de su antiguo _vimrc

5. Cree un _vimrc nuevo con este contenido
    
        " Estas usando Vimventor by XERRON©
        source $VIM/vimrc

6. Ingrese a vim e instale los plugin por NeoBundle

        :NeoBundleInstall

7. Disfrutalo! 

**Vimventor Portable - only Windows**; La configuración de Vimventor es portable, lo puedes llevar en un USB instalando esta aplicacion > [Gvim Portable](http://portableapps.com/apps/development/gvim_portable)

## Configuración

La configuración es muy facil y todo se realiza en el archivo vimrc y esta pensado en **Grupos de plugins** habilita/desabilita simplemente comentando/descomentado unas lineas.

    "
    " Personalización
    "
    " Init {
        let s:settings = {}
        let s:settings.colorscheme = 'desert'

        " ---------------------------------------------------------
        " Comenta/descomenta el grupo de plugins que vas a utilizar
        " ---------------------------------------------------------
        let s:settings.plugin_groups = []
        call add(s:settings.plugin_groups, 'core')
        call add(s:settings.plugin_groups, 'distraction-free-mode')
        call add(s:settings.plugin_groups, 'markdown')
        "call add(s:settings.plugin_groups, 'csv')
        "call add(s:settings.plugin_groups, 'web')
        "call add(s:settings.plugin_groups, 'javascript')
        "call add(s:settings.plugin_groups, 'ruby')
        "call add(s:settings.plugin_groups, 'python')
        "call add(s:settings.plugin_groups, 'latex')
        "call add(s:settings.plugin_groups, 'scala')
        "call add(s:settings.plugin_groups, 'go')
        call add(s:settings.plugin_groups, 'scm')
        "call add(s:settings.plugin_groups, 'editing')
        "call add(s:settings.plugin_groups, 'indents')
        "call add(s:settings.plugin_groups, 'navigation')
        "call add(s:settings.plugin_groups, 'unite')
        "call add(s:settings.plugin_groups, 'autocomplete')
        "call add(s:settings.plugin_groups, 'textobj')
        "call add(s:settings.plugin_groups, 'misc')
        if s:is_windows
        " call add(s:settings.plugin_groups, 'windows')
        endif
        " ---------------------------------------------------
        " Deshabilita los plugins que no vas a usar
        " ---------------------------------------------------
        let s:settings.disabled_plugins=['vim.fo', 'vim.bar']
    " }

Las otras configuraciones propias de vim, estan bien documentadas con comentarios en **español** (como te gusta :3 ), y las configuraciones de los plugin en el mismo grupo donde corresponde.

## Inspiracion

- [ommwriter](http://www.ommwriter.com/)
- [focuswriter](http://gottcode.org/focuswriter/)
- [writemonkey](http://writemonkey.com/)
- [iawriter](http://www.iawriter.com/)

## Licencia

XERRON Copyrigth(c), No es gratis cuesta un par de cervezas. 


