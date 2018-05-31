//
//  PassengerAnnotation.swift
//  wewash-development
//
//  Created by Salvador De la Rosa on 4/13/18.
//  Copyright © 2018 The W. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
