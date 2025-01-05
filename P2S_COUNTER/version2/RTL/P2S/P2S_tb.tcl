restart
add_force {/P2S/i_data_p} -radix hex {a 0ns}
add_force {/P2S/i_reset} -radix hex {0 0ns}
add_force {/P2S/i_clk} -radix hex {0 0ns} {1 5000ps} -repeat_every 10000ps
add_force {/P2S/i_valid} -radix hex {0 0ns}
run 10 ns
add_force {/P2S/i_reset} -radix hex {1 0ns}
run 20ns
add_force {/P2S/i_valid} -radix hex {1 0ns}
run 60 ns 
add_force {/P2S/i_valid} -radix hex {0 0ns}
run 20 ns 