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
    convenience init(name: String, coverArt: String, summary: String, identifier: Int16, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.coverArt = coverArt
        self.identifier = identifier
    }
    
    convenience init?(gameRep: GameRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        
        self.init(context: context)
    }
}
