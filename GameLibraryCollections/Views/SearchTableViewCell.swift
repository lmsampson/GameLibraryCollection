//
//  SearchTableViewCell.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/24/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    func updateViews() {
        guard let game = gameRep else { return }
        
        gameLabel.text = game.name
        if let coverArt = game.coverArt {
            coverImageView.sd_setImage(with: URL(string: "https:\(coverArt)"))
        } else {
            coverImageView.image = UIImage(named: "Icon-1024")
        }
        
        coverImageView.layer.cornerRadius = coverImageView.frame.size.width / 2
        coverImageView.clipsToBounds = true
        
        var gameGreen = UIColor(red: 60.0/255.0, green: 213.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        coverImageView.layer.borderColor = gameGreen.cgColor
        coverImageView.layer.borderWidth = 4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coverImageView.image = nil
    }
    
    var gameRep: GameRepresentation? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
}
