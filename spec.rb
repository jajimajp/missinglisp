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
assert [], 'Llist_J'

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


assert [:a, :b, 1], 'Lquote_a_b_1J'
assert [[:add, 1, 2], :b, 1], 'Lquote_Ladd_1_2J_b_1J'
assert 1, 'Lif_t_1_2J'
assert 2, 'Lif_nil_1_2J'

assert 3, 'Ldefine_a_1JLadd_a_2J'
assert 2, 'Ldefine_succ_Llambda_Ln_JLadd_n_1JJJLsucc_1J'
assert 120, 'Ldefine_fact_Llambda_Ln_JLif_Lleq_n_0J1Lmult_n_Lfact_Lsub_n_1JJJJJJLfact_5J'


puts "Test finished successfully"
