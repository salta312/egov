//
//  MapForCentersViewController.swift
//  Egov3
//
//  Created by Saltanat Aimakhanova on 6/24/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapForCentersViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var homes:[Home]!
    let locationManager = CLLocationManager()
    @IBOutlet var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate=self
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.showHomes()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.map.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: \(error.localizedDescription)")
    }
    func showHomes(){
        print(homes.count)
        for index in 0...homes.count-1{
            //print(homes[index].geoposition)
            if homes[index].geoposition != "null"{
                var pos = homes[index].geoposition!
                print(pos)
                var poss=pos.componentsSeparatedByString(",")
                print(poss)
                var lat:Double=Double(poss[0])!
                var lon:Double=Double(poss[1])!
                var location=CLLocationCoordinate2DMake(lat, lon)
                var span = MKCoordinateSpanMake(0.2, 0.2)
                var region=MKCoordinateRegionMake(location, span)
                map.setRegion(region, animated: true)
                var annotation=MKPointAnnotation()
                annotation.coordinate=location
                annotation.title=homes[index].name
                map.addAnnotation(annotation)

            }
            
        }
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
