require './lib/missinglisp.rb'

def assert(expected, input)
  actual = Object.const_get(input)

  if actual != expected
    STDERR.puts "#{input} => #{expected} expected but got #{actual}"
    exit 1
  else
    puts "#{input} => #{actual}"
  end
end


assert 1, 'Lcar_Llist_1_2_3JJ'
assert [2, 3], 'Lcdr_Llist_1_2_3JJ'
assert [1, 2], 'Lcons_1_Llist_2JJ'
assert [1, 2, 3], 'Llist_1_2_3J'

assert 6, 'Ladd_1_2_3J'
assert 1, 'Lsub_2_1J'
assert 4, 'Lsub_10_1_2_3J'
assert 24, 'Lmult_2_3_4J'
assert 2, 'Ldiv_8_2_2J'


assert true, 'Leq_1_1J'
assert false, 'Leq_1_2J'
assert true, 'Leq_nil_nil_J'

assert true, 'Llt_1_2J'
assert false, 'Llt_1_1J'

assert true, 'Lleq_1_2J'
assert true, 'Lleq_1_1J'
assert false, 'Lleq_2_1J'

assert true, 'Lgt_2_1J'
assert false, 'Lgt_1_1J'

assert true, 'Lgeq_2_1J'
assert true, 'Lgeq_1_1J'
assert false, 'Lgeq_1_2J'


puts "Test finished successfully"
