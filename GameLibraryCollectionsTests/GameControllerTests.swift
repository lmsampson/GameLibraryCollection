//
//  GameControllerTests.swift
//  GameLibraryCollectionsTests
//
//  Created by Lisa Sampson on 9/25/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import XCTest
import CoreData
@testable import GameLibraryCollections

class MockDataLoader: NetworkDataLoader {
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    func loadData(using request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        self.request = request
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.data, self.error)
        }
        
    }
    
    var data: Data?
    let error: Error?
    private(set) var request: URLRequest? = nil
}

class GameControllerTests: XCTestCase {
    
    func testCreateOwnedGame() {
        let mock = MockDataLoader(data: nil, error: nil)
        let gameController = GameController(dataLoader: mock)
        let gameRep = GameRepresentation(name: "The Legend of Zelda: Majora's Mask", summary: "After the events of The Legend of Zelda: Ocarina of Time (1998), Link is assaulted by an imp named Skull Kid under the control of the evil Majora's Mask and gets stuck in a troubled land called Termina. Link must repeat the same 3 days, take on the identities of deceased people from other races, collect numerous masks and rid the land of evil to stop Majora from destroying the world in this third-person action/adventure game.", identifier: 1030, coverArt: "//images.igdb.com/igdb/image/upload/t_thumb/lwhx16pgr42djtjmnoji.jpg")
        
        gameController.createOwnedGame(from: gameRep)
        
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        do {
            let fetch = try CoreDataStack.shared.mainContext.fetch(fetchRequest)
            
            XCTAssertEqual(fetch[0].name, gameRep.name)
            XCTAssertEqual(fetch[0].summary, gameRep.summary)
            XCTAssertEqual(fetch[0].identifier, gameRep.identifier)
            XCTAssertEqual(fetch[0].coverArt, gameRep.coverArt)
        }
        catch {
            NSLog("Error")
        }
    }
    
    func testCreateOwnedGameFromWishlist() {
        let mock = MockDataLoader(data: nil, error: nil)
        let gameController = GameController(dataLoader: mock)
        let gameRep = GameRepresentation(name: "The Legend of Zelda: Majora's Mask", summary: "After the events of The Legend of Zelda: Ocarina of Time (1998), Link is assaulted by an imp named Skull Kid under the control of the evil Majora's Mask and gets stuck in a troubled land called Termina. Link must repeat the same 3 days, take on the identities of deceased people from other races, collect numerous masks and rid the land of evil to stop Majora from destroying the world in this third-person action/adventure game.", identifier: 1030, coverArt: "//images.igdb.com/igdb/image/upload/t_thumb/lwhx16pgr42djtjmnoji.jpg")
        let game = Game(gameRep: gameRep, gameIsOwned: true)
        
        gameController.createOwnedGame(from: game)
        
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        do {
            let fetch = try CoreDataStack.shared.mainContext.fetch(fetchRequest)
            
            XCTAssertEqual(fetch[0].name, game.name)
            XCTAssertEqual(fetch[0].summary, game.summary)
            XCTAssertEqual(fetch[0].identifier, game.identifier)
            XCTAssertEqual(fetch[0].coverArt, game.coverArt)
            XCTAssertEqual(fetch[0].gameIsOwned, game.gameIsOwned)
        }
        catch {
            NSLog("Error")
        }
    }
    
    func testCreateGameForWishlist() {
        let mock = MockDataLoader(data: nil, error: nil)
        let gameController = GameController(dataLoader: mock)
        let gameRep = GameRepresentation(name: "The Legend of Zelda: Majora's Mask", summary: "After the events of The Legend of Zelda: Ocarina of Time (1998), Link is assaulted by an imp named Skull Kid under the control of the evil Majora's Mask and gets stuck in a troubled land called Termina. Link must repeat the same 3 days, take on the identities of deceased people from other races, collect numerous masks and rid the land of evil to stop Majora from destroying the world in this third-person action/adventure game.", identifier: 1030, coverArt: "//images.igdb.com/igdb/image/upload/t_thumb/lwhx16pgr42djtjmnoji.jpg")
        
        gameController.createWishlistGame(from: gameRep)
        
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        do {
            let fetch = try CoreDataStack.shared.mainContext.fetch(fetchRequest)
            
            XCTAssertEqual(fetch[0].name, gameRep.name)
            XCTAssertEqual(fetch[0].summary, gameRep.summary)
            XCTAssertEqual(fetch[0].identifier, gameRep.identifier)
            XCTAssertEqual(fetch[0].coverArt, gameRep.coverArt)
        }
        catch {
            NSLog("Error")
        }
    }
    
    func testDeleteGame() {
        let mock = MockDataLoader(data: nil, error: nil)
        let gameController = GameController(dataLoader: mock)
        let gameRep = GameRepresentation(name: "The Legend of Zelda: Majora's Mask", summary: "After the events of The Legend of Zelda: Ocarina of Time (1998), Link is assaulted by an imp named Skull Kid under the control of the evil Majora's Mask and gets stuck in a troubled land called Termina. Link must repeat the same 3 days, take on the identities of deceased people from other races, collect numerous masks and rid the land of evil to stop Majora from destroying the world in this third-person action/adventure game.", identifier: 1030, coverArt: "//images.igdb.com/igdb/image/upload/t_thumb/lwhx16pgr42djtjmnoji.jpg")
        let game = Game(gameRep: gameRep, gameIsOwned: true)
        gameController.createOwnedGame(from: game)
        
        gameController.delete(game: game)
        
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        do {
            let fetch = try CoreDataStack.shared.mainContext.fetch(fetchRequest)
            
            XCTAssertEqual(fetch, [])
        }
        catch {
            NSLog("Error")
        }
    }
    
    func testSearchForGame() {
        let mock = MockDataLoader(data: gameJSON, error: nil)
        let gameController = GameController(dataLoader: mock)
        
        let expectation = self.expectation(description: "Search For Game")
        
        gameController.searchForGame(with: "The Legend of Zelda: Majora's Mask") {_ in
            XCTAssertNotNil(mock.request)
            
            let testComponents = URLComponents(url: URL(string: "https://api-endpoint.igdb.com/games/?search=The%20Legend%20of%20Zelda:%20Majora's%20Mask&fields=name,summary,cover.url&limit=50")!, resolvingAgainstBaseURL: true)!
            let components = URLComponents(url: mock.request!.url!, resolvingAgainstBaseURL: true)!
            XCTAssertTrue(urlComponents(components, equalTo: testComponents))
            
            XCTAssertEqual(gameController.searchedGames.count, 1)
            
            if let firstObject = gameController.searchedGames.first {
                XCTAssertEqual(firstObject.name, "The Legend of Zelda: Majora's Mask")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

func urlComponents(_ components1: URLComponents, equalTo components2: URLComponents) -> Bool {
    var scratch1 = components1
    var scratch2 = components2
    
    scratch1.queryItems = []
    scratch2.queryItems = []
    if scratch1 != scratch2 {
        return false
    }
    
    //Compare Query items
    if let queryItems1 = components1.queryItems,
        let queryItems2 = components2.queryItems {
        if Set(queryItems1) != Set(queryItems2) {
            return false
        }
    }
    return true
}
