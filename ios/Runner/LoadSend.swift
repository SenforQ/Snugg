
//: Declare String Begin

/*: "Net Error, Try again later" :*/
fileprivate let constSumCapturePath:String = "allow trigger deadline receive blackNet Er"
fileprivate let main_productionData:[Character] = ["T","r","y"," ","a","g","a","i","n"," ","l","a","t","e","r"]

/*: "data" :*/
fileprivate let configEnterFlag:String = "DATA"

/*: ":null" :*/
fileprivate let sessionPauseID:String = "scheme large total to scene:null"

/*: "json error" :*/
fileprivate let progressTagValue:[Character] = ["j","s","o","n"," ","e","r","r","o","r"]

/*: "platform=iphone&version= :*/
fileprivate let const_poorMsg:String = "platadjust"
fileprivate let helperPriceData:String = "iphocontexte"
fileprivate let k_firstTooDict:String = "n=go trigger from"

/*: &packageId= :*/
fileprivate let userHairTriggerValue:String = "&packactive head or"

/*: &bundleId= :*/
fileprivate let factoryBridgeActiveError:[Character] = ["&","b","u","n","d","l","e"]
fileprivate let userFiftyData:String = "boot notId="

/*: &lang= :*/
fileprivate let modelSkiAppearPath:[Character] = ["&","l","a","n","g","="]

/*: ; build: :*/
fileprivate let helperLabResult:[Character] = [";"]
fileprivate let modelImageTotalValue:String = "layer out index build:"

/*: ; iOS  :*/
fileprivate let cacheVerticalNumberStr:[Character] = [";"," ","i","O","S"," "]

//: Declare String End

//: import Alamofire
import Alamofire
//: import CoreMedia
import CoreMedia
//: import HandyJSON
import HandyJSON
// __DEBUG__
// __CLOSE_PRINT__
//: import UIKit
import UIKit

//: typealias FinishBlock = (_ succeed: Bool, _ result: Any?, _ errorModel: AppErrorResponse?) -> Void
typealias FinishBlock = (_ succeed: Bool, _ result: Any?, _ errorModel: FoulBe?) -> Void

//: @objc class AppRequestTool: NSObject {
@objc class LoadSend: NSObject {
    /// 发起Post请求
    /// - Parameters:
    ///   - model: 请求参数
    ///   - completion: 回调
    //: class func startPostRequest(model: AppRequestModel, completion: @escaping FinishBlock) {
    class func object(model: CameraMessageModel, completion: @escaping FinishBlock) {
        //: let serverUrl = self.buildServerUrl(model: model)
        let serverUrl = self.path(model: model)
        //: let headers = self.getRequestHeader(model: model)
        let headers = self.launch(model: model)
        //: AF.request(serverUrl, method: .post, parameters: model.params, headers: headers, requestModifier: { $0.timeoutInterval = 10.0 }).responseData { [self] responseData in
        AF.request(serverUrl, method: .post, parameters: model.params, headers: headers, requestModifier: { $0.timeoutInterval = 10.0 }).responseData { [self] responseData in
            //: switch responseData.result {
            switch responseData.result {
            //: case .success:
            case .success:
                //: func__requestSucess(model: model, response: responseData.response!, responseData: responseData.data!, completion: completion)
                notEmpty(model: model, response: responseData.response!, responseData: responseData.data!, completion: completion)

            //: case .failure:
            case .failure:
                //: completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "Net Error, Try again later"))
                completion(false, nil, FoulBe(errorCode: ExtraProgram.NetError.rawValue, errorMsg: (String(constSumCapturePath.suffix(6)) + "ror, " + String(main_productionData))))
            }
        }
    }

    //: class func func__requestSucess(model: AppRequestModel, response: HTTPURLResponse, responseData: Data, completion: @escaping FinishBlock) {
    class func notEmpty(model: CameraMessageModel, response: HTTPURLResponse, responseData: Data, completion: @escaping FinishBlock) {
        //: var responseJson = String(data: responseData, encoding: .utf8)
        var responseJson = String(data: responseData, encoding: .utf8)
        //: responseJson = responseJson?.replacingOccurrences(of: "\"data\":null", with: "\"data\":{}")
        responseJson = responseJson?.replacingOccurrences(of: "\"" + (configEnterFlag.lowercased()) + "\"" + (String(sessionPauseID.suffix(5))), with: "" + "\"" + (configEnterFlag.lowercased()) + "\"" + ":{}")
        //: if let responseModel = JSONDeserializer<AppBaseResponse>.deserializeFrom(json: responseJson) {
        if let responseModel = JSONDeserializer<EnableMergeReceive>.deserializeFrom(json: responseJson) {
            //: if responseModel.errno == RequestResultCode.Normal.rawValue {
            if responseModel.errno == ExtraProgram.Normal.rawValue {
                //: completion(true, responseModel.data, nil)
                completion(true, responseModel.data, nil)
                //: } else {
            } else {
                //: completion(false, responseModel.data, AppErrorResponse.init(errorCode: responseModel.errno, errorMsg: responseModel.msg ?? ""))
                completion(false, responseModel.data, FoulBe(errorCode: responseModel.errno, errorMsg: responseModel.msg ?? ""))
                //: switch responseModel.errno {
                switch responseModel.errno {
//                case ExtraProgram.NeedReLogin.rawValue:
//                    NotificationCenter.default.post(name: DID_LOGIN_OUT_SUCCESS_NOTIFICATION, object: nil, userInfo: nil)
                //: default:
                default:
                    //: break
                    break
                }
            }
            //: } else {
        } else {
            //: completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "json error"))
            completion(false, nil, FoulBe(errorCode: ExtraProgram.NetError.rawValue, errorMsg: (String(progressTagValue))))
        }
    }

    //: class func buildServerUrl(model: AppRequestModel) -> String {
    class func path(model: CameraMessageModel) -> String {
        //: var serverUrl: String = model.requestServer
        var serverUrl: String = model.requestServer
        //: let otherParams = "platform=iphone&version=\(AppNetVersion)&packageId=\(PackageID)&bundleId=\(AppBundle)&lang=\(UIDevice.interfaceLang)"
        let otherParams = (const_poorMsg.replacingOccurrences(of: "adjust", with: "f") + "orm=" + helperPriceData.replacingOccurrences(of: "context", with: "n") + "&versio" + String(k_firstTooDict.prefix(2))) + "\(configCornerMsg)" + (String(userHairTriggerValue.prefix(5)) + "ageId=") + "\(appContextName)" + (String(factoryBridgeActiveError) + String(userFiftyData.suffix(3))) + "\(modelMagnitudeervalDismissPath)" + (String(modelSkiAppearPath)) + "\(UIDevice.interfaceLang)"
        //: if !model.requestPath.isEmpty {
        if !model.requestPath.isEmpty {
            //: serverUrl.append("/\(model.requestPath)")
            serverUrl.append("/\(model.requestPath)")
        }
        //: serverUrl.append("?\(otherParams)")
        serverUrl.append("?\(otherParams)")

        //: return serverUrl
        return serverUrl
    }

    /// 获取请求头参数
    /// - Parameter model: 请求模型
    /// - Returns: 请求头参数
    //: class func getRequestHeader(model: AppRequestModel) -> HTTPHeaders {
    class func launch(model: CameraMessageModel) -> HTTPHeaders {
        //: let userAgent = "\(AppName)/\(AppVersion) (\(AppBundle); build:\(AppBuildNumber); iOS \(UIDevice.current.systemVersion); \(UIDevice.modelName))"
        let userAgent = "\(show_tooVersion)/\(cacheWaiterCameraMessage) (\(modelMagnitudeervalDismissPath)" + (String(helperLabResult) + String(modelImageTotalValue.suffix(7))) + "\(routerDeputiseMode)" + (String(cacheVerticalNumberStr)) + "\(UIDevice.current.systemVersion); \(UIDevice.modelName))"
        //: let headers = [HTTPHeader.userAgent(userAgent)]
        let headers = [HTTPHeader.userAgent(userAgent)]
        //: return HTTPHeaders(headers)
        return HTTPHeaders(headers)
    }
}
