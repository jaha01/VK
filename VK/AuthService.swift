//
//  AuthService.swift
//  VK
//
//  Created by Jahongir Anvarov on 18.01.2022.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidfail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    
    private let appId = "8052012"
    private let vkSDK: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }

    override init(){
        vkSDK = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func wakeUpSession(){
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { (status, error) in
            switch status {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
            default:
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        delegate?.authServiceSignIn()
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidfail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }

}
