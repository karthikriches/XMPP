//
//  ViewController.swift
//  XMPP
//
//  Created by Karthik on 18/04/21.
//

import UIKit
import XMPPFramework



class ViewController: UIViewController {
    @IBOutlet weak var userIDField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    var xmppController : XMPPController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginTapped(_ sender: Any) {
        guard let userID = userIDField.text,
              let password = passwordField.text,
              !userID.isEmpty, !password.isEmpty else {
            return
        }
        
        try! xmppController = XMPPController(hostName: "stun.joiint.com",
                                            userJIDString: userID,
                                            password: password)
       // self.xmppController.connect()

        self.xmppController.connect   {
            auth in
            print("auth : ",auth)
            if auth {
                let vc =   UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WeatherViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
}

