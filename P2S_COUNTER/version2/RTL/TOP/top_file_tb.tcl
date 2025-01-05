restart
add_force {/top_file/I_STOP_VALUE} -radix hex {a 0ns}
add_force {/top_file/I_DATA} -radix hex {5 0ns}
add_force {/top_file/I_LOAD} -radix hex {0 0ns}
add_force {/top_file/I_RESET} -radix hex {0 0ns}
add_force {/top_file/I_CLK} -radix hex {0 0ns} {1 5000ps} -repeat_every 10000ps
add_force {/top_file/I_RESET} -radix hex {0 0ns} -cancel_after 10ns
run 10 ns
add_force {/top_file/I_RESET} -radix hex {1 0ns}
run 10 ns
add_force {/top_file/I_LOAD} -radix hex {1 0ns}
run 10 ns
add_force {/top_file/I_LOAD} -radix hex {0 0ns}
run 110 ns 