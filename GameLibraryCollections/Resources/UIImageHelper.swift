//
//  UIImageHelper.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/27/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func makeImagePretty() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        
        let gameGreen = UIColor(red: 60.0/255.0, green: 213.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        self.layer.borderColor = gameGreen.cgColor
        self.layer.borderWidth = 4
    }
}
