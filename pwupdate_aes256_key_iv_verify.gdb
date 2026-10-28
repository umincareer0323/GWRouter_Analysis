set pagination off
target remote localhost:1237
break *0x10594
continue

printf "\n========== FIRMWARE AES-256-CBC DYNAMIC VERIFICATION ==========\n"
printf "Target Binary : fw_update_current\n"
printf "Call Address  : %p\n", $pc
printf "AES Function  : aes256_cbc_decrypt\n"
printf "Key Address   : %p\n", $r0
printf "AES-256 Key   : "
x/32cb $r0
printf "IV Address    : %p\n", $r1
printf "AES IV        : "
x/16cb $r1
printf "================================================================\n"
