restart
add_force {/TOP/I_PCLK} -radix hex {0 0ns} {1 5000ps} -repeat_every 10000ps
add_force {/TOP/I_PRESETn} -radix hex {0 0ns}
add_force {/TOP/I_transfer} -radix hex {0 0ns}
add_force {/TOP/I_READ_WRITE} -radix hex {1 0ns}
add_force {/TOP/I_apb_write_paddr} -radix hex {0 0ns}
add_force {/TOP/I_apb_write_data} -radix hex {a 0ns}
add_force {/TOP/I_apb_read_paddr} -radix hex {0 0ns}
run 10 ns
add_force {/TOP/I_PRESETn} -radix hex {1 0ns}
add_force {/TOP/I_transfer} -radix hex {1 0ns}
run 10 ns
add_force {/TOP/I_transfer} -radix hex {0 0ns}
run 10 ns
run 10 ns
add_force {/TOP/I_transfer} -radix hex {1 0ns}
add_force {/TOP/I_READ_WRITE} -radix hex {0 0ns}
run 10 ns
add_force {/TOP/I_transfer} -radix hex {0 0ns}
run 10 ns
run 10 ns