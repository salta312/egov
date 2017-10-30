//
//  JobViewController.swift
//  Egov3
//
//  Created by Saltanat Aimakhanova on 6/24/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit

class JobViewController: UIViewController {
    var work:Work!

    @IBOutlet var address: UILabel!
    @IBOutlet var salary: UILabel!
    @IBOutlet var requirement: UILabel!
    @IBOutlet var responsobility: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var employerName: UILabel!
    @IBOutlet var publishedAt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(work)
        if work.name != nil{
            name.text = work.name
        }
        if work.requirement != nil{
            requirement.text = work.requirement!
        }
        if work.responsibility != nil{
            responsobility.text = work.responsibility!
        }
        if work.employerName != nil{
            employerName.text = work.employerName!
        }
        if work.published_at != nil{
            publishedAt.text = work.published_at!
        }
        var address=""
        if work.city != nil{
            address+=work.city!
            address+=" "
        }
        if work.street != nil{
            address+=work.street!
            address+=" "

        }
        if work.building != nil{
            address += work.building!
            address+=" "

        }
        self.address.text = address
        var sal=""
        if work.from != nil{
            sal+=work.from!
            sal+=" - "
        }
        if work.to != nil{
            sal+=work.to!
            sal+=" "
        }
        if work.currency != nil{
            sal+=work.currency!
        }
        self.salary.text=sal

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
