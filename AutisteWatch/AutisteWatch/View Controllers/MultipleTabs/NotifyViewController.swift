//
//  NotifyViewController.swift
//  AutisteWatch
//
//  Created by iem on 07/06/2016.
//
//

import UIKit

class NotifyViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imgVw_pictoNotify: UIImageView!
    @IBOutlet weak var txtFld_notification: UITextField!
    
    var validateButton: UIBarButtonItem!

    var patientToNotify : Patient?
    var groupToNotify : Group?
    var isPatient : Bool = false
    var isGroup : Bool = false
    let app=UIApplication.sharedApplication()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFld_notification.delegate = self
        
        validateButton = UIBarButtonItem(title: "Envoyer", style: .Done, target: self, action:#selector(NotifyViewController.validateNotification(_:)))
    
        if isPatient {
            let name : String = patientToNotify!.namePatient!
            self.navigationItem.title = "Notifier \(name)"
        }
        if isGroup {
            let nameGroup : String = groupToNotify!.nameGroup!
            self.navigationItem.title = "Notifier \(nameGroup)"
        }
        
        self.navigationItem.setRightBarButtonItem(validateButton, animated: true)
        validateButton.enabled = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(NotifyViewController.imageTapped(_:)))
        imgVw_pictoNotify.userInteractionEnabled = true
        imgVw_pictoNotify.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool {
        
        let beforeText: NSString = textField.text!
        let afterText: NSString = beforeText.stringByReplacingCharactersInRange(range, withString: string)
        
        if afterText.length > 0 {
            validateButton.enabled = true
        } else {
            validateButton.enabled = false
        }
        
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    
    func imageTapped(img: AnyObject)
    {
        print("toto")
    }
    
    func validateNotification(notification: AnyObject){
        let alertTime = NSDate().dateByAddingTimeInterval(5)
        let notifyAlarm=UILocalNotification()
        notifyAlarm.fireDate=alertTime
        notifyAlarm.timeZone=NSTimeZone()
        notifyAlarm.soundName=UILocalNotificationDefaultSoundName
        notifyAlarm.category="AllNotif"
        notifyAlarm.alertTitle=txtFld_notification.text
        notifyAlarm.alertBody="test"
        //notifyAlarm.alertLaunchImage=imgVw_pictoNotify.image?.accessibilityIdentifier
        app.scheduleLocalNotification(notifyAlarm)
        
    }

}
