//
//  ViewController.swift
//  Swift_Weahter
//
//  Created by Taagoo'iMac on 14-7-11.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    let locationManager:CLLocationManager = CLLocationManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        if(ios8()){
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }

    func ios8() -> Bool{
       return UIDevice.currentDevice().systemVersion == "8.0"
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!){
        
        var location:CLLocation = locations[locations.count-1] as CLLocation
        
        
        if(location.horizontalAccuracy > 0){
            println(location.coordinate.latitude)
            println(location.coordinate.longitude)
            
            updateWeatherInfo(location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            locationManager.stopUpdatingLocation()
            
        }
        
        
    }
    func updateWeatherInfo(latitude:CLLocationDegrees, longitude:CLLocationDegrees){
        let manager = AFHTTPRequestOperationManager()
        let url = "http://api.openweatermap.org/data2.5/weather"
        
        let params = ["lat":latitude,"lon":longitude, "cnt":0]
        
        manager.GET(url,
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                println("JSON: " + responseObject.description!)
                
           
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
           
            })
        
        
       
        
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

