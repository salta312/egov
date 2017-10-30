//
//  HelpTableViewController.swift
//  Egov3
//
//  Created by Saltanat Aimakhanova on 6/23/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HelpTableViewController: UITableViewController {
    var homes=[Home]()

    @IBOutlet var mapButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("I am here")
        findAll()
        mapButton.userInteractionEnabled=false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func findAll(){
        mapButton.userInteractionEnabled=false
        Alamofire.request(.GET, "https://data.egov.kz/api/v2/almobldomainvalidov/v1?pretty").validate().responseJSON{
            response in
            switch response.result{
            case .Success:
                print("Validation is sucessful")
                if let value=response.result.value{
                    let json=JSON(value)
                    print(json)
                    for index in 0...json.count - 1 {
                       var val=json[index]
                      //  print(val["id"])
                        var home=Home()
                        home.id=String(val["id"])
                        home.email=String(val["email"])
                        home.contactnumber=String(val["contactnumber"])
                        home.headname=String(val["headname"])
                        home.address=String(val["address"])
                        home.schedule=String(val["schedule"])
                        home.geoposition=String(val["geoposition"])
                        home.services = String(val["services"])
                        home.name = String(val["name"])
                        self.homes.append(home)
                       // print("\(home.id) \(home.headname)")
                        
                    }
                    self.mapButton.userInteractionEnabled=true
                    self.tableView.reloadData()

                    //self.performSegueWithIdentifier("SegueWordnikVC", sender: nil)
                }
            case .Failure(let error):
                print(error)
            }
        }

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return homes.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("I am here1")
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath) as! HomeTableViewCell
        //if(homes[indexPath.section].id != nil){
            cell.address.text=homes[indexPath.section].address!
            cell.email.text=homes[indexPath.section].email!
            cell.headname.text=homes[indexPath.section].headname
            cell.contactnumber.text=homes[indexPath.section].contactnumber
            cell.schedule.text=homes[indexPath.section].schedule
            cell.name.text=homes[indexPath.section].name
            cell.services.text=homes[indexPath.section].services
            
        //}

        // Configure the cell...
        
        print("CELL: \(cell.name.text) for index row: \(indexPath.row) section: \(indexPath.section)")

        return cell
    }
    
    
    @IBAction func mapButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("centersSegue", sender: nil)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "centersSegue"{
            var mapVC=segue.destinationViewController as! MapForCentersViewController
            mapVC.homes=self.homes
        }
    }
    

}
