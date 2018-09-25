//
//  GameTableViewCell.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/25/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    func updateViews() {
        guard let game = game else { return }
        
        gameLabel.text = game.name
        //coverImageView.image = game.coverArt
    }
    
    var game: Game? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!

}
