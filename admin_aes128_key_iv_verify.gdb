set pagination off
target remote localhost:1235
break *0x10668
continue

printf "\n========== ADMIN AES-128 DYNAMIC VERIFICATION ==========\n"
printf "Target Binary : login_verify.cgi\n"
printf "Call Address  : %p\n", $pc
printf "AES Function  : aes128_cbc_encrypt\n"
printf "Key Address   : %p\n", $r0
printf "AES Key       : "
x/16cb $r0
printf "IV Address    : %p\n", $r1
printf "AES IV        : "
x/16cb $r1
printf "========================================================\n"
