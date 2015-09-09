//
//  ChatViewController.swift
//  MPCRevisited
//
//  Created by Stoner Wang on 15/9/8.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var txtChat: UITextField!
    @IBOutlet weak var tblChat: UITableView!
    
    var messagesArray: [Dictionary<String, String>] = []
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblChat.dataSource = self
        tblChat.delegate = self
        
        tblChat.estimatedRowHeight = 60.0
        tblChat.rowHeight = UITableViewAutomaticDimension
        
        txtChat.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMPCReceivedDataWithNotification", name: "receivedMPCDataNotification", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endChat(sender: AnyObject) {
        let messageDictionary: [String: String] = ["message": "_end_chat_"]
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID) {
            self.dismissViewControllerAnimated(true, completion: {
                self.appDelegate.mpcManager.session.disconnect()
            })
        }
        
    }
    
    func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        let data = receivedDataDictionary["data"] as? NSData
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        let dataDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! Dictionary<String, String>
        
        if let message = dataDictionary["message"] {
            if message != "_end_chat_" {
                let messageDictionary: [String: String] = ["sender": fromPeer.displayName, "message": message]
                messagesArray.append(messageDictionary)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.updateTableview()
                })
            } else {
                let alert = UIAlertController(title: "", message: "\(fromPeer.displayName) ended this chat.", preferredStyle: .Alert)
                let doneAction = UIAlertAction(title: "Okay", style: .Default, handler: {
                    alertAction in
                    self.appDelegate.mpcManager.session.disconnect()
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                
                alert.addAction(doneAction)
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCell", forIndexPath: indexPath) as UITableViewCell
        
        let currentMessage = messagesArray[indexPath.row] as Dictionary<String, String>
        
        if let sender = currentMessage["sender"] {
            var senderLabelText: String
            var senderColor: UIColor
            
            if sender == "self" {
                senderLabelText = "I said:"
                senderColor = UIColor.purpleColor()
            } else {
                senderLabelText = sender + " said:"
                senderColor = UIColor.orangeColor()
            }
            
            cell.detailTextLabel?.text = senderLabelText
            cell.detailTextLabel?.textColor = senderColor
        }
        
        if let message = currentMessage["message"] {
            cell.textLabel?.text = message
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let messageDictionary: [String: String] = ["message": textField.text!]
        
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID) {
            let dictionary: [String: String] = ["sender": "self", "message": textField.text!]
            messagesArray.append(dictionary)
            
            self.updateTableview()
        } else {
            print("Could not send data")
        }
        
        textField.text = ""
        
        return true
    }
    
    func updateTableview() {
        self.tblChat.reloadData()
        
        if self.tblChat.contentSize.height > self.tblChat.frame.size.height {
            tblChat.scrollToRowAtIndexPath(NSIndexPath(forRow: messagesArray.count - 1, inSection: 0), atScrollPosition: .Bottom, animated: true)
        }
    }

}
