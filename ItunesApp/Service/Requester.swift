//
//  Requester.swift
//  TechnicalChallengeContactsApp
//
//  Created by Juan Emilio Eguizabal Ponchik on 08/01/2021.
//

import Foundation
import UIKit



/**
 A custom error just so we can initialize an error from a custom description, or from an error.
 */
struct CustomError: Error {
  let description: String
  
  init(description: String) {
    self.description = description
    print(self.description)
  }
  
  init(error: Error) {
    self.description = error.localizedDescription
  }
}

/**
 Requester class, it deals with bringing the json data from backend and parses it's response.
 For this app we have only one model we get from backend, but in an app with more models this class can be useful.
 */
final class Requester<Model> where Model: Codable {
  //MARK: In the future we may have an enum for the list of endpoints.
  private var url: String
  
  init(url: String) {
    self.url = url
  }
  
  ///Method to get a model from a local file.
  func getMockedModel(completion: @escaping (Result<Model?, CustomError>) -> Void) {
    if let jsonData = self.readLocalFile(name: "contacts") {
      self.parse(jsonData: jsonData, completion: completion)
    }
  }
  
  ///Method to get a model from backend
  func getModelFromBackend(completion: @escaping (Result<Model?, CustomError>) -> Void) {
    self.loadJson(fromURLString: self.url) {[weak self] result in
      switch result {
      case .success(let jsonData):
        self?.parse(jsonData: jsonData, completion: completion)
      case .failure(let error):
        completion(.failure( CustomError(error: error)))
      }
    }
  }

  /**
   We read data from a json file.
   */
  private func readLocalFile(name: String) -> Data? {
    var jsonData: Data?
    if let path = Bundle.main.path(forResource: "contacts", ofType: "json") {
      do {
        let fileUrl = URL(fileURLWithPath: path)
        jsonData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
        return jsonData
      } catch let error {
        print(error.localizedDescription)
      }
    }
   return nil
  }
  
  /**
   We fetch a json file from an URL string
   */
  
  
  private func loadJson(fromURLString urlString: String,
                        completion: @escaping (Result<Data, Error>) -> Void) {
    ///This is so odd and I can't explain it, but if I don't initialize the URL here, it comes back as nil in any other place in the app, that's why I can't test the fail repsonse in the test suit.
    /// I can't even do this: if let url = URL(string: urlString) and I don't know why
      if let url = URL(string: urlString) {
          let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
              if let error = error {
                  completion(.failure(error))
              }
              
              if let data = data {
                  completion(.success(data))
              }
          }
          urlSession.resume()
      }
  }
  
  /**
   Parse a model from Data
   */
  private func parse(jsonData: Data, completion: @escaping (Result<Model?, CustomError>) -> Void) {
    do {
      let decodedData = try JSONDecoder().decode(Model.self,
                                                 from: jsonData)
      completion(.success(decodedData))
      
    } catch let error {
      print("decode error")
      completion(.failure(CustomError(error: error)))
    }
  }
}
