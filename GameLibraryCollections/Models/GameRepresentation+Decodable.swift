//
//  GameRepresentation+Decodable.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/24/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import Foundation

extension GameRepresentation: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case summary
        case coverArt = "cover"
        case identifier = "id"
        case url
        
        enum CoverCodingKeys: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let summary = try container.decodeIfPresent(String.self, forKey: .summary)
        let identifier = try container.decode(Int64.self, forKey: .identifier)
        let url = try container.decode(URL.self, forKey: .url)
        
        var coverArt: String? = nil
        if let coverContainer = try? container.nestedContainer(keyedBy: CodingKeys.CoverCodingKeys.self, forKey: .coverArt) {
            coverArt = try coverContainer.decode(String.self, forKey: .url)
        }
        
        self.name = name
        self.summary = summary
        self.identifier = identifier
        self.coverArt = coverArt
        self.url = url
    }
}
