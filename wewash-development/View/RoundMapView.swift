//
//  RoundMapView.swift
//  wewash-development
//
//  Created by Salvador De la Rosa on 4/16/18.
//  Copyright © 2018 The W. All rights reserved.
//

import UIKit
import MapKit

class RoundMapView: MKMapView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 10.0
    }
}
