
#!/usr/bin/env bash
set -euo pipefail

BASE_URL="http://127.0.0.1:8080"
COOKIE_FILE="/tmp/gw_login_cookie.txt"

# 1. 기존 관리자 A 쿠키 확인
if [ ! -s "$COOKIE_FILE" ]; then
    echo "[ERROR] 관리자 A 쿠키 파일이 없습니다."
    exit 1
fi

A_TOKEN=$(awk '$6 == "GWSESSION" {print $7}' "$COOKIE_FILE")

if [ -z "$A_TOKEN" ]; then
    echo "[ERROR] GWSESSION 쿠키를 찾을 수 없습니다."
    exit 1
fi

echo "[1] 관리자 A 세션 쿠키 확인 완료"

# 2. 세션 목록 조회
echo
echo "[2] 활성 세션 조회"

SESSIONS=$(curl -fsS \
    -b "$COOKIE_FILE" \
    "$BASE_URL/cgi-bin/sessions.cgi")

echo "$SESSIONS" | python3 -m json.tool

# 3. A를 제외한 다른 세션 B 선택
echo
echo "[3] 다른 세션 B 검색"

TARGET_PREFIX=$(printf '%s' "$SESSIONS" | \
    python3 -c '
import json, sys

sessions = json.load(sys.stdin)
a_token = sys.argv[1]

for session in sessions:
    prefix = session.get("token", "").split("...")[0]

    if prefix and not a_token.startswith(prefix):
        print(prefix)
        break
' "$A_TOKEN")

if [ -z "$TARGET_PREFIX" ]; then
    echo "[ERROR] 삭제 가능한 다른 세션이 없습니다."
    exit 1
fi

echo "[+] 세션 B 접두사: $TARGET_PREFIX"

# 4. 세션 B 삭제
echo
read -rp "세션 B를 삭제하시겠습니까? (yes): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "[INFO] 취소했습니다."
    exit 0
fi

echo
echo "[4] 세션 B 삭제 요청"

curl -fsS \
    -b "$COOKIE_FILE" \
    --data-urlencode "action=revoke" \
    --data-urlencode "token=$TARGET_PREFIX" \
    "$BASE_URL/cgi-bin/sessions.cgi"

echo

# 5. 삭제 후 세션 목록 확인
echo
echo "[5] 삭제 후 활성 세션 조회"

curl -fsS \
    -b "$COOKIE_FILE" \
    "$BASE_URL/cgi-bin/sessions.cgi" | python3 -m json.tool

