TestForRM
============
### 개요
 Mac 개발자 등록, Xcode-Firebase 연동, IOS FCMPush 구현과 모듈화 작업
***
### 목차
#### 1. Xcode에 프로젝트 생성
#### 2. IOS Apple 개발자 등록
* 인증서 요청 및 발급
* App ID 만들기
* 인증서 등록
* 디바이스 등록
* 프로비저닝 프로파일 등록
* Firebase 프로젝트 등록
* .p8 인증키 생성
#### 3. Firebase 프로젝트 생성 및 Xcode 연동
* Firebase 프로젝트 생성 및 IOS 앱 등록
* 클라우드 메세징을 위한 IOS 앱 구성 
* Xcode에 Signing & Capabilities 설정
#### 4. Ststic Library 설정 방법
* 프로그램단위의 기본 설정사항
* Swift의 라이브러리 사용코드
* Objective-C의 라이브러리 사용코드
#### 5. FCMPush를 위한 podfile과 Xcode에서의 소스 추가(*라이브러리가 아닌 프로젝트 사용*)
* Pod file 설정
* Xcode 소스 추가 및 설명 (Sample code : *TestForRm*.AppDelegate)
* Foreground에서의 Push 알림 수신을 위한 소스 추가 및 설명 (Sample code : *TestForRm*.AppDelegate)
***
### 1. Xcode에 프로젝트 생성
xCode 실행 >> [ Create a new Xcode project ] >> 'Single View App'이 선택된 채로 Next >> Project name 작성 후 프로젝트 생성 완료
***
### 2. 개발자 등록 및 Firebase 연동
#### 인증서 요청(CSR) 및 발급
Apple Developer사이트의 인증서 등록에서 사용할 인증서파일을 작성한다. Mac에서 실행할 필요가 있음.

키체인 접근 >> 인증서 지원 >> 인증기관에서 인증서 요청 >> 사용자 이메일 주소 입력, 이름 입력, 디스크에 저장됨 선택 후 계속 클릭 >> 저장


#### App ID 만들기
Apple Developer 사이트 접속 [ <https://developer.apple.com/kr/> ] >> [ Account ] 탭 클릭 후  로그인 >> [ Certificates, Identifiers & Profiles ] 탭 클릭 >> [ Identifiers ] 탭 클릭 후 '+' 버튼 클릭 >> 'App IDs' 항목이 선택된 채로 Continue 버튼 클릭 >> 프로젝트의 Bundle ID(xCode 실행 후 해당 프로젝트를 열고 좌측에 나열된 파일 항목(Navigator) 중에서 최상단에 위치한 프로젝트 이름을 클릭하면 Bundle identifier를 확인할 수 있음, Android Studio의 Package명과 같은 기능)와 Description을 입력, [ Capabilities ] 의 항목 중 'Push Notification'항목을 선택한 후 Continue 버튼 클릭 >> 확인 후 Register 버튼 클릭
#### 인증서 등록
Apple Developer 사이트 - Account - Certificates, Identifiers & Profiles에서 [ Certificates ] 탭 클릭 후 '+' 버튼 클릭 >> 'IOS App Development' 항목 선택 후 Continue 버튼 클릭 >> Choose File 키를 클릭하여 인증서 선택(키체인을 통해 발급해두었던 인증서를 등록), Continue 버튼 클릭 후 Download하여 원하는 위치에 저장 (.cer 파일) >> 키체인에서 좌측의 '로그인' 을 클릭하여 열어둔 상태로 둔 후, 조금 전에 Download 받았던 [ .cer ] 파일을 더블클릭하고 새로운 인증서가 키체인 목록에 추가되는 것을 확인    
#### 디바이스 등록
Apple Developer 사이트 - Account - Certificates, Identifiers & Profiles에서 [ Devices ] 탭 클릭 후 '+' 버튼 클릭 >> Device Name과 Device ID(UDID)를 작성한 후 Continue 버튼 클릭 >> 확인 후 Register 버튼 클릭
#### 프로비저닝 프로파일 등록
Apple Developer 사이트 - Account - Certificates, Identifiers & Profiles에서 [ Profiles ] 탭 클릭 후 '+' 버튼 클릭 >> 'IOS App Development' 항목 선택 후 Continue 버튼 클릭 >> 생성했던 App ID를 선택 후 Continue 버튼 클릭 >> 생성했던 인증서 선택 후 Continue 버튼 클릭 >> 등록한 디바이스 선택 후 Continue 버튼 클릭 >> 프로비저닝 프로파일의 이름을 설정한 후 Generate 버튼 클릭 >> Download 버튼 클릭하여 원하는 위치에 저장
#### .p8 인증키 생성
Apple Developer 사이트 - Account - Certificates, Identifiers & Profiles에서 [ Keys ] 탭 클릭 후 '+' 버튼 클릭 >> Key Name 입력 및 'Apple Push Notifications service (APNs)' 항목 선택 후 Continue 버튼 클릭 >> 키 정보 확인 후 Register 버튼 클릭, Download 버튼 클릭하여 원하는 위치에 저장 ( 주의. 키를 다운로드 하면 이후에 다운로드 할 수 없음, 또한 파일 탐색으로 키를 검색할 수 없으니 저장한 위치를 잘 기억해 둘 것 ) 
***
### 3. Firebase 프로젝트 생성 및 Xcode 연동
#### Firebase 프로젝트 생성 및 IOS 앱 등록
Firebase console 사이트 접속 [ <https://console.firebase.google.com> ] >> 프로젝트 추가 >> 프로젝트 이름 설정 및 에널리틱스 사용 설정, 애널리틱스 계정 설정 후에 프로젝트 만들기 완료 >> '앱에 Firebase를 추가하여 시작하기' 문구 아랫부분에 IOS 아이콘을 클릭 >> 프로젝트의 Bundle ID 입력 후 앱 등록 버튼 클릭 >> GoogleService-Info.plist를 다운로드 받고 안내된 위치에 추가 (파일명이 GoogleService-Info(1)과 같이 되지 않도록 주의할 것, 기존의 GoogleService-Info.plist파일을 모두 삭제하고 다시 다운로드 받거나 파일명을 수정하여 (1)을 삭제) , 다음 버튼 클릭 >> 터미널에서 프로젝트가 있는 위치로 이동한 후 안내에 따라 Podfile의 설치와 설정 진행(podInstall 명령 시에 Xcode를 닫아두고 실행할 것, 이후 프로젝트를 열 때에는 해당 프로젝트 폴더 안의 [ .xcodeproj ] 파일이 아닌 [ .xcworkspace ] 파일을 통해 열기) , 다음 버튼 클릭 >> 안내에 따라 프로젝트의 AppDelegate 클래스에 코드 추가, 다음 버튼 클릭 >> 이 단계 건너뛰기 클릭
#### 클라우드 메세징을 위한 IOS 앱 구성
Firebase console 사이트에서 생성했던 프로젝트로 이동 >> 좌측 상단의 탭 중 상단의 'Project Overview' 옆에 있는 톱니바퀴(Settings)를 클릭하여 프로젝트 설정으로 이동 >> '클라우드 메세징' 탭으로 이동 >> 'IOS 앱 구성' 부분에서 APN 인증 키 업로드 버튼 클릭 >> 다운로드 받았던 .p8 업로드한 후 키 ID와 팀 ID 입력 ( 키ID는 Apple Developer 사이트에서 Keys 탭의 키 목록을 확인하여 해당하는 키를 클릭하면 확인가능, 팀ID는 Apple Developer 사이트에서 Identifiers 탭의 App ID 목록을 확인하여 해당하는 App ID를 클릭하면 확인가능) >> 업로드 완료
#### Xcode에 Signing & Capabilities 설정
( Capabilities 설정 부분 ) 해당 Xcode 프로젝트 열기(.xcworkspace파일로 열기) >> 좌측 파일목록이 있는 탭(Navigator)에서 최상단의 프로젝트를 클릭 >> [ Signing & Capabilitis ] 탭 선택 >> [ Signing & Capabilities ] 탭이 있는 바로 아래의 하위 탭에서 [ All ] 좌측의 [ + Capability ] 클릭 >> [ Background Modes ] 와 [ Push Notifications ] 탭 더블클릭하여 추가 >> [ Background Modes ] 탭의 'Remote notifications' 항목 선택 >> ( Signing 설정 부분 - 'Team' 항목만 수정하면 프로젝트를 동작하는데에 문제 없음 확인) 상단의 [ Signing & Capabilities ] 탭과 같은 위치에 있는 [ Build Settings ] 에서 'Signing' - 'Code Signing Identity' 항목이 이전에 다운로드 받고 키체인에 등록했던 인증서인지 확인한 후 그렇지 않으면 설정 >> 다시 [ Signing & Capabilities ] 항목으로 가서 'Signing' - 'Provisioning Profile' 항목을 앞전에 생성해두었던 Provisioning Profile로 설정 >> 'Signing' - 'Team' 항목을 클릭하여 등록되어 있는 개발팀 선택
***
### 4. FCMPush를 위한 Podfile과 Xcode에서의 소스 추가
### 프로젝트 단위 
#### Podfile 설정
podfile 열기 >> Firebase cloud messaging 서비스를 위한 'Firebase/Messaging' 추가 ( 'Firebase/Core'는 웹 로그 분석용 Firebase SDK가 포함되어 있으나 이제 웹 로그 분석을 사용하기 위해서 웹 로그 종속성을 명시적으로 추가해야 하기 때문에 더 이상 사용하지 않는다. ) >> Podfile을 닫고 Podfile이 위치한 디렉토리에서 터미널을 열고 Pod install 명령을 진행
#### Xcode 소스 추가 및 설명 (Sample code : *TestForRm*.AppDelegate)
Firebase 및 Notification을 위한 import

>import Firebase

>import FirebaseMessaging 

>import FirebaseInstanceID 

>import UserNotifications

Appdelegate에서 수신 및 알림관련 처리를 위한 UNUserNotificationCenterDelegate, FCM에서 토큰 업데이트 또는 데이터 메시지 전달을 처리하는 MessagingDelegate 추가

>class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {}

UserNotification을 사용하는 것에 대하여 사용자에게 권한요청

>UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(isGranted, err) in DispatchQueue.main.async{}

application(_:application:didRegisterForRemoteNotificationsWithDeviceToken:) 메소드 생성 - 앱이 APN (Apple Push Notification) 서비스에 앱을 성공적으로 등록했음을 대리자에게 알림

>func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){}

application(_:application:didFailToRegisterForRemoteNotificationsWithError:) 메소드 생성 - 앱이 APN (Apple Push Notification) 서비스에 앱을 등록하는 도중 에러발생

>func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){}

application(_:didReceiveRemoteNotification:fetchCompletionHandler:) 메소드 생성 - 가져올 데이터가 있음을 나타내는 원격 알림이 도착했음을 앱에 알림

>func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {}

ConnectToFCM{} 메소드 생성 및 호출 - shouldEstablishDirectChannel을 true로 하여 직접 채널 사용을 위한 열결 설정, 앱이 포그라운드 상태일 때 APN을 우회하여 FCM에서 자동 데이터 전용 메시지를 직접 수신하여 안정성을 높이는 작업, 직접 채널을 사용 설정하면 FCM 백엔드는 안정적인 메시지 큐를 사용하여 앱이 백그라운드 또는 닫힌 상태일 때 보류 중인 메시지를 추적, 앱이 포그라운드 상태가 되고 연결이 다시 설정되면 채널에서는 클라이언트에서 확인을 받을 때까지 보류 중인 메시지를 클라이언트로 자동 전송, 이 메소드를 `applicationDedBecomeActive`에서 호출하여 연결, `applicationDidEnterBackground`에서 연결 해제

>func ConnectToFCM(){}

didReceiveRegistration 메소드 생성 및 ConnectToFCM 메소드 호출 - 기본적으로 FCM SDK는 앱을 시작할 때 클라이언트 앱 인스턴스용 등록 토큰을 생성, APN 기기 토큰과 마찬가지로 이 토큰을 사용하여 타겟팅한 알림을 앱의 모든 특정 인스턴스로 전송가능. iOS가 일반적으로 앱 시작 시 APN 기기 토큰을 전달하는 것과 마찬가지로, FCM은 `messaging:didReceiveRegistrationToken:` 메서드를 통해 등록 토큰을 제공

>func messaging(_ messaging: Messaging, didReceiveRegistrationtoken fcmToken: String){}

#### Foreground에서의 Push 알림 수신을 위한 소스 추가 및 설명 (Sample code : *TestForRm*.AppDelegate)

userNotificationCenter(_willPresent:withCompletionHandler:) 메소드 생성 - 앱이 포그라운드에서 실행되는 동안 도착한 알림을 처리하는 방법을 앱 대리자에게 요청, 알림이 도착했을 때 앱이 포 그라운드에있는 경우 shared user notification center는 이 메소드를 호출하여 알림을 앱에 직접 전달. completionHandler로 블록을 호출하고 시스템이 사용자에게로의 알림방법을 지정

>func userNotificationCenter(_ cnter: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {}
