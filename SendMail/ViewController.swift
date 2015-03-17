//
//  ViewController.swift
//  SendMail
//
//  Created by Kiattisak Anoochitarom on 3/17/2558 BE.
//  Copyright (c) 2558 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    @IBOutlet var contentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController {
    @IBAction func sendEmailTouched() {
        let mailComposer = configureMailComposer()
        if MFMailComposeViewController.canSendMail() {
            presentViewController(mailComposer, animated: true, completion: nil)
        } else {
            showError("Email Composer Error")
        }
    }
    
    @IBAction func sendMessageTouched() {
        let messageComposer = configureMessageComposer()
        if MFMessageComposeViewController.canSendText() {
            presentViewController(messageComposer, animated: true, completion: nil)
        } else {
            showError("Message Composer Error")
        }
    }
    
    private func configureMailComposer() -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["macbaszii@gmail.com"]) // Default Recipients (optional)
        mailComposer.setSubject("http://www.macbaszii.com") // Default Subject (optional)
        mailComposer.setMessageBody(contentField.text, isHTML: false) // Default Message (optional)
        
        return mailComposer
    }
    
    private func configureMessageComposer() -> MFMessageComposeViewController {
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self;
        messageComposer.body = contentField.text // Default Message (optional)
        messageComposer.recipients = ["11223344"] // Default Recipients (optional)
        
        return messageComposer
    }
    
    private func showError(title: String) {
        var alert = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

