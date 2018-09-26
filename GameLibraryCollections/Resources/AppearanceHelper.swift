//
//  AppearanceHelper.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/26/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import UIKit

enum Appearance {
    
    static var gameGreen = UIColor(red: 60.0/255.0, green: 213.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    
    static func setupAppearance() {
        
        UINavigationBar.appearance().barTintColor = gameGreen
        UINavigationBar.appearance().tintColor = .white
    }
}
