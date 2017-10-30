//
//  WorkTableViewController.swift
//  Egov3
//
//  Created by Saltanat Aimakhanova on 6/24/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WorkTableViewController: UITableViewController{
    
    @IBOutlet var mapButton: UIButton!
    //@IBOutlet var mapButton: UIBarButtonItem!
    //@IBOutlet var mapButton: UIBarButtonItem!
    var works=[Work]()
 


    @IBOutlet var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate=self
        mapButton.userInteractionEnabled=false
        
        //self.tableView.delegate=self

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
        return works.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    func searchJobs(job:String!){
        self.works=[]
        Alamofire.request(.GET, "https://api.hh.ru/vacancies?label=accept_handicapped&area=40&text=\(job)").validate().responseJSON{
            response in
            switch response.result{
            case .Success:
                print("Validation is sucessful")
                if let value=response.result.value{
                    let json=JSON(value)
                   // print(json)
              //      for index in 0...json.count{
                       var items=json["items"]
                    //print(items.count)
                      for ind in 0...items.count-1{
                        var work=Work()
                            var item=items[ind]
                            if item["address"] != nil{
                                //print(item["address"])
                                if item["address"]["city"] != nil{
                                    work.city=String(item["address"]["city"])
                                }
                                if item["address"]["building"] != nil{
                                    work.building=String(item["address"]["building"])
                                }
                                if item ["address"]["street"] != nil{
                                    work.street=String(item["address"]["street"])
                                }
                                if item["address"]["lng"] != nil{
                                    work.lng=String(item["address"]["lng"])
                                }
                                if item["address"]["lat"] != nil{
                                    work.lat=String(item["address"]["lat"])
                                }
                                //print(item["address"]["city"])
                        }
                        if item["snippet"] != nil{
                            if item["snippet"]["responsibility"] != nil{
                                work.responsibility = String(item["snippet"]["responsibility"])
                            }
                            if item["snippet"]["requirement"] != nil{
                            work.requirement = String(item["snippet"]["requirement"])
                            }
                        }
                        if item["salary"] != nil{
                            if item["salary"]["to"] != nil{
                            work.to=String(item["salary"]["to"])
                            }
                            if item["salary"]["from"] != nil{
                            work.from=String(item["salary"]["from"])
                            }
                            if item["salary"]["currency"] != nil{
                            work.currency=String(item["salary"]["currency"])
                            }
                        }
                        if item["published_at"] != nil{
                            work.published_at=String(item["published_at"])
                        }
                        if(item["name"] != nil){
                            work.name=String(item["name"])
                        }
                        if(item["id"] != nil){
                            work.id=String(item["id"])
                        }
                        if(item["employer"] != nil){
                            work.employerName=String(item["employer"]["name"])
                        }
                        
                        self.works.append(work)
                    }
                    self.tableView.reloadData()
                    self.mapButton.userInteractionEnabled=true
                    
                        
                        
                //    }
                    
                }
            case .Failure(let error):
                print(error)
            }
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var from="unknown"
        var to="unknown"
        var currency="unknown"
        
        let cell = tableView.dequeueReusableCellWithIdentifier("workCell", forIndexPath: indexPath) as! WorkTableViewCell
//change the unrapping
       // if(works[indexPath.section] != nil){
        if(works[indexPath.section].name != nil){
            cell.name.text = works[indexPath.section].name!
        }
        if works[indexPath.section].from != nil{
             from = works[indexPath.section].from!
        }
        if works[indexPath.section].to != nil{
            to = works[indexPath.section].to!
        }
        if works[indexPath.section].currency != nil{
            currency = works[indexPath.section].currency!
        }
        cell.salary.text="\(from )- \(to) in \(currency)"
        cell.companyName.text=works[indexPath.section].employerName
       // }

        // Configure the cell...

        return cell
    }
    
    
    @IBAction func showMapButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("workSegue", sender: nil)
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
        if segue.identifier == "workSegue"{
            var mapVC=segue.destinationViewController as! MapForWorkViewController
            mapVC.works=self.works
        }else if segue.identifier == "showJobInfoSegue"{
           // print("I am here")
            var jobVC=segue.destinationViewController as! JobViewController
            jobVC.work=self.works[sender as! Int]
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.prepareForSegue("SegueAppartamentVC", sender: indexPath)
        self.performSegueWithIdentifier("showJobInfoSegue", sender: indexPath.section)
    }
    

}
extension WorkTableViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let jobTitle=searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        self.searchJobs(jobTitle)
        searchBar.resignFirstResponder()

    }
}



