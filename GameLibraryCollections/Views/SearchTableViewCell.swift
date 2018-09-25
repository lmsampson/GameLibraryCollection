//
//  SearchTableViewCell.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/24/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    func updateViews() {
        guard let game = gameRep else { return }
        
        gameLabel.text = game.name
        //coverImageView.image = game.coverArt
    }
    
    var gameRep: GameRepresentation? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
}
