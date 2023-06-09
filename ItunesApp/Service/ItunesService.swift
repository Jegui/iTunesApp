//
//  ItunesAppApp.swift
//  ItunesApp
//
//  Created by Juan Emilio Eguizabal Ponchik on 08/01/2021.
//

import Foundation
import UIKit

protocol ItunesServiceDelegate: AnyObject {
  func itemsArrived(items: Array<ItunesItemResponse>)
  func itemsFailedToArrive(_ error: CustomError?)
}

protocol ItunesServiceType {
  func getItems()
  var delegate: ItunesServiceDelegate? {get set}
}

/**
 Contact service, it fetches contacts from backend or from a json file.
 */
class ItunesService: ItunesServiceType {
  
  ///Maybe I could move the requester code here...
  let requester: Requester<ItunesResponse>
  weak var delegate: ItunesServiceDelegate?
  
  
  ///This url should be obtained from an enum with endpoints, but as it is the only url, hardcoded it here for simplcitiy
  init(url: String) {
    self.requester = Requester<ItunesResponse>(url: url)
  }
  
  
  
  func getItems() {
    self.requester.getModelFromBackend { [weak self] (result) in
      switch result {
      case .success(let response):
          guard let uItems = response?.results else {
          self?.delegate?.itemsFailedToArrive(CustomError(description: "Nil Item response"))
          return
        }
        self?.delegate?.itemsArrived(items: uItems)
      case .failure(let error):
        self?.delegate?.itemsFailedToArrive(error)
      }
    }
  }
  
}
