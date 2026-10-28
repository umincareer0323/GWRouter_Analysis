# GWRouter PoC README

GWRouter v2.1.21 펌웨어 취약점 분석 및 검증 스크립트

| 파일명 | 용도 |
|---|---|
| admin_aes128_key_iv_verify.gdb | 관리자 인증 AES-128 Key 및 IV 확인 |
| admin_auth_verify.gdb | 관리자 기본 인증정보 확인 |
| pwupdate_aes256_key_iv_verify.gdb | 펌웨어 업데이트 AES-256 Key 및 IV 확인 |
| time_based_os_command_injection.sh | OS Command Injection 검증 |
| session_revoke.sh | 세션 토큰 부분 일치로 인한 타 사용자 세션 삭제 검증 |
| wireless_bof_poc.py | Stack-based Buffer Overflow 검증 |
