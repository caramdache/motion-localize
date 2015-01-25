# -*- coding: utf-8 -*-

# Copyright (c) 2015 Caram Dache
# Portions copyright (c) 2013 François Benaiteau (Babelish)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module Utils
  TRANS_SHELL = '/usr/local/bin/trans'

  def trans(source, target, string)
    target = fix_target(target)

    string.split('\n').collect do |substring|
      next if substring.length == 0

      translation = unless substring =~ /^http/ then
        `#{TRANS_SHELL} -b #{source}:#{target} \"#{substring}\" 2>&1`.split("\n").first
      else
        substring
      end

      fix_trans(translation)
    end.join('\n')
  end

  def fix_target(target)
    case target
      when /zh-Hant/ then 'zh-TW'
      when /zh-Hans/ then 'zh-CN'
      else target
    end
  end

  def fix_trans(string)
    string.gsub!(/"([^"]+)"/, ' \'\1\' ') # replace " by '
    string.gsub!(/"/, '\'')               # there may be some " left
    string.gsub!(/\( /, ' (')             # space before (, not after
    string.gsub!(/  /, ' ')               # remove double-spaces
    string.gsub!(/ \./, '.')              # no space before .
    string.gsub!(/\\ U([0-9]+)/, '\\U\1') # reassemble Unicode definitions
    string
  end

  def localizable_path(lang)
    unless File.exist?('Rakefile')
      help! "Run on root directoy of RubyMotion project."
    end

    # select Localizable.strings in resources directory.
    localizable = Dir.glob("resources/#{lang}.lproj/Localizable.strings").first
    unless localizable
      help! "Cannot find source Localizable.strings."
    end
    localizable
  end

  def localizee_path(lang)
    dir_path = "resources/#{lang}.lproj"
    unless Dir.exist?(dir_path) then
      Dir.mkdir(dir_path)
    end

    file_path = "resources/#{lang}.lproj/Localizable.strings"
    if File.exist?(file_path) then
      prompt = bold("Are you sure you wish to overwrite the existing #{lang} localization? [y|N] : ")
      print prompt
      answer = STDIN.gets().strip
      unless answer =~ /^[yY][eE]?[sS]?$/ then
        return nil
      end
    end

    File.write(file_path, "")
    Dir.glob(file_path).first
  end

  def parse_dotstrings_line(line)
    line.strip!
    if line[0] != ?# && line[0] != ?= && line[0] != ?/
      m = line.match(/^[^\"]*\"(.+)\"[^=]+=[^\"]*\"(.*)\";/)
      return [line, m[1], m[2]] unless m.nil?
    end
    [line, nil, nil]
  end

  # Load all strings of a given file
  def load_strings(strings_filename)
    lines = []

    # genstrings uses utf16, so that's what we expect. utf8 should not be impact
    file = File.open(strings_filename, "r:utf-16:utf-8")
    begin
      contents = file.read
    rescue Encoding::InvalidByteSequenceError => e
      contents = File.open(strings_filename, "r:utf-8")
    end
    contents.each_line do |line|
      array = self.parse_dotstrings_line(line)
      lines << array
    end

    lines
  end
end
