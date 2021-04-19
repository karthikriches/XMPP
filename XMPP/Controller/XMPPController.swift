//
//  XMPPController.swift
//  XMPP
//
//  Created by Karthik on 18/04/21.
//

import UIKit
import XMPPFramework


enum XMPPControllerError: Error {
    case wrongUserJID
}

class XMPPController: NSObject {
    var xmppStream: XMPPStream

    let hostName: String
    let userJID: XMPPJID
    let hostPort: UInt16
    let password: String
    
    var temp = false
    var load = {
        ()->() in
    }

    var authenticated :  ((Bool)->Void)?
    
    
    init(hostName: String, userJIDString: String, hostPort: UInt16 = 5222, password: String) throws {
        guard let userJID = XMPPJID(string: userJIDString) else {
            throw XMPPControllerError.wrongUserJID
        }

        self.hostName = hostName
        self.userJID = userJID
        self.hostPort = hostPort
        self.password = password

        // Stream Configuration
        self.xmppStream = XMPPStream()
        self.xmppStream.hostName = hostName
        self.xmppStream.hostPort = hostPort
        self.xmppStream.startTLSPolicy = XMPPStreamStartTLSPolicy.allowed
        self.xmppStream.myJID = userJID

        super.init()

        self.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    func connect(completion: @escaping (Bool)->()) {
        if !self.xmppStream.isDisconnected {
            return
        }

       try! self.xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
        self.authenticated = completion
    
        
        
        
    }

}

extension XMPPController: XMPPStreamDelegate {

    func xmppStreamDidConnect(_ stream: XMPPStream!) {
        print("Stream: Connected")
        try! stream.authenticate(withPassword: self.password)
    }

    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        self.xmppStream.send(XMPPPresence())
        print("Success : Stream authenticated")
        authenticated!(true)
    }
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        print("Failured : Stream not authenticated")
    }
}
