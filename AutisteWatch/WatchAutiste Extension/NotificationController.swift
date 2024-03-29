//
//  NotificationController.swift
//  WatchAutiste Extension
//
//  Created by iem on 02/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet var timeLabel: WKInterfaceTimer!
    @IBOutlet var descriptionLabel: WKInterfaceLabel!
    @IBOutlet var imageNotification: WKInterfaceImage!
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        descriptionLabel.setText(localNotification.alertTitle)
        imageNotification.setImageNamed(localNotification.alertLaunchImage)
        
        completionHandler(.Custom)
    }
    
    
    /*
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        completionHandler(.Custom)
    }
    */
}
