//
//  ViewController.swift
//  MPCRevisited
//
//  Created by Stoner Wang on 15/9/8.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MPCManagerDelegate {

    @IBOutlet weak var tblPeers: UITableView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var isAdvertising: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblPeers.dataSource = self
        tblPeers.delegate = self
        
        appDelegate.mpcManager.delegate = self
        appDelegate.mpcManager.browser.startBrowsingForPeers()
        isAdvertising = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        appDelegate.mpcManager.browser.stopBrowsingForPeers()
    }

    @IBAction func startStopAdvertising(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "", message: "Change Visibility", preferredStyle: .ActionSheet)
        
        var actionTitle: String
        if isAdvertising == true {
            actionTitle = "Make me invisible to others"
        } else {
            actionTitle = "Make me visible to others"
        }
        
        let visibilityAction = UIAlertAction(title: actionTitle, style: .Default, handler: {
            alertAction in
            if self.isAdvertising == true {
                self.appDelegate.mpcManager.advertiser.stopAdvertisingPeer()
            } else {
                self.appDelegate.mpcManager.advertiser.startAdvertisingPeer()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            alertAction in
        })
        
        actionSheet.addAction(visibilityAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tblPeers.dequeueReusableCellWithIdentifier("idCellPeer", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = appDelegate.mpcManager.foundPeers[indexPath.row].displayName
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.mpcManager.foundPeers.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedPeer = appDelegate.mpcManager.foundPeers[indexPath.row] as MCPeerID
        appDelegate.mpcManager.browser.invitePeer(selectedPeer, toSession: appDelegate.mpcManager.session, withContext: nil, timeout: 20)
    }
    
    func foundPeer() {
        tblPeers.reloadData()
    }
    
    func lostPeer() {
        tblPeers.reloadData()
    }
    
    func invitationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to chat with you.", preferredStyle: .Alert)
        
        let acceptAction = UIAlertAction(title: "Accept", style: .Default, handler: {
            alertAction in
            self.appDelegate.mpcManager.invitationHandler(true, self.appDelegate.mpcManager.session)
        })
        
        let declineAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            alertAction in
            self.appDelegate.mpcManager.invitationHandler(false, self.appDelegate.mpcManager.session)
        })
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        NSOperationQueue.mainQueue().addOperationWithBlock({
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    func connectedWithPeer(peerID: MCPeerID) {
        NSOperationQueue.mainQueue().addOperationWithBlock({
            self.performSegueWithIdentifier("idSegueChat", sender: self)
        })
    }

}

