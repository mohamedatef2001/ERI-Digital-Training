restart
add_force {/counter/i_data} -radix hex {5 0ns}
add_force {/counter/i_stop_value} -radix hex {a 0ns}
add_force {/counter/i_clk} -radix hex {0 0ns} {1 5000ps} -repeat_every 10000ps
add_force {/counter/i_reset} -radix hex {0 0ns} -cancel_after 10ns
add_force {/counter/i_load} -radix hex {0 0ns}
run 10 ns
add_force {/counter/i_reset} -radix hex {1 0ns}
run 10 ns
add_force {/counter/i_load} -radix hex {1 0ns}
run 10 ns
add_force {/counter/i_load} -radix hex {0 0ns}
run 70 ns