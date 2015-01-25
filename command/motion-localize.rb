# -*- coding: utf-8 -*-

# Copyright (c) 2015 Caram Dache
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

require_relative 'utils'

module Motion; class Command
  class Localize < Command
    include Utils

    self.summary = 'Create additional localizations for an app.'
    self.arguments = 'SOURCE-LANGUAGE TARGET-LANGUAGE-1,TARGET-LANGUAGE-2,...'

    def initialize(argv)
      @source = argv.shift_argument

      @targets = argv.shift_argument
      @targets = @targets.split(',') if @targets
      super
    end

    def validate!
      super
      help! "https://github.com/soimort/translate-shell is not installed." unless File.exist?(TRANS_SHELL)
      help! "Specify the app's main language code." unless @source
      help! "Specify the language codes to create." unless @targets
    end

    def run
      localizable = localizable_path(@source)
      puts bold("Localize: ") + localizable

      lines = load_strings(localizable)
      @targets.each do |target|
        localize(@source, target, lines)
      end
    end

    def localize(source, target, lines)
      localizee = localizee_path(target)
      return unless localizee

      puts bold("To: ") + localizee
      file = File.open(localizee, 'w')

      lines.each do |line|
        line, key, value = line
        if value then
          localized_value = trans(source, target, value)
          file.write("\"#{key}\" = \"#{localized_value}\";")
        else
          file.write(line)
        end
        file.write("\n")
      end

      file.close
    end

  end
end; end
