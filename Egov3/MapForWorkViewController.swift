//
//  MapForWorkViewController.swift
//  Egov3
//
//  Created by Saltanat Aimakhanova on 6/24/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapForWorkViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var works:[Work]!
    let locationManager = CLLocationManager()

    @IBOutlet var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate=self
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.showWorks()

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
    func showWorks(){
        print(works.count)
        for index in 0...works.count-1{
            //print(homes[index].geoposition)
            guard let lat1=works[index].lat else{
                continue
            }
            guard let lon1=works[index].lng else{
                continue
            }
            if works[index].lat != "null" {
                if(works[index].lng != "null"){
            print(lat1)
            print(lon1)
            var lat:Double=Double(lat1)!
            var lon:Double=Double(lon1)!
            var location=CLLocationCoordinate2DMake(lat, lon)
            var span = MKCoordinateSpanMake(0.2, 0.2)
            var region=MKCoordinateRegionMake(location, span)
            map.setRegion(region, animated: true)
            var annotation=MKPointAnnotation()
            annotation.coordinate=location
            annotation.title=works[index].name
            map.addAnnotation(annotation)
                }
            }

            
            
        }
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
    

}
