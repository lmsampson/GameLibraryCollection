//
//  NetworkDataLoader.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/25/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    func loadData(using request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkDataLoader {
    func loadData(using request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        dataTask(with: request) { (data, _, error) in
            completion(data, error)
            }.resume()
    }
}
