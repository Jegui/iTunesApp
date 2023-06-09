//
//  ImageService.swift
//  TechnicalChallengeContactsApp
//
//  Created by Juan Emilio Eguizabal Ponchik on 09/01/2021.
//

import Foundation
import UIKit

class ImageService {
  
  /**
   Fetch an image from backend, returns an optional UIImage.
   */
  func fetchImage(fromURLString urlString: String,
                        completion: @escaping (Result<UIImage?, CustomError>) -> Void) {
    guard let validURL = URL(string: urlString) else {
      completion(.failure(CustomError(description: "InvalidURL: loadImage() method" + String(#file) + String(#line))))
      return
    }
    let task = URLSession.shared.dataTask(with: validURL) { data, response, error in
      if let error = error {
          completion(.failure(CustomError(error: error)))
      }
      
      if let data = data {
          completion(.success(UIImage(data: data)))
      }
    }
    task.resume()
  }
  
}
