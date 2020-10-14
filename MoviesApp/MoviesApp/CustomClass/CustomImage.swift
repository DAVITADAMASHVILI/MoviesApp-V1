//
//  CustomImage.swift
//  MoviesApp
//
//  Created by DATA on 10/13/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import UIKit

class CustomImage : UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        roundCorners()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        roundCorners()
    }
    
    private func roundCorners(){
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
}
