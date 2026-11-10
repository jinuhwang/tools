# imd + Vim IMD

macOS 입력기를 빠르게 전환하는 상주 프로그램 `imd`와 Obsidian용 `Vim IMD` 플러그인.

`imd`는 입력기 정보를 메모리에 보관하고 FIFO로 전환 요청을 받는다. 요청마다
`im-select` 프로세스를 실행하거나 입력기 목록을 다시 조회하는 비용을 줄인다.
Obsidian 플러그인은 Vim insert 모드를 벗어날 때 ABC로 전환하고, 다시 insert 모드에
들어가면 이전 입력기(예: 한글 두벌식)로 복귀한다.

## 설치

필요한 환경:

- macOS의 로그인된 데스크톱 세션. `imd`는 사용자별 LaunchAgent로 실행된다.
- Swift 컴파일러. 없다면 `xcode-select --install`로 Command Line Tools를 설치한다.
- macOS 입력 소스에 **ABC**와 사용할 한글 입력기가 추가되어 있어야 한다.

저장소가 이미 있다면:

```sh
cd ~/workspace/tools
git pull --ff-only
./mac/imd/install.sh
```

새 맥에서 처음 받는다면:

```sh
mkdir -p ~/workspace
git clone https://github.com/jinuhwang/tools.git ~/workspace/tools
cd ~/workspace/tools
./mac/imd/install.sh
```

설치 스크립트는 소스를 컴파일해 `~/.local/bin/imd`에 넣고,
`~/Library/LaunchAgents/local.imd.plist`를 등록한 뒤 바로 실행한다.
이후 로그인 시 자동 실행되며, 프로세스가 종료되면 launchd가 다시 실행한다.
성공하면 `imd running: <입력기 ID>`가 출력된다.

## Obsidian 연결

이미 사용 중인 vault에서 `.obsidian/plugins/vim-imd/`와 활성화 설정이 다른 맥으로
동기화되었다면, **그 맥에서 위의 `imd` 설치만 한 번 실행하면 된다.**
바이너리와 LaunchAgent는 vault에 포함되지 않으므로 Mac마다 설치해야 한다.

플러그인이 없는 vault에는 저장소 루트에서 아래처럼 복사한다. `VAULT`는 실제 vault
경로로 바꾼다. 별도 설정 폴더를 쓰는 vault라면 `.obsidian`도 그 이름으로 바꾼다.

```sh
VAULT="$HOME/path/to/vault"
mkdir -p "$VAULT/.obsidian/plugins/vim-imd"
cp mac/imd/obsidian/vim-imd/main.js \
   mac/imd/obsidian/vim-imd/manifest.json \
   "$VAULT/.obsidian/plugins/vim-imd/"
```

1. Obsidian을 다시 실행한다.
2. 설정에서 Vim 키 바인딩을 켠다.
3. 커뮤니티 플러그인을 허용하고 **Vim IMD**를 켠다.
4. 기존 **vim-im-control** 등 입력기를 자동 전환하는 플러그인은 꺼서 충돌을 피한다.

확인 방법: 노트의 insert 모드에서 한글을 입력한 뒤 `Esc`를 누르면 ABC로 전환되고,
`i`로 다시 insert 모드에 들어가면 한글로 돌아와야 한다.

플러그인은 macOS에서만 동작한다. iPhone/iPad에서는 데스크톱 전용이라 로드되지 않고,
Windows/Linux에서는 동작하지 않는다. `imd`가 없는 맥에서는 자동 전환이 작동하지 않는다.
이 플러그인은 Obsidian용이며, 터미널 Vim/Neovim은 별도로 연동해야 한다.

## 터미널에서 직접 사용

현재 입력기 ID 확인:

```sh
cat "/tmp/imd-$(id -u).current"
```

ABC로 전환:

```sh
IMD_FIFO="/tmp/imd-$(id -u).fifo"
test -p "$IMD_FIFO" && printf '%s\n' com.apple.keylayout.ABC 1<> "$IMD_FIFO"
```

다른 입력기로 전환하려면 `com.apple.keylayout.ABC`를 해당 입력기 ID로 바꾼다.
ID를 모르면 메뉴 막대 등으로 원하는 입력기를 수동 선택한 뒤 `.current` 파일을 읽는다.
요청은 **입력기 ID 하나 + 줄바꿈** 형식이며, `1<>`는 FIFO를 읽기/쓰기 모드로 연다.
실제로 전환하려면 `imd`가 실행 중이어야 한다.

전환은 비동기로 처리된다. `.current` 파일에는 전환 요청 직후 요청한 ID가 먼저 기록되고,
macOS의 입력기 변경 알림이 오면 실제 상태로 갱신된다. 따라서 요청 직후 읽은 값만으로
OS 전환 완료를 확인할 수는 없다. 키보드로 수동 전환한 상태도 변경 알림을 통해 반영된다.

## 업데이트와 문제 해결

소스 업데이트 후 설치 스크립트를 다시 실행하면 재컴파일하고 서비스를 재시작한다.

```sh
cd ~/workspace/tools
git pull --ff-only
./mac/imd/install.sh
```

Obsidian 플러그인은 자동 업데이트되지 않는다. 플러그인 파일도 변경되었다면 위 복사
명령을 다시 실행한 뒤 Obsidian을 재시작한다. vault 동기화를 쓰는 경우에는 복사한
플러그인 폴더가 다른 기기에도 동기화되는지 확인한다.

실행 상태와 오류 로그:

```sh
launchctl print "gui/$(id -u)/local.imd"
cat /tmp/imd.log
ls -l "/tmp/imd-$(id -u).fifo" "/tmp/imd-$(id -u).current"
```

등록된 서비스를 재시작하려면:

```sh
launchctl kickstart -k "gui/$(id -u)/local.imd"
```

- 서비스가 등록되지 않았거나 파일이 없다면 `install.sh`를 다시 실행한다.
- ABC로 전환되지 않으면 macOS 입력 소스에 ABC가 추가되어 있는지 확인한다.
- 터미널 전환은 되는데 Obsidian에서 안 되면 Vim 모드와 Vim IMD 활성화 여부를 확인하고,
  Obsidian을 재시작한다. 플러그인은 내부 CodeMirror 연결을 사용하므로 Obsidian 업데이트로
  동작이 바뀌면 플러그인 수정이 필요할 수 있다.

## 제거

먼저 Obsidian에서 Vim IMD를 끄고, 아래 명령으로 서비스를 내린다.
이미 중지되어 있다면 첫 명령은 오류가 날 수 있다.

```sh
launchctl bootout "gui/$(id -u)/local.imd"
rm -f "$HOME/Library/LaunchAgents/local.imd.plist" "$HOME/.local/bin/imd"
rm -f "/tmp/imd-$(id -u).fifo" "/tmp/imd-$(id -u).current"
```

플러그인도 제거하려면 vault의 `.obsidian/plugins/vim-imd/` 폴더를 삭제한다.
동기화하는 vault에서는 다른 기기에도 삭제가 반영될 수 있다.

## 파일 구성

| 파일 | 역할 |
| --- | --- |
| `imd.swift` | macOS 입력기 전환 데몬 |
| `local.imd.plist` | LaunchAgent 템플릿 (`__HOME__`은 설치 시 치환) |
| `install.sh` | 컴파일, 설치, 서비스 등록 및 재시작 |
| `obsidian/vim-imd/main.js` | Obsidian Vim 모드 변경과 `imd` 연결 |
| `obsidian/vim-imd/manifest.json` | Obsidian 플러그인 정보 |
