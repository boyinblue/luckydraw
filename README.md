[워드프레스] 이벤트 관련 포스팅 자동화
===


본 디렉토리에 포함된 스크립트는 행사에서 사용하는 행운권 이미지를 
자동으로 생성해줍니다. 


### 파일 설명


본 디렉토리의 파일들은 GitHub에 업로드되어 관리되는 파일들과, 
업로드되지 않는 파일들이 있습니다. 


#### GitHub에서 관리되는 파일들


|파일명|용도|비고|
|--|--|--|
|auto.sh|이벤트 관련 정보를 긁어오는 스크립트|   |
|crontab.sh|crontab에서 자동으로 실행될 스크립트|   |
|install.sh|본 자동화 스크립트를 위해 필요한 환경 자동 구성|폰트|
|make_event_thumb.py|썸네일 이미지를 자동으로 생성|   |
|update_event.py|auto.sh로 추출한 데이터를 워드프레스에 자동 업로드|사용X|
|update_event2.py|auto.sh로 추출한 데이터를 워드프레스에 자동 업로드|  |
|README.md|본 파일|   |
|../wordpress|워드프레스 API를 호출하기 위한 스크립트들|   |


#### GitHub에서 관리되지 않는 파일들


|경로명|용도|비고|
|--|--|--|
|tmp|auto.sh 파일로 임시 생성되는 파일 및 디렉토리들|   |
|__pycache__|파이썬 실행시 생성되는 파일|   |


#### 다른 경로의 파일들


|경로명|용도|비고|
|--|--|--|


### 환경 구성 방법


자동화 스크립트 실행을 위해서는 몇 가지 환경 구성이 필요합니다. 


#### 패키지 설치


아래 명령을 통해서 필요한 패키지들을 설치합니다. 


```bash
$ sudo apt-get install python3
$ sudo apt-get install python3-pip
```


#### 폰트 설치


아래 명령을 통해서 네이버 클로바 손글씨 글꼴을 설치합니다. 
글꼴은 썸네일 자동 생성에 필요하고, 없을 경우 런타임 에러를 유발합니다. 


```bash
$ wget https://hangeul.naver.com/hangeul_static/webfont/zips/clova-all.zip
$ unzip clova-all.zip
$ sudo mv clova-all /usr/share/fonts/truetype/
$ sudo chown -R root: /usr/share/fonts/truetype/clova-all/
```


특정한 카테고리로 글이 잘못 올라갈 수 있습니다. 


#### crontab 설정


주기적으로 파이썬 스크립트를 실행시키기 위해서는 
crontab에 등록하는 방법이 아주 효과적입니다. 


<code>crontab -e</code> 명령을 통해서 <code>crontab.sh</code> 파일이 
주기적으로 실행될 수 있도록 설정해주시기 바랍니다. 


<code>crontab -l</code> 명령을 실행시켰을 때 아래와 같이 표시되면 됩니다. 


```bash
$ crontab -l
10 * * * * cd ~/project/crontab/blog_automation/004_epass; ./crontab.sh
```


위와 같이 설정하면 매일 매시 10분이 될때마다 
<code>./crontab.sh</code> 스크립트가 실행됩니다. 


### 실행 방법


<code>crontab.sh</code>가 실행되면 
이벤트 정보를 제공하는 사이트로부터 이벤트 관련 정보를 수집한 뒤, 
오직 하나의 이벤트 정보만 워드프레스에 업로드하게 됩니다. 


하지만 디버깅이나 수동 동작을 위해서 다른 스크립트를 실행할 수 있습니다. 


#### 이벤트 정보 긁어오기


이벤트 정보를 긁어오는 방법입니다. 
해당하는 스크립트는 <code>auto.sh</code> 스크립트입니다. 


광고 정보를 수집해서 <code>tmp/디렉토리명/data.txt</code> 파일에 
이벤트 관련 정보를 아래의 형식으로 저장합니다. 


```
응모기간|2022-06-01 
경품|에쓰-오일 모바일 주유상품권 1만원권
링크|https://www.s-oil.com/event/2020.aspx
```


위와 같은 파일일 생성되면 다음 단계로 
<code>update_event2.py</code> 스크립트가 이런 형식을 파일들을 처리합니다. 


#### 이벤트 정보 자동 업로드


이벤트 정보를 자동으로 업로드하는 스크립트는 
<code>update_event2.py</code> 파일입니다. 
tmp 디렉토리의 이벤트 정보 파일들을 찾아내서 
자동으로 포스팅을 합니다.


자동 포스팅을 한 이후에는 해당 데이터 파일을 삭제합니다. 


기존에 이미 업로드된 이벤트 정보가 있으면 포스팅을 하지 않습니다. 
중복 포스팅이 되는 것을 방지하기 위함입니다. 


#### 이벤트 정보 자동 관리 (구현중)


이벤트 정보를 자동으로 관리해주는 스크립트는 아직 미완성입니다. 
아래와 같은 역할을 할 것으로 기대합니다. 


- 응모 기간이 지난 이벤트는 다른 카테고리로 이동
- 응모 기한이 임박한 이벤트들만 추출하여 새 포스트 작성


### 추가 구현이 필요한 항목들


- [ ] "이벤트 정보" 카테고리 자동 생성
- [ ] 이벤트의 제목을 가져오는 방법
- [ ] 생성되는 썸네일 크기 변경 (1200 x 600)
- [ ] 생성되는 썸네일 크기 변경 (580 x 350)
- [ ] 테그 입력 (부수익, 부수입, 추가수입, 재테크, 투잡, 재택알바, 직장인 부수입, 부업)
- [ ] 중복 글 제거 (업로드시 중복 체크하므로 불필요)
- [ ] 글 내용 자동 작성



