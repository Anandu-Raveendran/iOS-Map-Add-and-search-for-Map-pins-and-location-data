//
//  MapViewController.swift
//  Anandu sem 2 final project
//
//  Created by Nandu on 2021-09-30.
//

import UIKit
import MapKit

class MapViewController: UIView {

    var selectedLocation:Location!
    var selectedindex:Int!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        mapview.delegate = self
//        updatePins()
//    }

    func updatePins(){
        selectedLocation = nil
        mapview.removeAnnotations(mapview.annotations)
        DataSource.fetchLocations()
        if let locations = DataSource.locations {
            mapview.showAnnotations(locations, animated: true)
        } else {
            print("NO locations to show on map")
        }
    }

    
    @objc func editLocationDetails(_ sender: UIButton){
        if let locations = DataSource.locations {
            selectedLocation = locations[sender.tag]
            selectedindex = sender.tag
        }
//        performSegue(withIdentifier: "ToEditSegue", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "ToEditSegue"){
//            let dest = segue.destination as! EditViewController
//            dest.callback = updatePins
//            dest.selectedPin = selectedLocation
//            dest.selectedIndex = selectedindex
//        }
//    }
}


extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Location else {
            print("return nil in mapview viewFor method")
            return nil
        }
        
        let identifier = "location"
        var annotationView = mapview.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.isEnabled = true
            pinView.canShowCallout = true
            pinView.animatesDrop = false
        //    pinView.pinTintColor = UIColor(red: 0.32, green: 0.82, blue: 0.4, alpha: 1)
            
            let righButton = UIButton(type: .detailDisclosure)
            righButton.addTarget(self, action: #selector(editLocationDetails), for: .touchUpInside)
            pinView.rightCalloutAccessoryView = righButton
            annotationView = pinView
        }
        
        if let annotationView = annotationView{
            annotationView.annotation = annotation
            let button = annotationView.rightCalloutAccessoryView as! UIButton
            if let locations = DataSource.locations{
                if let index = locations.firstIndex(of: annotation as! Location){
                    button.tag = index
                }
            }
        }
        return annotationView
    }
    
    
}
