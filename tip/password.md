# 비밀번호 정책 설정
debian 기준

### 기본 비밀번호 항목 지정

1. `/etc/login.defs/` 파일 참조
- PASS_MAX_DAYS : 비밀번호를 사용할 수 있는 최대 일 수
- PASS_MIN_DAYS : 비밀번호를 바꿀 수 있는 최소 간격
- PASS_MIN_LEN : 비밀번호의 최소 길이
- PASS_WARN_AGE : 비밀번호 만료 전, 경고하는 날짜

> `login.defs`파일을 수정하는 경우, 수정 이후에 생성되는 계정에만 적용.

2. chage 명령어
- 정책확인
<pre> # chage -l "계정명"
Last password change : Jun 09, 2021
Password expires : Jul 09, 2021
Password inactive : never
Account expires : never
Minimum number of days between password change : 2
Maximum number of days between password change : 30
Number of days of warning before password expires : 7 </pre>

- `chage -m 2 "계정명"` :비밀번호 변경 최소 간격 조정
- `chage -M 30 "계정명"` : 비밀번호 유효기간 조정
- `chage -W 7 "계정명"` : 경고날짜 조정
