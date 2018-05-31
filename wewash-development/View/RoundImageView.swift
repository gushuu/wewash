//
//  RoundImageView.swift
//  wewash-development
//
//  Created by Salvador De la Rosa on 4/9/18.
//  Copyright © 2018 The W. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView (){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
