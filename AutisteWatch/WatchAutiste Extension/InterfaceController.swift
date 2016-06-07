//
//  InterfaceController.swift
//  WatchAutiste Extension
//
//  Created by iem on 02/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBOutlet var idNumber: WKInterfaceLabel!
    var id:NSInteger=0
    var session: WCSession?{
        didSet{
            if let session=session{
                session.delegate=self
                session.activateSession()
            }
        }
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if id==0 && WCSession.isSupported(){
            session=WCSession.defaultSession()
            session!.sendMessage(["identifiant":id], replyHandler: {(response)->Void in
                if let numberIdentifiant = response["responseIdentifiant"] as? NSInteger{
                    self.id=numberIdentifiant
                    self.idNumber.setText("\(self.id)")
                }
                }, errorHandler: {(error)->Void in
                    print(error)
            })
        }
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension InterfaceController: WCSessionDelegate{
    
}
