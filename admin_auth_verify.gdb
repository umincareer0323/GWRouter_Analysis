set pagination off
set confirm off

target remote localhost:1239

# 관리자 계정명 비교
break *0x10328
commands
  silent
  printf "\n========== [1] 관리자 계정명 검증 ==========\n"
  printf "입력 계정명: "
  x/s $r0
  printf "비교 계정명: "
  x/s $r1
  printf "===========================================\n"
  continue
end

# 암호화된 비밀번호 비교
break *0x10384
commands
  silent
  printf "\n========== [2] 관리자 비밀번호 검증 ==========\n"
  printf "입력 비밀번호 암호문: "
  x/s $r0
  printf "실제 인증 비교값: "
  x/s $r1
  printf "============================================\n"
  continue
end

continue
