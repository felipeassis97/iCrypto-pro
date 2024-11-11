//
//  DownloadImage.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 11/11/2024.
//

import Foundation
    func downloadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            completion(.success(data ?? Data()))
        }.resume()
    }
