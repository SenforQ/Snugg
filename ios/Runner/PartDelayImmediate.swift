
//: Declare String Begin

/*: "socoay" :*/
fileprivate let showInstanceMinimumMsg:[Character] = ["s","o","c","o","a","y"]

/*: "979" :*/
fileprivate let sessionDisplayStateDate:[Character] = ["9","7","9"]

/*: "2zbs7kk1b6kg" :*/
fileprivate let kArrayDate:[Character] = ["2","z","b","s","7","k","k","1","b","6","k","g"]

/*: "2oa8yo" :*/
fileprivate let mainSpermFilledState:String = "2"
fileprivate let dataReceiveDiskReURL:[Character] = ["o","a","8","y","o"]

/*: "1.9.1" :*/
fileprivate let modelNeverDict:[Character] = ["1",".","9",".","1"]

/*: "https://m. :*/
fileprivate let networkReplaceSceneTime:String = "https:enter head model kind"
fileprivate let networkIncentiveBodyError:String = "local secret trigger poor//m."

/*: .com" :*/
fileprivate let serviceCornerPriceDict:String = "language camera.com"

/*: "CFBundleShortVersionString" :*/
fileprivate let managerSomeonePanelCount:String = "CFBunsum layer"
fileprivate let mainPliableId:String = "black clear sumortV"
fileprivate let kOriginExecuteMode:String = "nStringlarge time platform mask tool"

/*: "CFBundleDisplayName" :*/
fileprivate let k_careMessage:[Character] = ["C","F","B","u","n","d"]
fileprivate let engineContendDiskTitle:[Character] = ["l","e","D","i","s","p","l","a","y","N","a","m","e"]

/*: "CFBundleVersion" :*/
fileprivate let const_emptyValue:String = "CFBunappear i category"
fileprivate let routerScriptPath:[Character] = ["d","l"]
fileprivate let modelEventMessage:String = "eVersionerror response"

/*: "weixin" :*/
fileprivate let app_replaceName:[Character] = ["w","e","i","x","i","n"]

/*: "wxwork" :*/
fileprivate let sessionGrantStr:String = "forwardwork"

/*: "dingtalk" :*/
fileprivate let routerPostString:String = "dmapn"
fileprivate let k_serviceTrustValue:[Character] = ["g","t","a","l","k"]

/*: "lark" :*/
fileprivate let factoryRatingFormat:[Character] = ["l","a","r","k"]

//: Declare String End

// __DEBUG__
// __CLOSE_PRINT__
//
//  PartDelayImmediate.swift
//  OverseaH5
//
//  Created by young on 2025/9/24.
//

//: import KeychainSwift
import KeychainSwift
//: import UIKit
import UIKit

/// 域名
//: let ReplaceUrlDomain = "socoay"
let cacheOnceMsg = (String(showInstanceMinimumMsg))
/// 包ID
//: let PackageID = "979"
let appContextName = (String(sessionDisplayStateDate))
/// Adjust
//: let AdjustKey = "2zbs7kk1b6kg"
let kConnexionName = (String(kArrayDate))
//: let AdInstallToken = "2oa8yo"
let managerEnableceMsg = (mainSpermFilledState.capitalized + String(dataReceiveDiskReURL))

/// 网络版本号
//: let AppNetVersion = "1.9.1"
let configCornerMsg = (String(modelNeverDict))
//: let H5WebDomain = "https://m.\(ReplaceUrlDomain).com"
let parserCountValue = (String(networkReplaceSceneTime.prefix(6)) + String(networkIncentiveBodyError.suffix(4))) + "\(cacheOnceMsg)" + (String(serviceCornerPriceDict.suffix(4)))
//: let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let cacheWaiterCameraMessage = Bundle.main.infoDictionary![(String(managerSomeonePanelCount.prefix(5)) + "dleSh" + String(mainPliableId.suffix(4)) + "ersio" + String(kOriginExecuteMode.prefix(7)))] as! String
//: let AppBundle = Bundle.main.bundleIdentifier!
let modelMagnitudeervalDismissPath = Bundle.main.bundleIdentifier!
//: let AppName = Bundle.main.infoDictionary!["CFBundleDisplayName"] ?? ""
let show_tooVersion = Bundle.main.infoDictionary![(String(k_careMessage) + String(engineContendDiskTitle))] ?? ""
//: let AppBuildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
let routerDeputiseMode = Bundle.main.infoDictionary![(String(const_emptyValue.prefix(5)) + String(routerScriptPath) + String(modelEventMessage.prefix(8)))] as! String

//: class AppConfig: NSObject {
class PartDelayImmediate: NSObject {
    /// 获取状态栏高度
    //: class func getStatusBarHeight() -> CGFloat {
    class func filterOut() -> CGFloat {
        //: if #available(iOS 13.0, *) {
        if #available(iOS 13.0, *) {
            //: if let statusBarManager = UIApplication.shared.windows.first?
            if let statusBarManager = UIApplication.shared.windows.first?
                //: .windowScene?.statusBarManager
                .windowScene?.statusBarManager
            {
                //: return statusBarManager.statusBarFrame.size.height
                return statusBarManager.statusBarFrame.size.height
            }
            //: } else {
        } else {
            //: return UIApplication.shared.statusBarFrame.size.height
            return UIApplication.shared.statusBarFrame.size.height
        }
        //: return 20.0
        return 20.0
    }

    /// 获取window
    //: class func getWindow() -> UIWindow {
    class func receipts() -> UIWindow {
        //: var window = UIApplication.shared.windows.first(where: {
        var window = UIApplication.shared.windows.first(where: {
            //: $0.isKeyWindow
            $0.isKeyWindow
            //: })
        })
        // 是否为当前显示的window
        //: if window?.windowLevel != UIWindow.Level.normal {
        if window?.windowLevel != UIWindow.Level.normal {
            //: let windows = UIApplication.shared.windows
            let windows = UIApplication.shared.windows
            //: for windowTemp in windows {
            for windowTemp in windows {
                //: if windowTemp.windowLevel == UIWindow.Level.normal {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    //: window = windowTemp
                    window = windowTemp
                    //: break
                    break
                }
            }
        }
        //: return window!
        return window!
    }

    /// 获取当前控制器
    //: class func currentViewController() -> (UIViewController?) {
    class func message() -> (UIViewController?) {
        //: var window = AppConfig.getWindow()
        var window = PartDelayImmediate.receipts()
        //: if window.windowLevel != UIWindow.Level.normal {
        if window.windowLevel != UIWindow.Level.normal {
            //: let windows = UIApplication.shared.windows
            let windows = UIApplication.shared.windows
            //: for windowTemp in windows {
            for windowTemp in windows {
                //: if windowTemp.windowLevel == UIWindow.Level.normal {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    //: window = windowTemp
                    window = windowTemp
                    //: break
                    break
                }
            }
        }
        //: let vc = window.rootViewController
        let vc = window.rootViewController
        //: return currentViewController(vc)
        return third(vc)
    }

    //: class func currentViewController(_ vc: UIViewController?)
    class func third(_ vc: UIViewController?)
        //: -> UIViewController?
        -> UIViewController?
    {
        //: if vc == nil {
        if vc == nil {
            //: return nil
            return nil
        }
        //: if let presentVC = vc?.presentedViewController {
        if let presentVC = vc?.presentedViewController {
            //: return currentViewController(presentVC)
            return third(presentVC)
            //: } else if let tabVC = vc as? UITabBarController {
        } else if let tabVC = vc as? UITabBarController {
            //: if let selectVC = tabVC.selectedViewController {
            if let selectVC = tabVC.selectedViewController {
                //: return currentViewController(selectVC)
                return third(selectVC)
            }
            //: return nil
            return nil
            //: } else if let naiVC = vc as? UINavigationController {
        } else if let naiVC = vc as? UINavigationController {
            //: return currentViewController(naiVC.visibleViewController)
            return third(naiVC.visibleViewController)
            //: } else {
        } else {
            //: return vc
            return vc
        }
    }
}

// MARK: - Device

//: extension UIDevice {
extension UIDevice {
    //: static var modelName: String {
    static var modelName: String {
        //: var systemInfo = utsname()
        var systemInfo = utsname()
        //: uname(&systemInfo)
        uname(&systemInfo)
        //: let machineMirror = Mirror(reflecting: systemInfo.machine)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        //: let identifier = machineMirror.children.reduce("") {
        let identifier = machineMirror.children.reduce("") {
            //: identifier, element in
            identifier, element in
            //: guard let value = element.value as? Int8, value != 0 else {
            guard let value = element.value as? Int8, value != 0 else {
                //: return identifier
                return identifier
            }
            //: return identifier + String(UnicodeScalar(UInt8(value)))
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        //: return identifier
        return identifier
    }

    /// 获取当前系统时区
    //: static var timeZone: String {
    static var timeZone: String {
        //: let currentTimeZone = NSTimeZone.system
        let currentTimeZone = NSTimeZone.system
        //: return currentTimeZone.identifier
        return currentTimeZone.identifier
    }

    /// 获取当前系统语言
    //: static var langCode: String {
    static var langCode: String {
        //: let language = Locale.preferredLanguages.first
        let language = Locale.preferredLanguages.first
        //: return language ?? ""
        return language ?? ""
    }

    /// 获取接口语言
    //: static var interfaceLang: String {
    static var interfaceLang: String {
        //: let lang = UIDevice.getSystemLangCode()
        let lang = UIDevice.appear()
        //: if ["en", "ar", "es", "pt"].contains(lang) {
        if ["en", "ar", "es", "pt"].contains(lang) {
            //: return lang
            return lang
        }
        //: return "en"
        return "en"
    }

    /// 获取当前系统地区
    //: static var countryCode: String {
    static var countryCode: String {
        //: let locale = Locale.current
        let locale = Locale.current
        //: let countryCode = locale.regionCode
        let countryCode = locale.regionCode
        //: return countryCode ?? ""
        return countryCode ?? ""
    }

    /// 获取系统UUID（每次调用都会产生新值，所以需要keychain）
    //: static var systemUUID: String {
    static var systemUUID: String {
        //: let key = KeychainSwift()
        let key = KeychainSwift()
        //: if let value = key.get(AdjustKey) {
        if let value = key.get(kConnexionName) {
            //: return value
            return value
            //: } else {
        } else {
            //: let value = NSUUID().uuidString
            let value = NSUUID().uuidString
            //: key.set(value, forKey: AdjustKey)
            key.set(value, forKey: kConnexionName)
            //: return value
            return value
        }
    }

    /// 获取已安装应用信息
    //: static var getInstalledApps: String {
    static var getInstalledApps: String {
        //: var appsArr: [String] = []
        var appsArr: [String] = []
        //: if UIDevice.canOpenApp("weixin") {
        if UIDevice.capture((String(app_replaceName))) {
            //: appsArr.append("weixin")
            appsArr.append((String(app_replaceName)))
        }
        //: if UIDevice.canOpenApp("wxwork") {
        if UIDevice.capture((sessionGrantStr.replacingOccurrences(of: "forward", with: "wx"))) {
            //: appsArr.append("wxwork")
            appsArr.append((sessionGrantStr.replacingOccurrences(of: "forward", with: "wx")))
        }
        //: if UIDevice.canOpenApp("dingtalk") {
        if UIDevice.capture((routerPostString.replacingOccurrences(of: "map", with: "i") + String(k_serviceTrustValue))) {
            //: appsArr.append("dingtalk")
            appsArr.append((routerPostString.replacingOccurrences(of: "map", with: "i") + String(k_serviceTrustValue)))
        }
        //: if UIDevice.canOpenApp("lark") {
        if UIDevice.capture((String(factoryRatingFormat))) {
            //: appsArr.append("lark")
            appsArr.append((String(factoryRatingFormat)))
        }
        //: if appsArr.count > 0 {
        if appsArr.count > 0 {
            //: return appsArr.joined(separator: ",")
            return appsArr.joined(separator: ",")
        }
        //: return ""
        return ""
    }

    /// 判断是否安装app
    //: static func canOpenApp(_ scheme: String) -> Bool {
    static func capture(_ scheme: String) -> Bool {
        //: let url = URL(string: "\(scheme)://")!
        let url = URL(string: "\(scheme)://")!
        //: if UIApplication.shared.canOpenURL(url) {
        if UIApplication.shared.canOpenURL(url) {
            //: return true
            return true
        }
        //: return false
        return false
    }

    /// 获取系统语言
    /// - Returns: 国际通用语言Code
    //: @objc public class func getSystemLangCode() -> String {
    @objc public class func appear() -> String {
        //: let language = NSLocale.preferredLanguages.first
        let language = NSLocale.preferredLanguages.first
        //: let array = language?.components(separatedBy: "-")
        let array = language?.components(separatedBy: "-")
        //: return array?.first ?? "en"
        return array?.first ?? "en"
    }
}
