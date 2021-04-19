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
    let host = "stun.joiint.com"
    var loader : UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loader = UIActivityIndicatorView(frame: CGRect(x: (view.frame.width-100)/2, y: (view.frame.height-100)/2, width: 100, height: 100))
        loader.style = .large
        loader.color = .purple
        loader.isHidden = true
        view.addSubview(loader)

    }

    @IBAction func loginTapped(_ sender: Any) {
        
        loader.isHidden = false
        loader.startAnimating()
        guard let userID = userIDField.text,
              let password = passwordField.text,
              !userID.isEmpty, !password.isEmpty
        else {
            return
        }
        
        do {
            try xmppController = XMPPController(hostName: host,
                                            userJIDString: userID,
                                            password: password)
        }
        catch {
            
        }

        self.xmppController.connect {
            auth in
            print("auth : ",auth)
            if auth {
                let vc =   UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(identifier: "WeatherViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            self.loader.stopAnimating()
            self.loader.isHidden =  true
        }

    }
    
   
}

