# ssh

1. `apt search openssh-server`로 설치 확인, 없으면 설치

`systemctl status ssh`로 실행여부, 포트 확인 가능

2. `sudo ufw allow 4242` 4242포트 허용

3. `/etc/ssh/sshd_config` 파일 port 수정 (주석 해제 후 4242로변경)

4. virtualbox 실행 후 좌상단 `file/hostnetwork manager`에서 create로 `vboxnet0`생성
5. 맥 터미널에서 ifconfig 실행 후 vboxnet0 이 추가되었는지 확인
6. VM settings/network/adapter2 탭에서 Attached to : `Host-only Adapter` 선택, 이름은 vboxnet0
7. 데비안에 들어가 `/etc/network/interfaces` 수정
<pre>auto "호스트 네트워크 인터페이스의 이름"
iface "호스트네트워크 인터페이스의 이름" inet static
address 192.168.56.10
netmask 255.255.255.0</pre>을 추가

8. sudo ifup "인터페이스이름"
9. VM settings/network/adapter1(NAT)/advanced/portforwarding 에 rule추가, 포트는 4242
10. 맥 터미널에서 `ssh -p4242 "user"@192.168.56.10` 접속

## root계정 제한
etc/ssh/sshd_config 파일 수정
- PermitRootLogin 옵션 no로 변경
- `service ssh restart`

## 특정계정 su 획득 권한

- etc/pam.d/su 파일에서 `auto required pam_wheel.so` 주석 해제
- addgroup --system wheel (루트권한을 가진 그룹 wheel생성)
- add user "user" wheel 사용자를 wheel그룹에 추가

