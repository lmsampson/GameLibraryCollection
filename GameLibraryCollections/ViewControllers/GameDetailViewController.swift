//
//  GameDetailViewController.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/24/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import UIKit
import SDWebImage

class GameDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        
        coverImageView.image = nil
        
        if let game = game {
            
            if game.gameIsOwned == true {
                nameLabel.text = game.name
                summaryTextView.text = game.summary
                if let coverArt = game.coverArt {
                    coverImageView.sd_setImage(with: URL(string: "https:\(coverArt)"))
                }
                wishlistButton.isHidden = true
                ownedGamesButton.isHidden = true
                
            } else if game.gameIsOwned == false {
                nameLabel.text = game.name
                summaryTextView.text = game.summary
                if let coverArt = game.coverArt {
                    coverImageView.sd_setImage(with: URL(string: "https:\(coverArt)"))
                }
                wishlistButton.isHidden = true
                
            }
            
        } else if let gameRep = gameRep {
            nameLabel.text = gameRep.name
            summaryTextView.text = gameRep.summary
            if let coverArt = gameRep.coverArt {
                coverImageView.sd_setImage(with: URL(string: "https:\(coverArt)"))
            }
            
        } else {
            NSLog("Error: no game found.")
        }
    }

    @IBAction func wishlistButtonTapped(_ sender: Any) {
        guard let gameRep = gameRep else { return }
        gameController?.createWishlistGame(from: gameRep)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ownedButtonTapped(_ sender: Any) {
        
        if let game = game {
            gameController?.createOwnedGame(from: game)
            navigationController?.popViewController(animated: true)
            
        } else if let gameRep = gameRep {
            gameController?.createOwnedGame(from: gameRep)
            navigationController?.popViewController(animated: true)
            
        } else {
            NSLog("Error: no game found.")
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        let gameURL: URL
        if let game = game {
            gameURL = game.url!
        } else if let gameRep = gameRep {
            gameURL = gameRep.url
        } else {
            NSLog("Error: no game found.")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [gameURL], applicationActivities: [])
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityViewController, animated: true)
    }
    
    // MARK: - Properties and Outlets
    
    var gameController: GameController?
    var game: Game?
    var gameRep: GameRepresentation?
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var wishlistButton: UIButton!
    @IBOutlet weak var ownedGamesButton: UIButton!
    
}
