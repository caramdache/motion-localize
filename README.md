# motion-localize

A RubyMotion plugin to provide localization commands for projects.

## Install

```
$ gem install motion-localize
$ brew install http://www.soimort.org/translate-shell/translate-shell.rb
$ gem install motion-appstore
```

If you like to install manually,

```
$ git clone https://github.com/caramdache/motion-localize.git
$ cd motion-localize
$ rake install
```

## Usage

```
$ vi resources/en.lproj/Localizable.strings
$ motion localize SOURCE-LANGUAGE TARGET-LANGUAGE-1,TARGET-LANGUAGE-2,...
```

### localize

This command creates localization files for other languages.
If the file already exists, you will be prompted whether you wish to overwrite.

Example)

```
$ motion localize en fr,de,cn
Localize: resources/en.lproj/Localizable.strings
To: resources/fr.lproj/Localizable.strings
To: resources/de.lproj/Localizable.strings
To: resources/cn.lproj/Localizable.strings
```

## Thanks

[Babelish] (https://github.com/netbe/Babelish.git) showed how to parse Localizable.strings in ruby.

[translate-shell] (https://github.com/soimort/translate-shell.git) provides the translation for motion-localize.

And, last but not least, thanks to Watson for his amazing motion extension [motion-appstore] (https://github.com/Watson1978/motion-appstore.git). It was the inspiration for creating motion-localize.


