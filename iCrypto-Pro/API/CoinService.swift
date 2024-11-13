//
//  CoinService.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 12/11/2024.
//

import Foundation

enum CoinErrorService: Error {
    case serverError(CoinError)
    case unknownError(String = "An unknown error occured")
    case decodingError(String = "Error parsing server response")
}

class CoinService {
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping (Result<[Coin], CoinErrorService>) -> Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error 1: \(error.localizedDescription)")
                
                completion(.failure(.unknownError(error.localizedDescription)))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                //MARK: - Handle error
                do {
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    print("ServerError: \(coinError.errorMessage)")
                    completion(.failure(.serverError(coinError)))
                } catch let error {
                    completion(.failure(.unknownError()))
                    print(error.localizedDescription)
                }
            }
            
            if let data = data {
                do {
                    //Decode to generic dictionary and extract data from "data" key
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    if let dataArray = json?["data"] {
                        let jsonData = try JSONSerialization.data(withJSONObject: dataArray, options: [])
                        let decoder = JSONDecoder()
                        let coins = try decoder.decode([Coin].self, from: jsonData)
                        
                        completion(.success(coins))
                    } else {
                        completion(.failure(.decodingError("Missing 'data' key in JSON response")))
                    }
                } catch let error {
                    print("DecodeError: \(error.localizedDescription)")
                    completion(.failure(.decodingError()))
                }
            } else {
                print("UnknownError")
                completion(.failure(.unknownError()))
            }
        }.resume()
    }
}
