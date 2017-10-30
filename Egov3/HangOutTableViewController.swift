//
//  HangOutTableViewController.swift
//  Egov3
//
//  Created by Saltanat Aimakhanova on 6/24/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HangOutTableViewController: UITableViewController {
    var events=[HangOut]()

    override func viewDidLoad() {
        super.viewDidLoad()
        findAll()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return events.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    func findAll(){
    //    mapButton.userInteractionEnabled=false
        Alamofire.request(.GET, "https://data.egov.kz/api/v2/mugedekter_ushin_otkiziletin_i/v1?pretty").validate().responseJSON{
            response in
            switch response.result{
            case .Success:
                print("Validation is sucessful")
                if let value=response.result.value{
                    let json=JSON(value)
                    print(json)
                    for index in 0...json.count - 1 {
                        var val=json[index]
                        print(val)
                        //  print(val["id"])
                        var hangout=HangOut()
                        hangout.name=String(val["name"])
                        self.events.append(hangout)
                        // print("\(home.id) \(home.headname)")
                        
                    }
                    self.tableView.reloadData()
                    
                    //self.performSegueWithIdentifier("SegueWordnikVC", sender: nil)
                }
            case .Failure(let error):
                print(error)
            }
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath)
        cell.textLabel?.text=events[indexPath.section].name

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
