//
//  AppDelegate.swift
//  TestForRm
//
//  Created by ken
//  Copyright © 2019 株式会社シナブル. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging
import FirebaseInstanceID

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 응용 프로그램 시작 후 사용자 지정을 위한 Override 지점
        
        /**************************** FCM Push Notification Settings *****************************/
        
            // UserNotification을 사용하는 것에 대하여 사용자에게 권한요청
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, err) in
                DispatchQueue.main.async {
                    if err != nil {
                        // Something bad happened
                    } else {
                        UNUserNotificationCenter.current().delegate = self
                        Messaging.messaging().delegate = self
                        application.registerForRemoteNotifications()
                    
                        FirebaseApp.configure()
                    }
                }
            }
            return true;
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
        
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // 응용 프로그램이 활성 상태에서 비활성 상태로 이동하려고 할 때 전송, 이는 특정 유형의 일시적인 중단(예:전화,SMS수신) 또는 사용자가 응용 프로그램을 종료하고 백그라운드 상태로 전환하기 시작할 때 발생
            
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        // 이 방법을 사용하여 진행중인 작업을 일시 중지하고 타이머를 비활성화하고 그래픽 렌더링 콜백을 무효화하십시오. 게임은 이 방법을 사용하여 일시 중지해야합니다.
    }
        
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // 이 방법을 사용하여 공유 리소스를 해제하고, 사용자 데이터를 저장하고, 타이머를 무효화하고, 애플리케이션이 나중에 종료될 경우 애플리케이션을 현재 상태로 복원 할 수 있는 충분한 애플리케이션 상태 정보를 저장하십시오.
            
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        // 애플리케이션이 백그라운드 실행을 지원하는 경우 사용자가 종료할 때 applicationWillTerminate: 대신 이 메소드가 호출됩니다.
            
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
        
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        // 백그라운드에서 활성 상태로의 전환중에 일부로 호출됩니다. 배경 입력에 대한 많은 변경 사항을 취소할 수 있습니다.
    }
        
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        // 응용 프로그램이 비활성화된 동안 일시 중지되었거나 아직 시작되지 않은 작업을 다시 시작하십시오. 애플리케이션이 이전에 백그라운드에 있었던 경우 선택적으로 사용자 인터페이스를 새로 고칩니다.
            
        ConnectToFCM()
    }
        
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // 응용프로그램이 종료 되려고 할 때 호출됩니다. 적절한 경우 데이터를 저장하십시오. applicationDidEnterBackgound:도 참조하십시오.
    }
    
    // Called when APNs has assigned the device a unique token
    // 디바이스 토큰값을 APN에 등록한 후 콘솔에 출력
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            
        Messaging.messaging().apnsToken = deviceToken
            
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
            
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
    }
        
    // Called when APNs failed to register the device for push notifications
    // 디바이스 토큰값 등록에 실패했을 경우 콘솔에 에러 메세지 출력
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Push notification received, Print notification payload data
        // 푸쉬알림 수신, notification 페이로드 데이터 출력
        print("Push notification received: \(data)")
    }
        
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        ConnectToFCM()
    }
        
    func ConnectToFCM() {
        Messaging.messaging().shouldEstablishDirectChannel = true;
    }
        
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}


