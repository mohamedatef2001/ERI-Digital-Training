restart
add_force {/APB_top/PCLK} -radix hex {1 0ns} {0 50000ps} -repeat_every 100000ps
add_force {/APB_top/transfer} -radix hex {1 0ns}
add_force {/APB_top/PRESETn} -radix hex {0 0ns}
add_force {/APB_top/READ_WRITE} -radix hex {1 0ns}
add_force {/APB_top/apb_write_paddr} -radix hex {20 0ns}
add_force {/APB_top/apb_write_data} -radix hex {78 0ns}
run 100 ns
add_force {/APB_top/PRESETn} -radix hex {1 0ns}
run 100 ns
run 100 ns
run 100 ns
add_force {/APB_top/READ_WRITE} -radix hex {0 0ns}
run 100 ns
run 100 ns
run 100 ns