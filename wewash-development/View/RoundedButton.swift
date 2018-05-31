//
//  RoundedButton.swift
//  wewash-development
//
//  Created by Salvador De la Rosa on 4/9/18.
//  Copyright © 2018 The W. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 8.0
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowRadius = 5.0
//        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
