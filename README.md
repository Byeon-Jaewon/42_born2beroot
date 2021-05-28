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
- 비밀번호는 최소 2일을 사용해야 수정할 수 있다.
- 사용자는 비밀번호 만료 7일전 경고메세지를 받는다.
- 비밀번호는 최소 10개의 문자가 있어야 하고, 대문자와 숫자를 포함해야한다. 또한 동일한 문자를 3자 이상 포함할 수 없다.
- 비밀번호에 사용자의 이름이 포함될 수 없다.
- 비밀번호는 이전 비밀번호에 포함되지않는 문자가 최소한 7자 들어가야한다.
- 당연히, 루트 비밀번호도 이 정책을 준수해야한다.

> 설정파일에 세팅이 끝난 후, 당신은 루트계정을 포함한 현재 가상머신에 존재하는 모든 계정의 비밀번호를 바꿔야한다.



`sudo`그룸에 강한 환경설정을 설치하기 위해 당신은 따라오는 요구사항을 준수해야합니다.
- `sudo`를 사용하는 인증은 3번의 시도로 제한한다.
- `sudo`를 사용할때 잘못된 비밀번호를 입력한다면 당신이 선택한 메세지가 보여져야한다.
- 입출력 모두 `sudo`를 사용하는 행동은 보관되어야 한다. 로그파일은 `/var/log/sudo/`폴더에 저장한다.
- 보안적인 이유로 `TTY`모드는 사용가능 해야한다.
- 역시 보안을 위해, `sudo`를 사용할 수 있는 경로는 한정적이다. 예를 들어 `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/snap/bin`



마지막으로, 당신은 `monitoring.sh`라는 간단한 스크립트를 만들어야합니다. 반드시 `bash`를 이용하세요.


서버가 시작될때 스크립트는 10분마다 모든 터미널의 일부 정보(아래 목록)을 보여줘야 할 것입니다(`wall`를 찾아보세요). 배너는 옵션입니다. 오류는 볼 수 없어야 합니다.

- 운영체제의 구조와 커널버전
- physical processor의 수
- virtual processor의 수
- 서버에 허용된 램과 사용률(백분율로)
- 허용된 메모리와 사용률(백분율로)
- 프로세서의 사용률(백분율로)
- 마지막 재부팅의 날짜와 시간
- LVM이 켜져있는지 아닌지
- 활성화된 연결의 수
- 사용자의 수
- 서버의 IPv4 주소와 MAC 주소
- sudo를 실행한 명령어의 수

> 디펜스에서, 이 스크립트가 어떻게 동작하는지 설명해야합니다. 또한 수정없이 인터럽트를 해야합니다. `cron`을 찾아보세요.
<pre>
Broadcast message from root@wil (tty1) (Sun Apr 25 15:45:00 2021):
   #Architecture: Linux wil 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64 GNU/Linux
   #CPU physical : 1
   #vCPU : 1
   #Memory Usage: 74/987MB (7.50%)
   #Disk Usage: 1009/2Gb (39%)
   #CPU load: 6.7%
   #Last boot: 2021-04-25 14:45
   #LVM use: yes
   #Connexions TCP : 1 ESTABLISHED
   #User log: 1
   #Network: IP 10.0.2.15 (08:00:27:51:9b:a5)
   #Sudo : 42 cmd
</pre>


## Chpater V - Bonus Part

보너스리스트 :
- 아래의 구조와 비슷하게 파티션을 설치하세요.
<pre>
# lsblk
NAME                         MAJ:MIN   RM    SIZE    RO      TYPE    MOUNTPOINT
sda                            8:0      0      8G     0      disk
├sda1                          8:1      0    487M     0      part    /boot
├sda2                          8:2      0      1K     0      part
├sda5                          8:5      0   30.3G     0      part
   ├sda5_crypt               254:0      0   30.3G     0      crypt
      ├LVMGroup--vg-root     254:1      0     10G     0      lvm     /
      ├LVMGroup--vg-swap     254:2      0    2.3G     0      lvm     [SWAP]
      ├LVMGroup--vg-home     254:3      0      5G     0      lvm     /home
      ├LVMGroup--vg-var      254:4      0      3G     0      lvm     /var
      ├LVMGroup--vg-srv      254:5      0      3G     0      lvm     /srv
      ├LVMGroup--vg-tmp      254:6      0      3G     0      lvm     /tmp
      ├LVMGroup--vg-var--log 254:7      0      4G     0      lvm     /home
sr0                           11:0      1   1024M     0      rom
</pre>
- `Lighttpd`, `MariaDB`, `PHP`등의 서비스를 사용하여 , `WordPress`를 설정하세요.
- 당신이 생각하기에 유용한 서비스(`NGINX / APACHE2`를 제외한)를 설치하세요. 디펜스동안 당신의 선택을 설명해야합니다.
> 보너스파트를 마치기 위해 당신은 다른 서비스를 설정할 수 있습니다.    
>  이 경우 당신은 필요에 따라 더 많은 포트를 열 수 있습니다.   
>  물론 UFW규칙은 그에 맞게 조정되어야 합니다.   
>> 보너스파트는 필수파트가 완벽할때만 평가됩니다.     
>> 완벽하다는 것은 필수 파트가 오작동없이 통합적으로 작동된다는 것을 의미합니다.   
>>  모든 필수 파트 요구사항을 통과하지 못한다면, 당신의 보너스파트는 평가되지 않습니다.   
## Chapter 6 - 제출과 동료평가

당신의 Git repository의 루트 경로에 `signature.txt`파일만 있어야합니다. 당신은 반드시 가상디스크의 시그니쳐를 붙여넣어야 합니다.
시그니쳐를 얻기 위해, 기본설치폴더(VM이 저장된 폴더)를 열어야 합니다.
- Windows : `%HOMEDRIVE%%HOMEPATH%\VirtualBox VMs\`
- Linux   : `~/VirtualBox VMs/`
- MacM1   : `~/Library/Containers/com.utmapp.UTM/Data/Documents`
- MacOS   : `~/VirtualBox Vms/`


그리고 sha1형식의 가상머신의 ".vdi"파일(UTM유저는 .qcow2)로부터 시그니쳐를 회수해야합니다.
아래 4개의 예시는 centos_serv.vdi파일입니다.
- Windows    : certUtil -hashfile centos_serv.vdi sha1
- Linux      : sha1sum centos_serv.vdi
- For Mac M1 : shasum Centos.utm/Images/disk-0.qcow2
- MacOS      : shasum centos_serv.vdi

당신이 얻어야할 출력의 예시입니다.
- 6e657c4619944be17df3c31faa030c25e43e40af

> 첫 평가후에 가상머신의 시그니쳐가 변경될 수 있습니다. 이문제를 해결하기위해 가상머신을 복제하거나 저장상태를 사용할 수 있습니다.
>> 물론 Git repository에 가상머신을 제출하는 것은 금지되어 있습니다. 디펜스동안 당신의 signature.txt파일이 가상머신파일과 비교됩니다. 만약 두개가 동일하지 않다면 0점입니다.
