//
//  ViewController.swift
//  VK
//
//  Created by Jahongir Anvarov on 18.01.2022.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //authService = AuthService()
        authService = SceneDelegate.shared().authService
        view.backgroundColor = .red
    }

    @IBAction func signInTouch(_ sender: Any) {
        authService.wakeUpSession()
    }
    
}

