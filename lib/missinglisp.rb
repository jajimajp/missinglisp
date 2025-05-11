class Lisp
  def initial_env
    {
      car: ->(*ls) { ls[0][0] },
      cdr: ->(*ls) { ls[0].drop 1 },
      cons: ->(e, cell, *) { [e] + cell },
      list: ->(*ls) { ls },
      add: ->(*ls) { ls.sum },
      sub: ->(hd, *tl) { tl.reduce(hd) { |sum, v| sum - v } },
      mult: ->(*ls) { ls.reduce(:*) },
      div: ->(hd, *tl) { tl.reduce(hd) { |sum, v| sum / v } },

      eq: ->(a, b, *) { a == b },
      lt: ->(a, b, *) { a < b },
      leq: ->(a, b, *) { a <= b },
      gt: ->(a, b, *) { a > b },
      geq: ->(a, b, *) { a >= b },

      length: ->(l, *) { l.length },

      # string
      aref: ->(s, at, *) { s[at] },
      concatenate: ->(_type, *ls) { ls.reduce(:+) },

      # char
      codeChar: ->(c, *) { c.chr },
      charCode: ->(c, *) { c.ord },

      readLine: ->(*) { $stdin.readline.chomp },

      p: ->(*ls) { p ls },
      print: ->(*ls) { p ls },
      writeLine: ->(s, *) { puts s },
      princ: ->(s, *) { print s; $stdout.flush },

      t: true,
      nil: []
    }
  end

  def eval(exp, env)
    return exp if exp.is_a? Numeric
    return exp if exp.is_a? String
    return env[exp] if exp.is_a? Symbol

    # list
    # Special forms
    if exp[0] == :quote
      return exp[1..]
    elsif exp[0] == :if
      _, test, e1, e2 = exp
      test = self.eval(test, env)
      truthy = if test.is_a?(Array) then !test.empty? else test end

      if truthy
        return self.eval(e1, env)
      end

      return self.eval(e2, env)
    elsif exp[0] == :define
      _, var, e = exp
      env[var] = self.eval(e, env)
      return []
    elsif exp[0] == :lambda
      _, params, e = exp
      return ->(*args) { self.eval(e, env.merge(Hash[params.zip(args)])) }
    elsif exp[0] == :progn
      return self.eval_stmts(exp[1..], env)
    end

    # function application
    values = exp.map { |c| self.eval(c, env) }
    values[0].call(*values[1..])
  end

  # Evaluates list of lisp values e.g. Ldefine_a_1JLp_a_J
  def eval_stmts(exp, env)
    if !exp.is_a?(Array)
      STDERR.puts 'eval_stmts: not a list'
      exit 1
    end

    res = nil
    exp.each do |stmt|
      res = self.eval(stmt, env)
    end

    res
  end

  def parse(program)
    tokens = tokenize program
    _parse tokens
  end

  def _parse(tokens)
    stmts = []
    while !tokens.empty?
      stmts << parse_stmt(tokens)
    end

    stmts
  end

  def parse_stmt(tokens)
    return if tokens.empty?

    token = tokens.shift

    case token
    when :L
      list = []

      while tokens.first != :J
        raise 'unexpected end of input' if tokens.empty?

        list << parse_stmt(tokens)
      end
      tokens.shift

      list
    when :J
      raise 'unexpected \'J\''
    else
      token
    end
  end

  def tokenize(s)
    res = []
    cur = ''
    is_reading_digit = false
    is_reading_string = false
    s.each_char do |c|
      case c
      when '_'
        cur += ' ' and next if is_reading_string

        if cur != ''
          if is_reading_digit
            res.push cur.to_i
          else
            res.push cur.to_sym
          end

          cur = ''
          is_reading_digit = false
        end
      when 'L'
        if cur != ''
          if is_reading_digit
            res.push cur.to_i
            cur = ''
            is_reading_digit = false
            res.push :L
            next
          end

          cur += 'L' and next
        end

        res.push :L
      when 'J'
        if cur != ''
          if is_reading_digit
            res.push cur.to_i
            cur = ''
            is_reading_digit = false
            res.push :J
            next
          end

          cur += 'J' and next
        end

        res.push :J
      when 'Q'
        if is_reading_string
          res.push cur
          cur = ''
          is_reading_string = false
          next
        elsif is_reading_digit
          res.push cur.to_i
          cur = ''
          is_reading_digit = false
          is_reading_string = true
          next
        end

        if cur != ''
          cur += 'Q'
        else
          is_reading_string = true
        end
      when '0'..'9'
        cur += c and next if cur != ''

        is_reading_digit = true
        cur = c
      else
        if is_reading_digit
          res.push cur.to_i
          cur = ''
          is_reading_digit = false
        end

        cur += c
      end
    end

    res.push cur.to_sym if cur != ''

    res
  end
end

module Kernel
  # For irb
  WHITE_LIST = %I[gets to_ary to_io to_str to_hash translate]
  alias_method :base_method_missing, :method_missing

  def eval_lisp(s)
    @l ||= Lisp.new
    @e ||= @l.initial_env
    @l.eval_stmts(@l.parse(s), @e)
  end

  def method_missing(m, *args, &block)
    if WHITE_LIST.include? m
      base_method_missing(m, args, block)
    end

    eval_lisp m.to_s
  end
end

class Object
  def self.const_missing(id)
    eval_lisp id.to_s
  end
end
