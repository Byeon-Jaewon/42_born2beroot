# 42_born2beroot

## Chapter 2 - 소개

이 프로젝트는 당신에게 개쩌는 가상세계를 소개하는 것에 집중됩니다.


당신은 `VirtualBox` (`VirtualBox`를 사용할 수 없다면 `UTM`)에서 구체적인 지시를 따라 당신의 첫번째 머신을 만들어야합니다. 그리고 이 프로젝트의 끝에서 당신은, 엄격한 규칙 아래에서 당신의 OS를 설치할 수 있어야 합니다.


## Chapter 3 - General Guidelines

- `VirtualBox`를 이용해야합니다. (이용하지 못할 경우 `UTM`)
- repository의 루트경로에 `signature.txt` 파일만 있어야 합니다. 이 안에 당신의 가상머신 디스크 시그니쳐를 붙여넣어야 됩니다. 제출과 동료평가에서 더 많은 정보를 알 수 있습니다.


## Chapter 4 - 필수 파트

이 프로젝트는 특정 규칙을 준수하여 첫 번째 서버를 설정하는 작업으로 구성됩니다. 

> 서버 설치의 상황이기 때문에, 최소한의 서비스를 설치해야합니다.
> 이런 이유로, 그래픽 인터페이스는 여기서 사용하지 않습니다.
> `X.org`나 다른 비슷한 그래픽서버는 금지됩니다. 그러지 않을 경우 0점입니다.

`Debian`(no testing/unstable)의 최신버전이나 `CentOS`의 최신버전 둘 중 하나를 선택해야합니다. 시스템 관리가 처음일 경우 `Debian`을 추천합니다.

> `CentOS`를 설치하는 것은 복잡합니다. 그러므로 `KDump`를 설치할 필요가 없습니다. 그러나 `SELinux`는 시작할 때 실행되고 있어야 하며 프로젝트의 필요에 따라 설정을 조정해야합니다. 
> `Debian`의 `AppArmor` 역시 시작할 때 실행되고 있어야합니다.


`LVM`을 이용하여 암호화된 파티션을 적어도 2개 만들어야 합니다. 아래는 파티션의 예시입니다.
<pre>
wil@wil:~$ lsblk
NAME                    MAJ:MIN   RM    SIZE    RO      TYPE    MOUNTPOINT
sda                       8:0      0      8G     0      disk
├sda1                     8:1      0    487M     0      part    /boot
├sda2                     8:2      0      1K     0      part
├sda5                     8:5      0    7.5G     0      part
   ├sda5_crypt          254:0      0    7.5G     0      crypt
      ├wil--vg-root     254:1      0    2.8G     0      lvm     /
      ├wil--vg-swap_1   254:2      0    976M     0      lvm     [SWAP]
      ├wil--vg-home     254:3      0    3.8G     0      lvm     /home
sr0                      11:0      1   1024M     0      rom
wil@wil:~$
</pre>

> 디펜스에서, 당신은 당신이 고른 운영체제에 대한 몇가지 질문을 물어보게 될 것입니다. 
> 예를 들어, `apt`와 `aptitude`의 차이점이나, `SELinux`나 `AppArmor`가 무엇인지 알아야 합니다. 
> 짧게 말해 당신이 사용하는 것에 대해 이해해야합니다!

`SSH`는 4242포트로만 실행되어야 한다. 보안을 이유로, `SSH`를 이용하여 루트에 연결하는 것은 불가능해야합니다.

> `SSH`의 이용은 새로운 계정을 만드는 것으로 테스트될 것입니다.
> 그러므로 당신은 `SSH`가 어떻게 작동되는지 이해해야 합니다.

당신은 `UFW 방화벽`으로 운영체제를 구성하고 4242포트만을 열어놔야 합니다.

> 당신의 방화벽은 가상머신이 실행될때 실행되어야합니다.   
> `CentOS`에서 당신은 기본 방화벽 대신 `UFW`를 사용해야합니다.
> 이것을 설치하기 위해 아마도 `DNF`가 필요할 것입니다.

- 가상머신의 hostname은 당신의 로그인 아이디에 42를 붙여야 합니다. (예를 들어, wil42)
- 강한 비밀번호 정책을 시행해야합니다.
- 엄격한 규칙에 따라 `sudo`를 설치하고 설정해야합니다.
- 루트이용자 외에도, 로그인한 사용자가 있어야 합니다.
- 이 유저는 `user42`와 `sudo`그룹에 속해야 합니다.

> 디펜스에서, 당신은 새로운 유저를 만들고 그룹에 할당해야할 것입니다.

강한 비밀번호정책을 설정하기 위해 당신은 따라오는 요구사항을 준수해야합니다.
- 비밀번호는 30일마다 만료된다.
- 
