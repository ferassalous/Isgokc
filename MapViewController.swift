//
//  MapViewController.swift
//  Isgokc
//
//  Created by Feras Salous  on 5/31/19.
//  Copyright © 2019 Feras Salous . All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController,MKMapViewDelegate {
    //Map scene
    @IBOutlet var mapView:MKMapView!
    var matchingItems: [MKMapItem] = [MKMapItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //displays current location
        mapView.showsUserLocation = true
        //mapView.delegate = self
       performSearch()
        
    }
    
    @IBAction func zoomIn(_sender:Any)
    {
        if let userLocation = mapView.userLocation.location?.coordinate {
            
            let region = MKCoordinateRegion(
                center: userLocation, latitudinalMeters: 2000, longitudinalMeters: 2000)
            
            mapView.setRegion(region, animated: true)
    }
    }
    
    @IBAction func changeMapType(_ sender: Any) {
        if mapView.mapType == MKMapType.standard {
            mapView.mapType = MKMapType.satellite
        } else {
            mapView.mapType = MKMapType.standard
        }
        
    }
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    func search()
    {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Mosque"
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occurred in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                }
            }
        })
    }
        
    func performSearch() {
            matchingItems.removeAll()
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "Mosque"
            request.region = mapView.region
            
            let search = MKLocalSearch(request: request)
            
            search.start(completionHandler: {(response, error) in
                
                if let results = response {
                    
                    if let err = error {
                        print("Error occurred in search: \(err.localizedDescription)")
                    } else if results.mapItems.count == 0 {
                        print("No matches found")
                    } else {
                        print("Matches found")
                        
                        for item in results.mapItems {
                            print("Name = \(item.name ?? "No match")")
                            print("Phone = \(item.phoneNumber ?? "No Match")")
                            
                            self.matchingItems.append(item as MKMapItem)
                           // print("Matching items = \(self.matchingItems.count)")
                            
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = item.placemark.coordinate
                            annotation.title = item.name
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                }
            })
        }
    
}
    
