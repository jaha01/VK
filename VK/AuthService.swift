//
//  AuthService.swift
//  VK
//
//  Created by Jahongir Anvarov on 18.01.2022.
//

import Foundation
import VK_ios_sdk


class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    
    private let appId = "8052012"
    private let vkSDK: VKSdk
    
   // weak var delegate: AuthServiceDelegate?
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
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }

}
