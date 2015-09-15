require "agile/version"

module Agile
  class Diff
    ACTIONS = {'-' => 'deleted', '*' => 'changed', '+' => 'added'}

    attr_accessor :action, :line, :old_val, :new_val

    def initialize(action, line, old_val, new_val)
      @action, @line, @old_val, @new_val = action, line, old_val, new_val
    end

    ACTIONS.each do |key, val|
      define_method("#{val}?") {
        @action == key
      }
    end
  end

  class Comparer
    DEFAULT_VALUES = {
        max_lines: 99999999,
        diff_header_length: 3
    }

    DEFAULT_VALUES.keys.each { |attr| attr_accessor attr }

    def initialize(options = {})
      DEFAULT_VALUES.each do |key, val|
        send("#{key}=", options[key] || val)
      end
    end

    def compare(file1_path, file2_path)
      differences = diff(file1_path, file2_path)
      lines = formatter(differences)

      lines.map do |line|
        body = case line.action
                 when '-'
                   "#{line.old_val}"
                 when '*'
                   "#{line.old_val} | #{line.new_val}"
                 when '+'
                   "#{line.new_val}"
               end
        "#{line.action} #{body}"
      end.join("\n")

    end

    private

    def get_objects(lines)
      lines.map do |line, index|
        Diff.new(line[0], index, line[1..-1], line[1..-1])
      end
    end

    def formatter(diff)
      lines = diff.split(/\n/)[@diff_header_length..@max_lines]
      get_objects(lines)
    end

    def diff(file1_path, file2_path)
      %x(diff -U #{@max_lines} #{file1_path} #{file2_path})
    end
  end
end

