//
//  GameRepresentation.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/24/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import Foundation

struct GameRepresentation: Equatable {
    let name: String
    let summary: String?
    let identifier: Int64
    let coverArt: String?
}

func ==(lhs: GameRepresentation, rhs: Game) -> Bool {
    return lhs.name == rhs.name &&
        lhs.summary == rhs.summary &&
        lhs.identifier == rhs.identifier &&
        lhs.coverArt == rhs.coverArt
}

func ==(lhs: Game, rhs: GameRepresentation) -> Bool {
    return rhs == lhs
}

func !=(lhs: GameRepresentation, rhs: Game) -> Bool {
    return !(rhs == lhs)
}

func !=(lhs: Game, rhs: GameRepresentation) -> Bool {
    return rhs != lhs
}
