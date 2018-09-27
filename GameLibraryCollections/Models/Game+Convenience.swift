//
//  Game+Convenience.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/24/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import Foundation
import CoreData

extension Game {
    convenience init(name: String, coverArt: String?, summary: String?, identifier: Int64, url: URL, gameIsOwned: Bool, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.coverArt = coverArt
        self.identifier = identifier
        self.summary = summary
        self.gameIsOwned = gameIsOwned
        self.url = url
    }
    
    convenience init(gameRep: GameRepresentation, gameIsOwned: Bool, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        let name = gameRep.name
        let summary = gameRep.summary
        let identifier = gameRep.identifier
        let coverArt = gameRep.coverArt
        let url = gameRep.url
        
        self.init(name: name, coverArt: coverArt, summary: summary, identifier: identifier, url: url, gameIsOwned: gameIsOwned, context: context)
    }
}
