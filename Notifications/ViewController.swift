//
//  ViewController.swift
//  Notifications
//
//  Created by Valentinas Mirosnicenko on 1/11/17.
//  Copyright © 2017 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
        
        
    }
    
    
    @IBAction func notifyTapped(_ sender: Any) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Succesfully scheduled Notification")
            } else {
                print("Error scheduling notification")
            }
        })
    }

    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (Bool) -> ()) {
        let notif = UNMutableNotificationContent()
        
        
        // Attachment code
        let myImage = "rick_grimes"
        
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        // Notification contents
        
        
        notif.categoryIdentifier = "myNotificationCategory" // Only for extension
        
        notif.title = "New Notification"
        notif.subtitle = "These are amazing"
        notif.body = "fuck it"
        notif.attachments = [attachment]
        
        let notificiationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notificiationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil {
                print(error as Any)
                completion(false)
            } else {
                completion(true)
            }
        })
    }

}

