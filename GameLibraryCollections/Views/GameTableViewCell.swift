//
//  GameTableViewCell.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/25/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import UIKit
import SDWebImage

class GameTableViewCell: UITableViewCell {

    func updateViews() {
        guard let game = game else { return }
        
        gameLabel.text = game.name
        if let coverArt = game.coverArt {
            coverImageView.sd_setImage(with: URL(string: "https:\(coverArt)"))
        } else {
            coverImageView.image = UIImage(named: "Icon-1024")
        }
        
        coverImageView.makeImagePretty()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coverImageView.image = nil
        coverImageView.layer.borderWidth = 0
    }
    
    var game: Game? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!

}
