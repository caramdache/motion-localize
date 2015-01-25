# motion-localize

A RubyMotion plugin to provide localization commands for projects.

## Install

```
$ brew install http://www.soimort.org/translate-shell/translate-shell.rb
$ gem install motion-appstore
$ gem install motion-localize
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
$ motion localize en fr,de,zh
Localize: resources/en.lproj/Localizable.strings
To: resources/fr.lproj/Localizable.strings
To: resources/de.lproj/Localizable.strings
To: resources/zh-Hant.lproj/Localizable.strings (traditional Chinese)
To: resources/zh-Hans.lproj/Localizable.strings (simplified Chinese)
```

## Available language codes

Use trans for a list of available language codes.

```
$ trans -R
```

For Chinese, don't use the codes provided by 'trans', use 'zh' instead. 'zh' will produce both simplified ('zh-Hans') and traditional ('zh-Hant') Chinese.

## Thanks

[Babelish] (https://github.com/netbe/Babelish.git) showed how to parse Localizable.strings in ruby.

[translate-shell] (https://github.com/soimort/translate-shell.git) provides the translation for motion-localize.

Last but not least [motion-appstore] (https://github.com/Watson1978/motion-appstore.git) was the inspiration for motion-localize.

