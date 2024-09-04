# CTED
CTED는 Crossfit Training Every Day의 약자로 크로스핏과 관련된 운동프로그램(루틴)을 구독하여 구독한 프로그램과 함께 운동할 수 있는 어플리케이션입니다.
### 목차
- 프로젝트 소개
    - 기능 소개
    - 사용 기술

- 프로젝트를 하면서...
    - 프로젝트 주제 선정 계기
    - 느낀점

- 마무리

# 1. 프로젝트 소개
CTED는 우리 앱의 이름으로 위에 언급했듯 Crossfit Training Every Day의 약자입니다. CTED에서 제공하는 운동프로그램을 구독하여 프로그램과 함께 운동할 수 있습니다. 

앱의 페이지는 크게 4가지로 분류됩니다. 
- 로그인/회원가입 페이지
- 구독 프로그램 페이지
- 운동 프로그램 찾기 페이지
- 마이페이지  

**로그인/회원가입 페이지**는 말 그대로 로그인와 회원가입을 하는 페이지입니다.  
**구독 프로그램 페이지**는 구독한 프로그램을 원하는 날짜에 등록하여 프로그램 루틴을 볼 수 있는 페이지입니다.  
**운동 프로그램 찾기 페이지** CTED에서 제공하는 여러 운동프로그램이 있는 페이지입니다.  
**마이페이지**는 자신의 정보나 운동 기록을 수정할 수 있는 페이지입니다.

## 1-1. 기능 소개
기능소개는 사용자가 CTED앱을 이용하는 프로세스에 따라 소개할 예정입니다. 대략적인 순서는 다음과 같습니다.
> 로그인/회원가입 페이지 → 운동 프로그램 찾기 페이지 → 구독 프로그램 페이지 → 마이페이지
         
### 로그인/회원가입 페이지
<center>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/0e01eab3-ebdc-41fe-9116-1ba232837dd2" align="center"/>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/bfeae1b4-06be-4fa6-9826-da8bf4188c05" align="center"/>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/6af51be2-3067-4689-ae5d-3689ed369011"align="center"/>
</center>  
<br/>

앱을 실행시키면 로그인 화면이 뜹니다. 계정이 없는 사용자의 경우 **Register**를 눌러 회원가입이 가능합니다.  
만약 비밀번호를 잊어버렸다면 **Forgotten password?** 를 눌러 본인이 가입한 이메일로 인증메일을 받을 수 있습니다.
<br/><br/><br/>

### 운동 프로그램 찾기 페이지
<center>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/cd92cc73-115e-4260-9abe-b68926926bc7" align="center"/> 
</center>
<br/>

로그인이 성공하면 사용자가 구독한 프로그램 있는 페이지로 이동합니다. 현재 구독한 프로그램이 없기 때문에 "you don't have any program" 라는 문구가 보여집니다.  

하단에 있는 돋보기 모양의 아이콘을 누르면 **운동 프로그램 찾기 페이지**로 이동하고 운동 프로그램들이 나타납니다. 또한 상단의 검색창을 통해 운동 프로그램을 검색할 수도 있습니다.
<br/><br/><br/>

<center>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/2009d8de-d14b-473f-9bdd-b1854136662e" align="center"/> 
</center>
<br/>

원하는 운동프로그램을 누르면 해당 프로그램의 상세정보 페이지로 이동하고 **저자, 운동일 수, 구독자명수, 난이도, 필요장비**에 대한 정보를 볼 수 있습니다. 최하단에는 구독버튼이 있으며 구독 후엔 버튼이 비활성화됨과 동시에 구독자가 1명 늘어납니다.
<br/><br/><br/>

### 구독 프로그램 페이지
<center>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/9b6a8fef-b23b-4dc7-ab05-85a5f0c8943a" align="center"/> 
</center>
<br/>

운동 상세정보 페이지에서 나간 뒤 하단의 덤벨 아이콘을 클릭하면 **구독 프로그램 페이지**로 이동합니다.  
방금 전 구독한 "Crossfit(kdw)가 구독되어있는 것을 볼 수 있습니다. 또한 빨간 쓰레기통을 눌러 구독한 운동프로그램을 구독취소 할 수도 있습니다.
<br/><br/><br/>

<center>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/afcddd3b-f4c5-42bf-9fc8-c9a2d8484b2b" align="center"/> 
</center>
<br/>

구독한 운동프로그램을 클릭하면 해당 프로그램의 하루짜리 루틴을 등록하는 달력이 나옵니다.  
날짜는 수평 캘린더를 통해 이동할 수 있고 오른쪽 상단에 있는 달력 아이콘을 통해 이동할 수도 있습니다. 
<br/><br/><br/>

<center>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/d4478f7d-aecd-45f3-a4ad-0b486e67e6b8" align="center"/> 
</center>
<br/>

원하는 날짜로 이동한 후 "+Add Day"버튼을 누르면 아래에서 등록하고자 하는 루틴을 선택하는 시트가 올라옵니다.  
원하는 루틴을 선택 후 "Add"를 누르면 해당 날짜에 선택한 루틴이 등록됨을 볼 수 있습니다.   
구독 프로그램을 구독 취소한 것과 마찬가지로 등록한 루틴은 삭제 할 수 있습니다.
<br/><br/><br/>

### 마이페이지
<center>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/662fad4b-f5b4-4720-aab2-9e97431d7226" align="center"/> 
</center>
<br/>

하단의 사람모양의 아이콘을 클릭하면 **마이페이지**로 이동합니다. **마이페이지**는 Account와 Records로 나눠져 있는데 Account에 들어가면 이름, 성별, 나라가 null로 세팅되어있습니다. 화살표를 클릭하여 수정가능합니다. 추가적으로 비밀번호 재설정도 가능합니다.
<br/><br/><br/>

<center>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/62850690-1b81-429c-ae9d-720d05ce88eb" align="center"/> 
</center>
<br/>

Records로 들어가면 6가지의 기록을 등록할 수 있습니다. Account와 마찬가지로 화살표를 통해 정보를 수정할 수 있고 빈칸이나 문자를 입력하면 경고창이 띄워집니다. 
<br/>

## 1-2. 사용 기술
### 프레임워크

<center>
<img width="25%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/8f417c37-478a-472b-bb24-d4e342488c67" align="center"/> 

<br/>

프레임워크는 구글의 Flutter를 사용하였습니다. 
<br/><br/>
</center>


### 상태관리 라이브러리
<center>
<img width="50%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/a38e07ef-3b34-4d6f-93b5-4fef1b5bc851" align="center"/> 
</center>
<br/>

상태관리 라이브러리로 GetX를 사용했습니다. 개발 초반엔 Provider를 사용하다가 context와 관련해서 어려움을 느껴 GetX로 변경하였습니다.
<br/><br/>

### 서버
<center>
<img width="50%" src="https://github.com/dw9706/CTED-Crossfit_Training_Every_Day/assets/77458624/cef361aa-a837-4f53-85de-76c1c568bcb1" align="center"/> 

<br/>

서버는 Firebase의 Firestore을 사용했습니다.




