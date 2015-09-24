//
//  CatsTableViewController.swift
//  Paws
//
//  Created by Stoner Wang on 15/9/24.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class CatsTableViewController: PFQueryTableViewController {

    let cellIdentifier: String = "Cell"
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
        self.parseClassName = className
        
        self.tableView.rowHeight = 350
        self.tableView.allowsSelection = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: "CatsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func queryForTable() -> PFQuery {
        let query: PFQuery = PFQuery(className: self.parseClassName!)
        
        if objects?.count == 0 {
            query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        
        query.orderByAscending("name")
        
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cellIdentifier: String = "Cell"
        
        var cell: CatsTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CatsTableViewCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CatsTableViewCell", owner: self, options: nil)[0] as? CatsTableViewCell
        }
        
        if let pfObject = object {
            cell?.catNameLabel.text = pfObject["name"] as? String
            
            if let votes = pfObject["votes"] as? Int {
                cell?.catVotesLabel.text = "\(votes) votes"
            }
            
            if let credit = pfObject["cc_by"] as? String {
                cell?.catCreditLabel.text = "\(credit) / CC 2.0"
            }
        }
        
        return cell
    }

}
