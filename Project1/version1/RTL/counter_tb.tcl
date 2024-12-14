restart
add_force {/counter/i_0} -radix hex {0 0ns}
add_force {/counter/i_1} -radix hex {0 0ns}
add_force {/counter/i_2} -radix hex {0 0ns}
add_force {/counter/i_3} -radix hex {1 0ns}
add_force {/counter/i_clk} -radix hex {0 0ns} {1 2500ps} -repeat_every 5000ps
add_force {/counter/i_reset} -radix hex {0 0ns} -cancel_after 10ns
add_force {/counter/i_load} -radix hex {0 0ns}
run 20 ns
add_force {/counter/i_reset} -radix hex {1 0ns}
run 10 ns
add_force {/counter/i_load} -radix hex {1 0ns}
run 20 ns
add_force {/counter/i_load} -radix hex {0 0ns}
run 50 ns