nanorc
======

Improved syntax highlighting definitions for [GNU nano].

Description
-----------

The syntax highlighting definitions that come bundled with nano are of
pretty poor quality. This is an attempt at providing a good set of accurate
syntax definitions to replace and expand the defaults.

Screenshots:
------------

#### Editing HTML:

![HTML Screenshot](http://cra.igbarn.es/img/nanorc-html.png)

#### Editing C:

![C Screenshot](http://cra.igbarn.es/img/nanorc-c.png)

Installation
------------

Using `make install` will concatenate all syntax files together and install
to `~/.nano/syntax.nanorc`. You can then [include][example] this file into
your main `~/.nanorc` configuration by adding the line:

    include ~/.nano/syntax.nanorc

If your terminal **text** color isn't black, you'll need to specify it when
installing, using `make install TEXT=color`, where `color` must be one of:
`red`, `green`, `yellow`, `blue`, `magenta`, `cyan` or `white`.

After installation, use `nano examples/*` to test if everything is
working properly. If some or all of the files aren't highlighted properly,
see the FAQ below.

Theme System
------------

All `*.nanorc` files are passed through [mixins.sed] and [theme.sed] before
installation. These scripts allow rules to be specified in terms of token
names or [mixins], instead of hard-coded colors.

For example, the following named rule:

    TYPE: "int|bool|string"

becomes:

    color green "int|bool|string"

and the following "mixin":

    +BOOLEAN

becomes:

    color brightcyan "\<(true|false)\>"

This system helps to keep colors uniform across different languages and
also to keep the definitions clear and maintainable, which is something that
becomes quite awkward using only plain [nanorc] files.

**Note:** if `~/.nanotheme` exists it will be used as a custom theme, in
place of [theme.sed]. A custom theme may also be specified by installing
with `make THEME=your-custom-theme.sed`. Themes must be valid sed scripts,
defining *all* color codes found in [theme.sed] in order to work correctly.

FAQ
----

### Why did the install location change / Where did the old key bindings go?

The old settings and key bindings file was deleted and the Makefile now
installs *just* the syntax definitions to `~/.nano/syntax.nanorc` (as
opposed to overwriting `~/.nanorc`). It's expected that users maintain their
own settings and key bindings in `~/.nanorc` and `include` the new syntax
file, as detailed under "Installation" above.

See also: [issue #25], [example ~/.nanorc file][example].

### Why does syntax highlighting only work for a subset of supported files?

There appears to be a [bug][issue #5] in older versions of nano that causes
highlighting to fail when `/etc/nanorc` and `~/.nanorc` both contain
`syntax` rules. The usual workaround is to remove all `syntax` and `include`
lines from `/etc/nanorc`.

### Why do I get wierd errors when running nano < 2.1.5 on *BSD systems?

In order to reliably highlight keywords, this projects makes heavy use of
the GNU regex word boundary extensions (`\<` and `\>`). BSD implementations
also have these extensions but use a different, incompatible syntax
(`[[:<:]]` and `[[:>:]]`). Since version 2.1.5, nano can automatically
translate the GNU syntax to BSD syntax at run-time, but for the benefit of
people running a pre-2.1.5 version of nano on OS X or *BSD, the `.nanorc`
file itself can be translated by installing with `make BSDREGEX=1`.

### Why not use `\s` instead of the verbose `[[:space:]]` pattern?

Because nano compiles against the platform's native regex library and some
platforms don't support `\s` (as it's not required by [POSIX ERE]).

Unlicense
---------

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>


[GNU nano]: http://www.nano-editor.org/
[nanorc]: http://www.nano-editor.org/dist/v2.3/nanorc.5.html
[theme.sed]: https://github.com/craigbarnes/nanorc/tree/master/theme.sed
[mixins.sed]: https://github.com/craigbarnes/nanorc/tree/master/mixins.sed
[mixins]: https://github.com/craigbarnes/nanorc/tree/master/mixins
[issue #5]: https://github.com/craigbarnes/nanorc/issues/5
[issue #25]: https://github.com/craigbarnes/nanorc/issues/25
[example]: https://github.com/craigbarnes/dotfiles/blob/master/dotfiles/nanorc#L54
[POSIX ERE]: http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html#tag_09_04
