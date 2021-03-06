if exists("g:__XPT_VIM__")
    finish
endif
let g:__XPT_VIM__ = 1



let s:oldcpo = &cpo
set cpo-=< cpo+=B

let XPT#ver = 2

let XPT#let_sid = 'map <Plug>xsid <SID>|let s:sid=matchstr(maparg("<Plug>xsid"), "\\d\\+_")|unmap <Plug>xsid'

let XPT#nullDict = {}
let XPT#nullList = []
let XPT#nonEscaped =
      \   '\%('
      \ .     '\%(\[^\\]\|\^\)'
      \ .     '\%(\\\\\)\*'
      \ . '\)'
      \ . '\@<='


fun! XPT#setIfNotExist(k, v) "{{{
    if !exists( a:k )
        exe "let" a:k "=" string( a:v )
    endif
endfunction "}}}

fun! XPT#warn( msg ) "{{{
    echohl WarningMsg
    echom a:msg
    echohl
endfunction "}}}
fun! XPT#info( msg ) "{{{
    echom a:msg
endfunction "}}}
fun! XPT#error( msg ) "{{{
    echohl ErrorMsg
    echom a:msg
    echohl
endfunction "}}}

fun! XPT#fallback( fbs ) "{{{
    let fbs = a:fbs
    if len( fbs ) > 0
        let [ key, flag ] = fbs[ 0 ]
        call remove( fbs, 0 )
        if flag == 'feed'
            call feedkeys( key, 'mt' )
            return ''
        else
            " flag == 'expr'
            return key
        endif
    else
        return ''
    endif
endfunction "}}}

fun! XPT#softTabStop() "{{{
    let ts  = &l:tabstop
    return &l:softtabstop == 0 ? ts : &l:softtabstop
endfunction "}}}

fun! XPT#getIndentNr( ln, col ) "{{{

    let line = matchstr( getline(a:ln), '\V\^\s\*' )
    let line = ( a:col == 1 ) ? '' : line[ 0 : a:col - 1 - 1 ]

    let tabspaces = repeat( ' ', &l:tabstop )

    return len( substitute( line, '	', tabspaces, 'g' ) )

endfunction "}}}

fun! XPT#getCmdOutput( cmd ) "{{{
    let l:a = ""

    redir => l:a
    exe a:cmd
    redir END

    return l:a
endfunction "}}}


fun! XPT#LeadingTabToSpace( str ) "{{{
    if stridx( a:str, "	" ) < 0
        return a:str
    endif
    
    let str = "\n" . a:str

    let tabspaces = repeat( ' ', &tabstop )

    let last = ''
    while str != last
        let last = str
        let str = substitute( str, '\n	*\zs	', tabspaces, 'g' )
    endwhile

    return str[ 1 : ]

endfunction "}}}

fun! XPT#convertSpaceToTab( text ) "{{{
    " NOTE: line-break followed by space

    if ( "\n" . a:text ) !~ '\V\n ' || &expandtab
        return a:text
    else

        let tabspaces = repeat( ' ',  &tabstop )
        let lines = split( a:text, '\V\n', 1 )
        let newlines = []
        for line in lines
            let newline = join( split( line, '\V\^\%(' . tabspaces . '\)', 1 ), '	' )
            let newlines += [ newline ]
        endfor

        return join( newlines, "\n" )

    endif
endfunction "}}}


" OO support 
fun! XPT#class( sid, proto ) "{{{
    let clz = deepcopy( a:proto )

    let funcs = split( XPT#getCmdOutput( 'silent function /' . a:sid ), "\n" )
    call map( funcs, 'matchstr( v:val, "' . a:sid . '\\zs.*\\ze(" )' )

    for name in funcs
        if name !~ '\V\^_'
            let clz[ name ] = function( '<SNR>' . a:sid . name )
        endif
    endfor

    " wrapper
    let clz.__init__ = get( clz, 'New', function( 'XPT#classVoidInit' ) )
    let clz.New = function( 'XPT#classNew' )

    return clz
endfunction "}}}

fun! XPT#classNew( ... ) dict "{{{
    let inst = copy( self )
    call call( inst.__init__, a:000, inst )
    let inst.__class__ = self
    return inst
endfunction "}}}

fun! XPT#classVoidInit( ... ) dict "{{{
endfunction "}}}


let &cpo = s:oldcpo
