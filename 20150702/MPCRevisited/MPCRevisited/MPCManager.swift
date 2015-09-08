//
//  MPCManager.swift
//  MPCRevisited
//
//  Created by Stoner Wang on 15/9/8.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MPCManager: NSObject {

    var session: MCSession!
    var peer: MCPeerID!
    var browser: MCNearbyServiceBrowser!
    var advertiser: MCNearbyServiceAdvertiser!
    
    var foundPeers = [MCPeerID]()
    var invitationHandler: ((Bool, MCSession!) -> Void)!
    
}
